import boto3
import logging
import os
import json
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)

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


def lambda_handler(event, context):
    action = event.get('action', '')
    region = os.environ['AWS_REGION']
    if action == 'discover':
        return handle_discover(event, region)
    if action == 'update_network_stack':
        return handle_update_network_stack(event, region)
    if action == 'pitr_restore':
        return handle_pitr_restore(event, region)
    if action == 'check_db_status':
        return handle_check_db_status(event, region)
    if action == 'update_secrets':
        return handle_update_secrets(event, region)
    if action == 'update_app_stack':
        return handle_update_app_stack(event, region)
    if action == 'check_stack_status':
        return handle_check_stack_status(event, region)
    if action == 'notify':
        return handle_notify(event)
    raise ValueError(f'Unknown action: {action!r}')


# ── discover ──────────────────────────────────────────────────────────

def handle_discover(event, region):
    """
    Discovers AMI, snapshot (snapshot path), and DB master password.
    Returns all values needed for subsequent steps.
    """
    use_pitr           = event.get('use_pitr', False)
    db_instance_id     = event.get('db_instance_identifier', os.environ.get('DB_INSTANCE_IDENTIFIER', ''))
    snapshot_id        = event.get('snapshot_identifier', '')
    db_master_password = event.get('db_master_password', '')
    org_name           = os.environ.get('ORG_NAME', '')
    app_name           = os.environ.get('APP_NAME', '')
    dr_db_secret_arn   = os.environ.get('DR_DB_SECRET_ARN', '')
    redshift_cluster_id = event.get('redshift_cluster_identifier', os.environ.get('REDSHIFT_CLUSTER_IDENTIFIER', ''))
    redshift_snapshot  = event.get('redshift_snapshot_identifier', '')

    if not db_master_password and dr_db_secret_arn:
        logger.info(f'Auto-fetching DB master password from: {dr_db_secret_arn}')
        db_master_password = fetch_db_master_password(region, dr_db_secret_arn)

    instance_ami = ''
    if org_name:
        logger.info(f'Discovering DR AMI: {org_name}_{app_name}_dr-image_*')
        instance_ami = find_latest_ami(region, org_name, app_name)
        logger.info(f'AMI: {instance_ami}')

    if not use_pitr:
        if not snapshot_id and db_instance_id:
            logger.info(f'Discovering latest snapshot for: {db_instance_id}')
            snapshot_id = find_latest_snapshot(region, db_instance_id)
            logger.info(f'Snapshot: {snapshot_id}')
        if not redshift_snapshot and redshift_cluster_id:
            logger.info(f'Discovering latest Redshift snapshot for: {redshift_cluster_id}')
            redshift_snapshot = find_latest_redshift_snapshot(region, redshift_cluster_id)
            logger.info(f'Redshift snapshot: {redshift_snapshot}')

    return {
        'use_pitr':                          use_pitr,
        'instance_ami':                      instance_ami,
        'snapshot_identifier':               snapshot_id,
        'db_master_password':                db_master_password,
        'redshift_snapshot_identifier':      redshift_snapshot,
        'db_instance_identifier':            db_instance_id,
    }


# ── update_network_stack ──────────────────────────────────────────────

def handle_update_network_stack(event, region):
    cf = boto3.client('cloudformation', region_name=region)
    stack        = os.environ['NETWORK_STACK_NAME']
    template_url = os.environ.get('NETWORK_TEMPLATE_URL', '')
    logger.info(f'Updating network stack: {stack}')
    update_stack(cf, stack, deploy_paid='true', template_url=template_url or None)
    return {'network_stack_name': stack, 'submitted': True}


# ── pitr_restore ──────────────────────────────────────────────────────

