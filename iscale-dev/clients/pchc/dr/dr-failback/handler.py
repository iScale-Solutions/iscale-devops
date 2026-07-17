import json
import logging
import time
import boto3
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)


# ---------------------------------------------------------------------------
# CFN dict/JSON-string → YAML converter
# ---------------------------------------------------------------------------

def _cfn_to_yaml(obj, _depth=0):
    """
    Convert a CloudFormation template dict (or JSON-string) to YAML text.
    Uses long-form intrinsics (Fn::Sub, Fn::If, Ref …) which are valid CFN YAML.
    No third-party dependencies — stdlib json used only for string quoting.
    """
    import json as _j

    if isinstance(obj, str):
        obj = _j.loads(obj)

    def _key(k):
        s = str(k)
        if not s or ': ' in s or s[0] in '!&*[{|>\'"':
            return _j.dumps(s)
        return s

    def _scalar(v):
        if v is None:             return 'null'
        if isinstance(v, bool):   return 'true' if v else 'false'
        if isinstance(v, (int, float)): return str(v)
        s = str(v)
        if not s: return '""'
        if (any(c in s for c in ':#{}[]!,&*|>\'"') or
                s[0] in ' -?' or s[-1] == ' ' or '\n' in s or
                s.lower() in ('true', 'false', 'null', 'yes', 'no', 'on', 'off')):
            return _j.dumps(s)
        try:
            float(s)
            return _j.dumps(s)
        except ValueError:
            pass
        return s

    def _node(o, d):
        p = '  ' * d
        if isinstance(o, dict):
            parts = []
            for k, v in o.items():
                ks = _key(k)
                if isinstance(v, (dict, list)):
                    if v:
                        parts.append(f'{p}{ks}:')
                        parts.append(_node(v, d + 1))
                    else:
                        parts.append(f'{p}{ks}: {{}}' if isinstance(v, dict) else f'{p}{ks}: []')
                elif isinstance(v, bool):
                    parts.append(f'{p}{ks}: {"true" if v else "false"}')
                elif v is None:
                    parts.append(f'{p}{ks}: null')
                elif isinstance(v, (int, float)):
                    parts.append(f'{p}{ks}: {v}')
                else:
                    parts.append(f'{p}{ks}: {_scalar(str(v))}')
            return '\n'.join(parts)
        # list
        parts = []
        for item in o:
            if isinstance(item, dict) and item:
                kvs = list(item.items())
                fk, fv = _key(str(kvs[0][0])), kvs[0][1]
                if isinstance(fv, (dict, list)) and fv:
                    parts.append(f'{p}- {fk}:')
                    parts.append(_node(fv, d + 2))
                elif isinstance(fv, bool):
                    parts.append(f'{p}- {fk}: {"true" if fv else "false"}')
                elif fv is None:
                    parts.append(f'{p}- {fk}: null')
                elif isinstance(fv, (int, float)):
                    parts.append(f'{p}- {fk}: {fv}')
                else:
                    parts.append(f'{p}- {fk}: {_scalar(str(fv))}')
                cp = p + '  '
                for rk, rv in kvs[1:]:
                    rks = _key(str(rk))
                    if isinstance(rv, (dict, list)) and rv:
                        parts.append(f'{cp}{rks}:')
                        parts.append(_node(rv, d + 2))
                    elif isinstance(rv, bool):
                        parts.append(f'{cp}{rks}: {"true" if rv else "false"}')
                    elif rv is None:
                        parts.append(f'{cp}{rks}: null')
                    elif isinstance(rv, (int, float)):
                        parts.append(f'{cp}{rks}: {rv}')
                    else:
                        parts.append(f'{cp}{rks}: {_scalar(str(rv))}')
            elif isinstance(item, list) and item:
                parts.append(f'{p}-')
                parts.append(_node(item, d + 1))
            elif isinstance(item, bool):
                parts.append(f'{p}- {"true" if item else "false"}')
            elif item is None:
                parts.append(f'{p}- null')
            elif isinstance(item, (int, float)):
                parts.append(f'{p}- {item}')
            else:
                parts.append(f'{p}- {_scalar(str(item))}')
        return '\n'.join(parts)

    return _node(obj, _depth)


