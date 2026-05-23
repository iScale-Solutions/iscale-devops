import json
import logging
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
                    parts.append(_node(fv, d + 1))
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
                        parts.append(_node(rv, d + 1))
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


def _submit_deploy_paid_false(cfn, stack_name: str) -> dict:
    """
    Set DeployPaidResources=false on a single stack.
    Fetches the current template and resubmits it as YAML with TemplateBody
    instead of UsePreviousTemplate=True — this prevents CloudFormation from
    normalising the stored template to JSON during the update.
    """
    params = []
    for p in _get_current_parameters(cfn, stack_name):
        if p['ParameterKey'] == 'DeployPaidResources':
            logger.info("[SET_DEPLOY_PAID_FALSE] Current value=%s | stack=%s", p['ParameterValue'], stack_name)
            params.append({'ParameterKey': 'DeployPaidResources', 'ParameterValue': 'false'})
        else:
            params.append({'ParameterKey': p['ParameterKey'], 'UsePreviousValue': True})

    template_body = _fetch_as_yaml(cfn, stack_name)

    try:
        cfn.update_stack(
            StackName=stack_name,
            TemplateBody=template_body,
            Parameters=params,
            Capabilities=['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM', 'CAPABILITY_AUTO_EXPAND'],
        )
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

def _handle_patch(event: dict, action: str) -> dict:
    """Fetch template as YAML, patch it, return modified template + whether a change was made."""
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

    if patched:
        sep = '=' * 72
        logger.info("[PATCH] Modified template for %s:\n%s\n%s\n%s", app_name, sep, modified, sep)
    else:
        logger.info("[PATCH] No changes — template already in desired state | stack=%s | action=%s", app_name, action)

    return {
        'stack_name': app_name,
        'action': action,
        'patched': patched,
        'modified_template': modified,
    }


# ---------------------------------------------------------------------------
# Action: update_stack  (apply patched template body)
# ---------------------------------------------------------------------------

def _handle_update_stack(event: dict) -> dict:
    """Submit UpdateStack with a provided template body. All parameters preserved via UsePreviousValue."""
    app_name = _get_app_name(event)
    template_body = event.get('template_body') or event.get('modified_template')
    if not template_body:
        raise ValueError("update_stack action requires 'template_body' in the event")

    logger.info("[UPDATE_STACK] Submitting template update | stack=%s", app_name)

    cfn = boto3.client('cloudformation')
    current_params = _get_current_parameters(cfn, app_name)
    parameters = [
        {'ParameterKey': p['ParameterKey'], 'UsePreviousValue': True}
        for p in current_params
    ]

    try:
        cfn.update_stack(
            StackName=app_name,
            TemplateBody=template_body,
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
    logger.info("[SET_DEPLOY_PAID_FALSE] Start | stack=%s", app_name)

    cfn = boto3.client('cloudformation')
    result = _submit_deploy_paid_false(cfn, app_name)

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

    raise ValueError(
        f"action must be 'comment', 'uncomment', 'update_stack', "
        f"'set_deploy_paid_false', 'set_deploy_paid_false_both', "
        f"'check_stack_status', or 'check_both_stacks_status' — got: {action!r}"
    )