def handle_pitr_restore(event, region):
    """
    Calls restore-db-instance-to-point-in-time using the cross-region automated
    backup. UseLatestRestorableTime=True gives ~5 min RPO.
    Returns the target instance identifier immediately — the state machine polls
    check_db_status until the instance is available.
    """
    rds       = boto3.client('rds', region_name=region)
    source_id = os.environ.get('DB_INSTANCE_IDENTIFIER', '')
    target_id = os.environ.get('PITR_TARGET_IDENTIFIER', '')
    if not source_id or not target_id:
        raise ValueError('DB_INSTANCE_IDENTIFIER and PITR_TARGET_IDENTIFIER must be set for PITR restore.')

    subnet_group = event.get('pitr_subnet_group', '')
    sg_id        = event.get('pitr_security_group_id', '')

    kwargs = dict(
        SourceDBInstanceIdentifier=source_id,
        TargetDBInstanceIdentifier=target_id,
        UseLatestRestorableTime=True,
        MultiAZ=False,
        PubliclyAccessible=False,
        AutoMinorVersionUpgrade=True,
        Tags=[
            {'Key': 'Environment', 'Value': 'DR'},
            {'Key': 'ManagedBy',   'Value': 'dr-failover-sfn'},
        ],
    )
    if subnet_group:
        kwargs['DBSubnetGroupName'] = subnet_group
    if sg_id:
        kwargs['VpcSecurityGroupIds'] = [sg_id]

    logger.info(f'Initiating PITR restore: {source_id} → {target_id}')
    try:
        rds.restore_db_instance_to_point_in_time(**kwargs)
    except ClientError as e:
        if 'already exists' in str(e):
            logger.warning(f'Instance {target_id} already exists — assuming in-progress restore.')
        else:
            raise
    return {'pitr_target_identifier': target_id}


# ── check_db_status ──────────────────────────────────────────────────

def handle_check_db_status(event, region):
    rds       = boto3.client('rds', region_name=region)
    target_id = event.get('pitr_target_identifier', os.environ.get('PITR_TARGET_IDENTIFIER', ''))
    resp      = rds.describe_db_instances(DBInstanceIdentifier=target_id)
    instance  = resp['DBInstances'][0]
    status    = instance['DBInstanceStatus']
    endpoint  = instance.get('Endpoint', {}).get('Address', '')
    port      = instance.get('Endpoint', {}).get('Port', 3306)
    available = status == 'available'
    logger.info(f'DB {target_id} status={status} endpoint={endpoint}')
    return {
        'pitr_target_identifier': target_id,
        'db_status':    status,
        'db_available': available,
        'db_endpoint':  endpoint,
        'db_port':      port,
    }


# ── update_secrets ───────────────────────────────────────────────────

def handle_update_secrets(event, region):
    """
    Writes the PITR DB endpoint to:
      1. Secrets Manager (DR_DB_SECRET_ARN) — DB_HOST field
      2. SSM Parameter Store (PITR_ENDPOINT_SSM_PATH) — read by app stack via {{resolve:ssm:...}}
    Must be called after check_db_status returns db_available=true.
    """
    db_endpoint   = event.get('db_endpoint', '')
    if not db_endpoint:
        raise ValueError('db_endpoint missing — check_db_status must succeed before update_secrets.')

    dr_secret_arn = os.environ.get('DR_DB_SECRET_ARN', '')
    ssm_path      = os.environ.get('PITR_ENDPOINT_SSM_PATH', '')

    if dr_secret_arn:
        sm     = boto3.client('secretsmanager', region_name=region)
        resp   = sm.get_secret_value(SecretId=dr_secret_arn)
        secret = json.loads(resp['SecretString'])
        secret['DB_HOST'] = db_endpoint
        sm.put_secret_value(SecretId=dr_secret_arn, SecretString=json.dumps(secret))
        logger.info(f'Updated Secrets Manager {dr_secret_arn} with endpoint {db_endpoint}')

    if ssm_path:
        ssm = boto3.client('ssm', region_name=region)
        ssm.put_parameter(Name=ssm_path, Value=db_endpoint, Type='String', Overwrite=True)
        logger.info(f'Updated SSM {ssm_path} with endpoint {db_endpoint}')

    return {'secrets_updated': True, 'db_endpoint': db_endpoint}


# ── update_app_stack ─────────────────────────────────────────────────