def _fetch_as_yaml(cfn, stack_name: str) -> str:
    """
    Fetch the stack template and always return it as a YAML string.
    Converts dict or JSON-string responses to YAML so CloudFormation
    never normalises the stored template to JSON on subsequent updates.
    """
    resp = cfn.get_template(StackName=stack_name, TemplateStage='Original')
    body = resp['TemplateBody']

    if isinstance(body, dict):
        logger.info("[FETCH_TEMPLATE] Returned as dict — converting to YAML | stack=%s", stack_name)
        return _cfn_to_yaml(body)

    if body.lstrip().startswith('{'):
        logger.info("[FETCH_TEMPLATE] Returned as JSON string — converting to YAML | stack=%s", stack_name)
        return _cfn_to_yaml(body)

    logger.info("[FETCH_TEMPLATE] Returned as YAML string | stack=%s", stack_name)
    return body


# ---------------------------------------------------------------------------
# YAML text-level helpers
# ---------------------------------------------------------------------------

def _comment_line(line: str) -> str:
    ending = ''
    content = line
    if content.endswith('\r\n'):
        ending, content = '\r\n', content[:-2]
    elif content.endswith('\n'):
        ending, content = '\n', content[:-1]
    elif content.endswith('\r'):
        ending, content = '\r', content[:-1]
    stripped = content.lstrip(' ')
    indent = len(content) - len(stripped)
    return ' ' * indent + '# ' + stripped + ending


def _uncomment_line(line: str) -> str:
    ending = ''
    content = line
    if content.endswith('\r\n'):
        ending, content = '\r\n', content[:-2]
    elif content.endswith('\n'):
        ending, content = '\n', content[:-1]
    elif content.endswith('\r'):
        ending, content = '\r', content[:-1]
    stripped = content.lstrip(' ')
    indent = len(content) - len(stripped)
    if stripped.startswith('# '):
        return ' ' * indent + stripped[2:] + ending
    return line


# ---------------------------------------------------------------------------
# State machine patcher (shared by comment + uncomment)
# ---------------------------------------------------------------------------

def _patch_cfn_parameter(template_body: str, param_key: str, comment: bool) -> str:
    """
    Single-pass state machine that walks every *ServerStack resource and either
    comments out or restores param_key (plus its multi-line continuation lines).
    Idempotent — passes through unchanged if already in the desired state.
    """
    SEARCHING, IN_RESOURCE, IN_PROPS, IN_PARAMS, PATCHING = range(5)

    target     = f'{param_key}:'  if comment else f'# {param_key}:'
    patch_line = _comment_line    if comment else _uncomment_line

    state = SEARCHING
    resource_indent = props_indent = params_indent = key_indent = 0
    result = []

    for line in template_body.splitlines(keepends=True):
        raw      = line.rstrip('\r\n')
        stripped = raw.lstrip()
        indent   = len(raw) - len(stripped)
        is_blank = not stripped

        if state == SEARCHING:
            if not is_blank and stripped.endswith('ServerStack:'):
                state = IN_RESOURCE
                resource_indent = indent
            result.append(line)

        elif state == IN_RESOURCE:
            if not is_blank and indent <= resource_indent:
                if stripped.endswith('ServerStack:'):
                    resource_indent = indent
                    props_indent = params_indent = key_indent = 0
                else:
                    state = SEARCHING
                result.append(line)
                continue
            if stripped == 'Properties:' and indent > resource_indent:
                state = IN_PROPS
                props_indent = indent
            result.append(line)

        elif state == IN_PROPS:
            if not is_blank and indent <= resource_indent:
                if stripped.endswith('ServerStack:'):
                    state = IN_RESOURCE
                    resource_indent = indent
                    props_indent = params_indent = key_indent = 0
                else:
                    state = SEARCHING
                result.append(line)
                continue
            if not is_blank and indent <= props_indent:
                state = IN_RESOURCE
                result.append(line)
                continue
            if stripped == 'Parameters:' and indent > props_indent:
                state = IN_PARAMS
                params_indent = indent
            result.append(line)

        elif state == IN_PARAMS:
            if not is_blank and indent <= resource_indent:
                if stripped.endswith('ServerStack:'):
                    state = IN_RESOURCE
                    resource_indent = indent
                    props_indent = params_indent = key_indent = 0
                else:
                    state = SEARCHING
                result.append(line)
                continue
            if not is_blank and indent <= props_indent:
                state = IN_RESOURCE
                result.append(line)
                continue
            if not is_blank and indent <= params_indent:
                state = IN_PROPS
                result.append(line)
                continue
            if stripped.startswith(target) and indent > params_indent:
                state = PATCHING
                key_indent = indent
                result.append(patch_line(line))
                continue
            result.append(line)

        elif state == PATCHING:
            if is_blank or indent <= key_indent:
                state = IN_PARAMS
                result.append(line)
            else:
                result.append(patch_line(line))

    return ''.join(result)


# ---------------------------------------------------------------------------
# Shared helpers
# ---------------------------------------------------------------------------

def _get_app_name(event: dict) -> str:
    app_name = (
        event.get('app_name')
        or event.get('AppName')
        or event.get('stack_name')
        or event.get('StackName')
    )
    if not app_name:
        raise ValueError("Event must contain 'app_name'")
    return app_name


def _get_current_parameters(cfn, stack_name: str) -> list:
    resp = cfn.describe_stacks(StackName=stack_name)
    return resp['Stacks'][0].get('Parameters', [])


def _submit_deploy_paid_false(cfn, stack_name: str, preserve_format: bool = True, template_url: str = None) -> dict:
    params = []
    for p in _get_current_parameters(cfn, stack_name):
        if p['ParameterKey'] == 'DeployPaidResources':
            logger.info("[SET_DEPLOY_PAID_FALSE] Current value=%s | stack=%s", p['ParameterValue'], stack_name)
            params.append({'ParameterKey': 'DeployPaidResources', 'ParameterValue': 'false'})
        else:
            params.append({'ParameterKey': p['ParameterKey'], 'UsePreviousValue': True})

    if template_url:
        # S3 URL — no size limit, CloudFormation fetches directly.
        update_kwargs = dict(
            StackName=stack_name,
            TemplateURL=template_url,
            Parameters=params,
            Capabilities=['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM', 'CAPABILITY_AUTO_EXPAND'],
        )
    elif preserve_format:
        # Resubmit the template as YAML so CFN does not normalise it to JSON.
        # Required when a subsequent comment/uncomment step reads the template.
        template_body = _fetch_as_yaml(cfn, stack_name)
        update_kwargs = dict(
            StackName=stack_name,
            TemplateBody=template_body,
            Parameters=params,
            Capabilities=['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM', 'CAPABILITY_AUTO_EXPAND'],
        )
    else:
        # No subsequent step reads this template — UsePreviousTemplate is safe
        # and avoids the 51,200-byte TemplateBody size limit entirely.
        update_kwargs = dict(
            StackName=stack_name,
            UsePreviousTemplate=True,
            Parameters=params,
            Capabilities=['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM', 'CAPABILITY_AUTO_EXPAND'],
        )

    try:
        cfn.update_stack(**update_kwargs)
        logger.info("[SET_DEPLOY_PAID_FALSE] Update submitted | stack=%s", stack_name)
        return {'submitted': True}
    except ClientError as e:
        code = e.response['Error']['Code']
        msg  = e.response['Error']['Message']
        if code == 'ValidationError' and 'No updates are to be performed' in msg:
            logger.info("[SET_DEPLOY_PAID_FALSE] Already false | stack=%s", stack_name)
            return {'submitted': False, 'reason': 'already_false'}
        raise


def _get_stack_status(cfn, stack_name: str) -> dict:
    """Describe one stack and return {status, complete, rollback}."""
    TERMINAL_STATES = {
        'CREATE_COMPLETE', 'UPDATE_COMPLETE',
        'UPDATE_ROLLBACK_COMPLETE', 'UPDATE_ROLLBACK_FAILED',
        'ROLLBACK_COMPLETE', 'ROLLBACK_FAILED',
        'DELETE_COMPLETE', 'DELETE_FAILED', 'CREATE_FAILED',
    }
    ROLLBACK_STATES = {
        'UPDATE_ROLLBACK_COMPLETE', 'UPDATE_ROLLBACK_FAILED',
        'ROLLBACK_COMPLETE', 'ROLLBACK_FAILED',
        'DELETE_FAILED', 'CREATE_FAILED',
    }
    try:
        resp   = cfn.describe_stacks(StackName=stack_name)
        status = resp['Stacks'][0]['StackStatus']
    except ClientError as e:
        logger.warning("[GET_STATUS] Could not describe stack | stack=%s | error=%s", stack_name, e)
        return {'status': 'UNKNOWN', 'complete': False, 'rollback': False}
    complete = status in TERMINAL_STATES
    rollback = status in ROLLBACK_STATES
    return {'status': status, 'complete': complete, 'rollback': rollback}


# ---------------------------------------------------------------------------
# Action: comment / uncomment
# ---------------------------------------------------------------------------