def handle_update_app_stack(event, region):
    cf           = boto3.client('cloudformation', region_name=region)
    app_stack    = os.environ['APP_STACK_NAME']
    use_pitr     = event.get('use_pitr', False)
    instance_ami = event.get('instance_ami', '')
    db_endpoint  = event.get('db_endpoint', '')
    snapshot_id  = event.get('snapshot_identifier', '')
    db_password  = event.get('db_master_password', '')
    redshift_snap = event.get('redshift_snapshot_identifier', '')

    if use_pitr:
        extra = {
            'DeployPaidResources': 'true',
            'IsPITRMode':          'true',
            'PITRDBEndpoint':      db_endpoint,
        }
        if instance_ami:
            extra['InstanceAMI'] = instance_ami
        logger.info(f'Updating app stack (PITR mode): {app_stack}')
    else:
        extra = {
            'DeployPaidResources': 'true',
            'IsPITRMode':          'false',
            'PITRDBEndpoint':      '',
        }
        if snapshot_id:
            extra['SnapshotIdentifier'] = snapshot_id
        if db_password:
            extra['DBMasterUserPassword'] = db_password
        if instance_ami:
            extra['InstanceAMI'] = instance_ami
        if redshift_snap:
            extra['RedshiftSnapshotIdentifier'] = redshift_snap
        logger.info(f'Updating app stack (snapshot mode): {app_stack}')

    update_stack(cf, app_stack, deploy_paid='true', extra_params=extra, preserve_yaml=True)
    return {'app_stack_name': app_stack, 'submitted': True}


# ── check_stack_status ───────────────────────────────────────────────

def handle_check_stack_status(event, region):
    cf         = boto3.client('cloudformation', region_name=region)
    stack_name = event.get('stack_name', '')
    resp       = cf.describe_stacks(StackName=stack_name)
    status     = resp['Stacks'][0]['StackStatus']
    complete   = status in TERMINAL_STATES
    rollback   = status in ROLLBACK_STATES
    logger.info(f'Stack {stack_name} status={status}')
    return {
        'stack_name':     stack_name,
        'stack_status':   status,
        'stack_complete': complete,
        'stack_rollback': rollback,
    }


# ── notify ───────────────────────────────────────────────────────────

def handle_notify(event):
    topic   = os.environ.get('SNS_TOPIC_ARN', '')
    app     = os.environ.get('APP_NAME', '')
    msg     = event.get('message', f'DR Failover complete for [{app}].')
    subject = event.get('subject', f'DR Failover Complete [{app}]')
    notify(topic, subject, msg)
    return {'notified': True}


# ── helpers ──────────────────────────────────────────────────────────

def find_latest_snapshot(region, db_instance_identifier):
    rds = boto3.client('rds', region_name=region)
    for snapshot_type in ['manual', 'automated']:
        response  = rds.describe_db_snapshots(
            DBInstanceIdentifier=db_instance_identifier,
            SnapshotType=snapshot_type
        )
        snapshots = [s for s in response.get('DBSnapshots', []) if s.get('Status') == 'available']
        if snapshots:
            snapshots.sort(key=lambda x: x['SnapshotCreateTime'], reverse=True)
            return snapshots[0]['DBSnapshotArn']
    raise Exception(f'No available snapshots found for: {db_instance_identifier}')


def find_latest_redshift_snapshot(region, cluster_identifier):
    redshift = boto3.client('redshift', region_name=region)
    for snapshot_type in ['manual', 'automated']:
        response  = redshift.describe_cluster_snapshots(
            ClusterIdentifier=cluster_identifier,
            SnapshotType=snapshot_type
        )
        snapshots = [s for s in response.get('Snapshots', []) if s.get('Status') == 'available']
        if snapshots:
            snapshots.sort(key=lambda x: x['SnapshotCreateTime'], reverse=True)
            return snapshots[0]['SnapshotIdentifier']
    raise Exception(f'No available Redshift snapshots found for: {cluster_identifier}')