def _upload_template_to_s3(template_body: str, stack_name: str, action: str) -> str:
    import os
    region = os.environ.get('AWS_REGION', 'us-east-2')
    bucket = os.environ.get('TEMP_TEMPLATE_BUCKET', '')
    if not bucket:
        raise ValueError('TEMP_TEMPLATE_BUCKET environment variable not set')
    key = f'failback/{stack_name}/{action}.yaml'
    s3 = boto3.client('s3', region_name=region)
    s3.put_object(Bucket=bucket, Key=key, Body=template_body.encode('utf-8'), ContentType='text/plain')
    url = f'https://{bucket}.s3.{region}.amazonaws.com/{key}'
    logger.info("[S3_UPLOAD] Uploaded patched template | bucket=%s | key=%s", bucket, key)
    return url


def _handle_patch(event: dict, action: str) -> dict:
    """Fetch template as YAML, patch it, upload to S3, return template_s3_url + whether a change was made."""
    app_name = _get_app_name(event)
    logger.info("[PATCH] Start | stack=%s | action=%s", app_name, action)

    cfn = boto3.client('cloudformation')
    template_body = _fetch_as_yaml(cfn, app_name)
    logger.info("[PATCH] Template ready | size=%d chars | stack=%s", len(template_body), app_name)

    modified = _patch_cfn_parameter(
        template_body,
        param_key='LoadBalancerStackName',
        comment=(action == 'comment'),
    )

    patched = modified != template_body
    logger.info("[PATCH] Result | patched=%s | stack=%s | action=%s", patched, app_name, action)

    if not patched:
        logger.info("[PATCH] No changes — template already in desired state | stack=%s | action=%s", app_name, action)

    # Upload to S3 so update_stack can use TemplateURL (bypasses 51,200-byte TemplateBody API limit)
    template_s3_url = _upload_template_to_s3(modified, app_name, action)

    return {
        'stack_name': app_name,
        'action': action,
        'patched': patched,
        'template_s3_url': template_s3_url,
    }


# ---------------------------------------------------------------------------
# Action: update_stack  (apply patched template body)
# ---------------------------------------------------------------------------

def _handle_update_stack(event: dict) -> dict:
    """Submit UpdateStack with the patched template via S3 URL. All parameters preserved via UsePreviousValue."""
    app_name = _get_app_name(event)
    template_s3_url = event.get('template_s3_url')
    if not template_s3_url:
        raise ValueError("update_stack action requires 'template_s3_url' in the event")

    logger.info("[UPDATE_STACK] Submitting template update | stack=%s | url=%s", app_name, template_s3_url)

    cfn = boto3.client('cloudformation')
    current_params = _get_current_parameters(cfn, app_name)
    parameters = [
        {'ParameterKey': p['ParameterKey'], 'UsePreviousValue': True}
        for p in current_params
    ]

    try:
        cfn.update_stack(
            StackName=app_name,
            TemplateURL=template_s3_url,
            Parameters=parameters,
            Capabilities=['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM', 'CAPABILITY_AUTO_EXPAND'],
        )
        logger.info("[UPDATE_STACK] Submitted successfully | stack=%s", app_name)
        return {'submitted': True, 'stack_name': app_name}

    except ClientError as e:
        code = e.response['Error']['Code']
        msg  = e.response['Error']['Message']
        if code == 'ValidationError' and 'No updates are to be performed' in msg:
            logger.info("[UPDATE_STACK] No resource changes needed | stack=%s", app_name)
            return {'submitted': False, 'reason': 'no_resource_changes_needed', 'stack_name': app_name}
        raise


# ---------------------------------------------------------------------------
# Action: set_deploy_paid_false  (parameter-only update, YAML template preserved)
# ---------------------------------------------------------------------------

def _handle_set_deploy_paid_false(event: dict) -> dict:
    app_name = _get_app_name(event)
    preserve_format = event.get('preserve_format', True)
    template_url = event.get('template_url')
    logger.info("[SET_DEPLOY_PAID_FALSE] Start | stack=%s | preserve_format=%s | template_url=%s",
                app_name, preserve_format, bool(template_url))

    cfn = boto3.client('cloudformation')
    result = _submit_deploy_paid_false(cfn, app_name, preserve_format=preserve_format, template_url=template_url)

    if result['submitted']:
        return {'submitted': True, 'stack_name': app_name}
    return {'submitted': False, 'reason': result.get('reason', 'already_false'), 'stack_name': app_name}


# ---------------------------------------------------------------------------
# Action: set_deploy_paid_false_both  (submit both stacks)
# ---------------------------------------------------------------------------

def _handle_set_deploy_paid_false_both(event: dict) -> dict:
    app_name      = _get_app_name(event)
    network_stack = event.get('network_stack_name') or f'{app_name}-network'

    logger.info("[SET_DEPLOY_PAID_FALSE_BOTH] Start | app=%s | network=%s", app_name, network_stack)

    cfn = boto3.client('cloudformation')

    app_result     = _submit_deploy_paid_false(cfn, app_name)
    network_result = _submit_deploy_paid_false(cfn, network_stack)

    logger.info(
        "[SET_DEPLOY_PAID_FALSE_BOTH] Done | app_submitted=%s | network_submitted=%s",
        app_result['submitted'], network_result['submitted'],
    )

    return {
        'app_name':           app_name,
        'network_stack_name': network_stack,
        'app_submitted':      app_result['submitted'],
        'network_submitted':  network_result['submitted'],
    }


# ---------------------------------------------------------------------------
# Action: check_stack_status
# ---------------------------------------------------------------------------

TERMINAL_STATES = {
    'CREATE_COMPLETE', 'UPDATE_COMPLETE',
    'UPDATE_ROLLBACK_COMPLETE', 'UPDATE_ROLLBACK_FAILED',
    'ROLLBACK_COMPLETE', 'ROLLBACK_FAILED',
    'DELETE_COMPLETE', 'DELETE_FAILED', 'CREATE_FAILED',
}

ROLLBACK_STATES = {
    'UPDATE_ROLLBACK_COMPLETE', 'UPDATE_ROLLBACK_FAILED',
    'ROLLBACK_COMPLETE', 'ROLLBACK_FAILED',
    'DELETE_FAILED', 'CREATE_FAILED',
}

def _handle_check_stack_status(event: dict) -> dict:
    app_name = _get_app_name(event)

    cfn = boto3.client('cloudformation')
    try:
        resp   = cfn.describe_stacks(StackName=app_name)
        status = resp['Stacks'][0]['StackStatus']
    except ClientError as e:
        logger.warning("[CHECK_STATUS] Could not describe stack | stack=%s | error=%s", app_name, e)
        return {'update_complete': False, 'rollback_occurred': False, 'status': 'UNKNOWN', 'stack_name': app_name}

    complete = status in TERMINAL_STATES
    rollback = status in ROLLBACK_STATES

    if rollback:
        logger.error("[CHECK_STATUS] ROLLBACK/FAILURE | stack=%s | status=%s", app_name, status)
    elif complete:
        logger.info("[CHECK_STATUS] COMPLETE | stack=%s | status=%s", app_name, status)
    else:
        logger.info("[CHECK_STATUS] IN PROGRESS | stack=%s | status=%s", app_name, status)

    return {
        'update_complete': complete,
        'rollback_occurred': rollback,
        'status': status,
        'stack_name': app_name,
    }


# ---------------------------------------------------------------------------
# Action: check_both_stacks_status
# ---------------------------------------------------------------------------

def _handle_check_both_stacks_status(event: dict) -> dict:
    app_name      = _get_app_name(event)
    network_stack = event.get('network_stack_name') or f'{app_name}-network'

    logger.info("[CHECK_BOTH_STATUS] Checking | app=%s | network=%s", app_name, network_stack)

    cfn = boto3.client('cloudformation')

    app_s     = _get_stack_status(cfn, app_name)
    network_s = _get_stack_status(cfn, network_stack)

    any_rollback  = app_s['rollback'] or network_s['rollback']
    both_complete = app_s['complete'] and network_s['complete']

    logger.info(
        "[CHECK_BOTH_STATUS] app=%s(%s) network=%s(%s) | both_complete=%s | any_rollback=%s",
        app_name, app_s['status'], network_stack, network_s['status'],
        both_complete, any_rollback,
    )

    return {
        'app_name':           app_name,
        'network_stack_name': network_stack,
        'app_status':         app_s['status'],
        'network_status':     network_s['status'],
        'both_complete':      both_complete,
        'any_rollback':       any_rollback,
    }


# ---------------------------------------------------------------------------
# Action: set_asg_capacity (failback teardown — mirrors dr-failover-v2's
# set_asg_capacity action so ASGs are explicitly scaled to zero, not left at
# their out-of-band failover capacity. CloudFormation alone will not do this:
# pesonet20.yaml's ASGDesiredSize is a static !If [IsDR, 0, ...] that never
# changes value across a failback UpdateStack, so CFN sees no diff on that
# property and leaves the ASG's actual (drifted) capacity untouched.)
# ---------------------------------------------------------------------------