def fetch_db_master_password(region, secret_arn):
    sm     = boto3.client('secretsmanager', region_name=region)
    resp   = sm.get_secret_value(SecretId=secret_arn)
    secret = json.loads(resp['SecretString'])
    pw     = secret.get('DB_ROOT_PASSWORD', '')
    if not pw:
        raise Exception(f'DB_ROOT_PASSWORD not found in secret: {secret_arn}')
    return pw


def find_latest_ami(region, org_name, app_name):
    ec2      = boto3.client('ec2', region_name=region)
    response = ec2.describe_images(
        Owners=['self'],
        Filters=[
            {'Name': 'name',  'Values': [f'{org_name}_{app_name}_dr-image_*']},
            {'Name': 'state', 'Values': ['available']},
        ]
    )
    images = response.get('Images', [])
    if not images:
        raise Exception(f'No available DR AMIs found matching: {org_name}_{app_name}_dr-image_*')
    images.sort(key=lambda x: x['CreationDate'], reverse=True)
    return images[0]['ImageId']


def get_current_parameters(cf, stack_name):
    response = cf.describe_stacks(StackName=stack_name)
    return {p['ParameterKey']: p['ParameterValue'] for p in response['Stacks'][0].get('Parameters', [])}


def _cfn_to_yaml(obj, _depth=0):
    import json as _j
    if isinstance(obj, str):
        obj = _j.loads(obj)

    def _key(k):
        s = str(k)
        if not s or ': ' in s or s[0] in '!&*[{|>\'"':
            return _j.dumps(s)
        return s

    def _scalar(v):
        if v is None: return 'null'
        if isinstance(v, bool): return 'true' if v else 'false'
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


def _fetch_as_yaml(cf, stack_name):
    resp = cf.get_template(StackName=stack_name, TemplateStage='Original')
    body = resp['TemplateBody']
    if isinstance(body, dict):
        logger.info(f'[FETCH_TEMPLATE] dict → YAML | stack={stack_name}')
        return _cfn_to_yaml(body)
    if body.lstrip().startswith('{'):
        logger.info(f'[FETCH_TEMPLATE] JSON string → YAML | stack={stack_name}')
        return _cfn_to_yaml(body)
    logger.info(f'[FETCH_TEMPLATE] already YAML | stack={stack_name}')
    return body


def update_stack(cf, stack_name, deploy_paid, extra_params=None, template_url=None, preserve_yaml=False):
    if extra_params is None:
        extra_params = {}
    current_params = get_current_parameters(cf, stack_name)
    parameters = []
    for key in current_params:
        if key in extra_params and extra_params[key]:
            parameters.append({'ParameterKey': key, 'ParameterValue': extra_params[key]})
        else:
            parameters.append({'ParameterKey': key, 'UsePreviousValue': True})
    for key, val in extra_params.items():
        if key not in current_params:
            parameters.append({'ParameterKey': key, 'ParameterValue': str(val)})

    caps = ['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM', 'CAPABILITY_AUTO_EXPAND']
    if template_url:
        kwargs = dict(StackName=stack_name, TemplateURL=template_url,
                      Parameters=parameters, Capabilities=caps)
    elif preserve_yaml:
        body   = _fetch_as_yaml(cf, stack_name)
        kwargs = dict(StackName=stack_name, TemplateBody=body,
                      Parameters=parameters, Capabilities=caps)
    else:
        kwargs = dict(StackName=stack_name, UsePreviousTemplate=True,
                      Parameters=parameters, Capabilities=caps)

    try:
        cf.update_stack(**kwargs)
    except ClientError as e:
        code = e.response['Error']['Code']
        msg  = e.response['Error']['Message']
        if code == 'ValidationError' and 'No updates are to be performed' in msg:
            logger.info(f'[UPDATE_STACK] No changes needed | stack={stack_name}')
            return
        raise


def notify(sns_topic_arn, subject, message):
    if not sns_topic_arn:
        return
    try:
        boto3.client('sns').publish(TopicArn=sns_topic_arn, Subject=subject, Message=message)
    except Exception:
        logger.warning('Failed to publish SNS notification', exc_info=True)