def _find_asg_from_stack_name(region: str, stack_name: str) -> str:
    """Find AppServerAutoScalingGroup physical ID from a CFN stack whose name contains stack_name."""
    cf = boto3.client('cloudformation', region_name=region)
    target = None
    kwargs = {'StackStatusFilter': [
        'CREATE_COMPLETE', 'UPDATE_COMPLETE', 'UPDATE_ROLLBACK_COMPLETE',
    ]}
    while True:
        resp = cf.list_stacks(**kwargs)
        for s in resp.get('StackSummaries', []):
            if stack_name in s['StackName']:
                target = s['StackName']
                break
        if target or not resp.get('NextToken'):
            break
        kwargs['NextToken'] = resp['NextToken']
    if not target:
        raise Exception(f'No active CFN stack found containing: {stack_name}')
    rk = {}
    while True:
        rr = cf.list_stack_resources(StackName=target, **rk)
        for res in rr.get('StackResourceSummaries', []):
            if res['LogicalResourceId'] == 'AppServerAutoScalingGroup':
                return res['PhysicalResourceId']
        if not rr.get('NextToken'):
            break
        rk['NextToken'] = rr['NextToken']
    raise Exception(f'AppServerAutoScalingGroup resource not found in stack: {target}')


def _handle_set_asg_capacity(event: dict) -> dict:
    """Same action/defaults as dr-failover-v2's set_asg_capacity — min/desired/max
    default to 0, so a failback asg_configs entry needs only asg_name or
    server_stack_name to scale that ASG down."""
    import os
    inp              = event.get('input', event)
    region           = os.environ.get('AWS_REGION', 'us-east-2')
    asg_name         = inp.get('asg_name', '')
    stack_name       = inp.get('server_stack_name', '')
    min_size         = int(inp.get('min_size', 0))
    desired_capacity = int(inp.get('desired_capacity', 0))
    max_size         = int(inp.get('max_size', desired_capacity))
    if not asg_name and not stack_name:
        raise ValueError('asg_name or server_stack_name is required for set_asg_capacity')
    if not asg_name:
        asg_name = _find_asg_from_stack_name(region, stack_name)
        logger.info("[SET_ASG_CAPACITY] Discovered ASG=%s | stack_name_contains=%s", asg_name, stack_name)
    asg = boto3.client('autoscaling', region_name=region)
    asg.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=min_size,
        MaxSize=max_size,
        DesiredCapacity=desired_capacity,
    )
    logger.info("[SET_ASG_CAPACITY] ASG=%s | min=%d desired=%d max=%d", asg_name, min_size, desired_capacity, max_size)
    return {
        'asg_name':         asg_name,
        'min_size':         min_size,
        'desired_capacity': desired_capacity,
        'max_size':         max_size,
    }


# ---------------------------------------------------------------------------
# Action: PITR DB / EFS cleanup (failback for PITR-mode failovers)
# ---------------------------------------------------------------------------
# The PITR RDS instance and the AWS-Backup-restored EFS file system are both
# created out-of-band by the failover Lambda (boto3 calls, not CFN resources)
# — see dr-failover-v2/handler.py _restore_db / _restore_efs. Neither is
# covered by any stack's DeletionPolicy, so failback must snapshot + delete
# them explicitly. Only run when the failback payload has use_pitr=true.

def _handle_snapshot_pitr_db(event: dict) -> dict:
    pitr_id = event.get('pitr_target_identifier')
    if not pitr_id:
        raise ValueError("snapshot_pitr_db requires 'pitr_target_identifier'")

    rds = boto3.client('rds')
    try:
        rds.describe_db_instances(DBInstanceIdentifier=pitr_id)
    except ClientError as e:
        if e.response['Error']['Code'] == 'DBInstanceNotFound':
            logger.info("[SNAPSHOT_PITR_DB] Instance not found — nothing to snapshot | id=%s", pitr_id)
            return {'submitted': False, 'reason': 'not_found'}
        raise

    snapshot_id = f'{pitr_id}-failback-{int(time.time())}'
    rds.create_db_snapshot(DBSnapshotIdentifier=snapshot_id, DBInstanceIdentifier=pitr_id)
    logger.info("[SNAPSHOT_PITR_DB] Snapshot started | id=%s | snapshot=%s", pitr_id, snapshot_id)
    return {'submitted': True, 'snapshot_id': snapshot_id, 'db_instance_identifier': pitr_id}


def _handle_check_pitr_snapshot_status(event: dict) -> dict:
    snapshot_id = event.get('snapshot_id')
    if not snapshot_id:
        raise ValueError("check_pitr_snapshot_status requires 'snapshot_id'")

    rds = boto3.client('rds')
    resp = rds.describe_db_snapshots(DBSnapshotIdentifier=snapshot_id)
    status = resp['DBSnapshots'][0]['Status']
    complete = status == 'available'
    failed = status in ('failed', 'incompatible-restore', 'incompatible-parameters')

    logger.info("[CHECK_PITR_SNAPSHOT] id=%s | status=%s | complete=%s", snapshot_id, status, complete)
    return {'status': status, 'complete': complete, 'failed': failed, 'snapshot_id': snapshot_id}


def _handle_delete_pitr_db(event: dict) -> dict:
    pitr_id = event.get('pitr_target_identifier')
    if not pitr_id:
        raise ValueError("delete_pitr_db requires 'pitr_target_identifier'")

    rds = boto3.client('rds')
    try:
        # SkipFinalSnapshot=True — the manual snapshot was already taken in
        # snapshot_pitr_db, so a second automatic snapshot here is redundant.
        rds.delete_db_instance(DBInstanceIdentifier=pitr_id, SkipFinalSnapshot=True)
        logger.info("[DELETE_PITR_DB] Delete submitted | id=%s", pitr_id)
        return {'submitted': True, 'db_instance_identifier': pitr_id}
    except ClientError as e:
        code = e.response['Error']['Code']
        if code == 'DBInstanceNotFound':
            logger.info("[DELETE_PITR_DB] Already deleted | id=%s", pitr_id)
            return {'submitted': False, 'reason': 'not_found', 'db_instance_identifier': pitr_id}
        if code == 'InvalidDBInstanceState':
            logger.info("[DELETE_PITR_DB] Already deleting | id=%s | msg=%s", pitr_id, e.response['Error']['Message'])
            return {'submitted': False, 'reason': 'already_deleting', 'db_instance_identifier': pitr_id}
        raise


def _handle_check_pitr_db_deleted(event: dict) -> dict:
    pitr_id = event.get('pitr_target_identifier')
    if not pitr_id:
        raise ValueError("check_pitr_db_deleted requires 'pitr_target_identifier'")

    rds = boto3.client('rds')
    try:
        resp = rds.describe_db_instances(DBInstanceIdentifier=pitr_id)
        status = resp['DBInstances'][0]['DBInstanceStatus']
        logger.info("[CHECK_PITR_DB_DELETED] id=%s | status=%s", pitr_id, status)
        return {'deleted': False, 'status': status}
    except ClientError as e:
        if e.response['Error']['Code'] == 'DBInstanceNotFound':
            logger.info("[CHECK_PITR_DB_DELETED] Confirmed deleted | id=%s", pitr_id)
            return {'deleted': True, 'status': 'DELETED'}
        raise


def _handle_delete_pitr_efs_mount_targets(event: dict) -> dict:
    ssm_path = event.get('efs_id_ssm_path')
    if not ssm_path:
        logger.info("[DELETE_PITR_EFS] No efs_id_ssm_path in payload — nothing to clean up.")
        return {'submitted': False, 'reason': 'no_ssm_path'}

    ssm = boto3.client('ssm')
    try:
        efs_id = ssm.get_parameter(Name=ssm_path)['Parameter']['Value']
    except ClientError as e:
        if e.response['Error']['Code'] == 'ParameterNotFound':
            logger.info("[DELETE_PITR_EFS] No SSM parameter — nothing to clean up | path=%s", ssm_path)
            return {'submitted': False, 'reason': 'not_found'}
        raise

    if not efs_id:
        return {'submitted': False, 'reason': 'empty_efs_id'}

    efs = boto3.client('efs')
    try:
        mount_targets = efs.describe_mount_targets(FileSystemId=efs_id).get('MountTargets', [])
    except ClientError as e:
        if e.response['Error']['Code'] == 'FileSystemNotFound':
            logger.info("[DELETE_PITR_EFS] Filesystem already gone | efs_id=%s", efs_id)
            return {'submitted': False, 'reason': 'fs_not_found', 'efs_id': efs_id}
        raise

    for mt in mount_targets:
        try:
            efs.delete_mount_target(MountTargetId=mt['MountTargetId'])
            logger.info("[DELETE_PITR_EFS] Deleting mount target %s | efs_id=%s", mt['MountTargetId'], efs_id)
        except ClientError as e:
            if e.response['Error']['Code'] != 'MountTargetNotFound':
                raise

    return {'submitted': True, 'efs_id': efs_id}


def _handle_check_pitr_efs_mount_targets_deleted(event: dict) -> dict:
    efs_id = event.get('efs_id')
    if not efs_id:
        raise ValueError("check_pitr_efs_mount_targets_deleted requires 'efs_id'")

    efs = boto3.client('efs')
    try:
        remaining = efs.describe_mount_targets(FileSystemId=efs_id).get('MountTargets', [])
    except ClientError as e:
        if e.response['Error']['Code'] == 'FileSystemNotFound':
            return {'deleted': True, 'efs_id': efs_id}
        raise

    deleted = len(remaining) == 0
    logger.info("[CHECK_PITR_EFS_MT] efs_id=%s | remaining=%d", efs_id, len(remaining))
    return {'deleted': deleted, 'efs_id': efs_id}


def _handle_delete_pitr_efs_filesystem(event: dict) -> dict:
    efs_id = event.get('efs_id')
    ssm_path = event.get('efs_id_ssm_path')
    if not efs_id:
        raise ValueError("delete_pitr_efs_filesystem requires 'efs_id'")

    efs = boto3.client('efs')
    try:
        efs.delete_file_system(FileSystemId=efs_id)
        logger.info("[DELETE_PITR_EFS_FS] Deleted | efs_id=%s", efs_id)
    except ClientError as e:
        if e.response['Error']['Code'] != 'FileSystemNotFound':
            raise
        logger.info("[DELETE_PITR_EFS_FS] Already gone | efs_id=%s", efs_id)

    if ssm_path:
        ssm = boto3.client('ssm')
        try:
            ssm.delete_parameter(Name=ssm_path)
            logger.info("[DELETE_PITR_EFS_FS] Cleared SSM param | path=%s", ssm_path)
        except ClientError as e:
            if e.response['Error']['Code'] != 'ParameterNotFound':
                raise

    return {'submitted': True, 'efs_id': efs_id}


# ---------------------------------------------------------------------------
# Lambda entry point
# ---------------------------------------------------------------------------

def handler(event, context):
    action = event.get('action', 'comment').lower()

    if action in ('comment', 'uncomment'):
        return _handle_patch(event, action)
    if action == 'update_stack':
        return _handle_update_stack(event)
    if action == 'set_deploy_paid_false':
        return _handle_set_deploy_paid_false(event)
    if action == 'set_deploy_paid_false_both':
        return _handle_set_deploy_paid_false_both(event)
    if action == 'check_stack_status':
        return _handle_check_stack_status(event)
    if action == 'check_both_stacks_status':
        return _handle_check_both_stacks_status(event)
    if action == 'set_asg_capacity':
        return _handle_set_asg_capacity(event)
    if action == 'snapshot_pitr_db':
        return _handle_snapshot_pitr_db(event)
    if action == 'check_pitr_snapshot_status':
        return _handle_check_pitr_snapshot_status(event)
    if action == 'delete_pitr_db':
        return _handle_delete_pitr_db(event)
    if action == 'check_pitr_db_deleted':
        return _handle_check_pitr_db_deleted(event)
    if action == 'delete_pitr_efs_mount_targets':
        return _handle_delete_pitr_efs_mount_targets(event)
    if action == 'check_pitr_efs_mount_targets_deleted':
        return _handle_check_pitr_efs_mount_targets_deleted(event)
    if action == 'delete_pitr_efs_filesystem':
        return _handle_delete_pitr_efs_filesystem(event)

    raise ValueError(
        f"action must be 'comment', 'uncomment', 'update_stack', "
        f"'set_deploy_paid_false', 'set_deploy_paid_false_both', "
        f"'check_stack_status', 'check_both_stacks_status', 'set_asg_capacity', "
        f"'snapshot_pitr_db', 'check_pitr_snapshot_status', 'delete_pitr_db', "
        f"'check_pitr_db_deleted', 'delete_pitr_efs_mount_targets', "
        f"'check_pitr_efs_mount_targets_deleted', or "
        f"'delete_pitr_efs_filesystem' — got: {action!r}"
    )
