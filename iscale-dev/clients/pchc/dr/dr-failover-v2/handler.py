import logging
import os
import json
import boto3
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


def handler(event, context):
    action = event.get('action', '')
    if action == 'discover':           return _discover(event)
    if action == 'pitr_restore':        return _pitr_restore(event)
    if action == 'check_db_status':     return _check_db_status(event)
    if action == 'update_secrets':      return _update_secrets(event)
    if action == 'update_stack':        return _update_stack_action(event)
    if action == 'check_stack_status':  return _check_stack_status(event)
    if action == 'notify':              return _notify(event)
    raise ValueError(f'Unknown action: {action!r}')


# ── discover ──────────────────────────────────────────────────────────

def _discover(event):
    """
    Resolves AMI, snapshot (snapshot path), and DB master password.
    All config read from event payload — no env vars for app-specific values.
    """
    region      = os.environ['AWS_REGION']
    org_name    = event.get('org_name', '')
    app_name    = event.get('app_name', '')
    use_pitr    = event.get('use_pitr', False)
    db_id       = event.get('db_instance_identifier', '')
    secret_arn  = event.get('dr_db_secret_arn', '')
    snapshot_id = event.get('snapshot_identifier', '')
    db_password = event.get('db_master_password', '')
    rs_cluster  = event.get('redshift_cluster_identifier', '')
    rs_snapshot = event.get('redshift_snapshot_identifier', '')

    if not db_password and secret_arn:
        logger.info(f'Fetching DB password from secret: {secret_arn}')
        db_password = _fetch_db_password(region, secret_arn)

    instance_ami = ''
    if org_name and app_name:
        logger.info(f'Discovering DR AMI: {org_name}_{app_name}_dr-image_*')
        instance_ami = _find_latest_ami(region, org_name, app_name)
        logger.info(f'AMI: {instance_ami}')

    if not use_pitr:
        if not snapshot_id and db_id:
            logger.info(f'Discovering snapshot for: {db_id}')
            snapshot_id = _find_latest_snapshot(region, db_id)
            logger.info(f'Snapshot: {snapshot_id}')
        if not rs_snapshot and rs_cluster:
            logger.info(f'Discovering Redshift snapshot for: {rs_cluster}')
            rs_snapshot = _find_latest_redshift_snapshot(region, rs_cluster)
            logger.info(f'Redshift snapshot: {rs_snapshot}')

    return {
        'instance_ami':                 instance_ami,
        'snapshot_identifier':          snapshot_id,
        'db_master_password':           db_password,
        'redshift_snapshot_identifier': rs_snapshot,
    }


# ── pitr_restore ──────────────────────────────────────────────────────

def _pitr_restore(event):
    """
    Calls restore-db-instance-to-point-in-time (UseLatestRestorableTime=True).
    For cross-region PITR, uses SourceDBInstanceAutomatedBackupsArn — the ARN of the
    replicated automated backup in the DR region — NOT SourceDBInstanceIdentifier,
    which only works for same-region restores.
    Auto-discovers the backup ARN from describe_db_instance_automated_backups.
    """
    region     = os.environ['AWS_REGION']
    source_id  = event.get('db_instance_identifier', '')
    target_id  = event.get('pitr_target_identifier', '')
    subnet_grp = event.get('pitr_subnet_group', '')
    sg_id      = event.get('pitr_security_group_id', '')

    if not source_id or not target_id:
        raise ValueError('db_instance_identifier and pitr_target_identifier are required for PITR restore.')

    rds        = boto3.client('rds', region_name=region)
    backup_arn = _find_automated_backup_arn(rds, source_id)
    logger.info(f'Using automated backup ARN: {backup_arn}')

    kwargs = dict(
        SourceDBInstanceAutomatedBackupsArn=backup_arn,
        TargetDBInstanceIdentifier=target_id,
        UseLatestRestorableTime=True,
        MultiAZ=False,
        PubliclyAccessible=False,
        AutoMinorVersionUpgrade=True,
        Tags=[
            {'Key': 'Environment', 'Value': 'DR'},
            {'Key': 'ManagedBy',   'Value': 'dr-failover-v2'},
        ],
    )
    if subnet_grp:
        kwargs['DBSubnetGroupName'] = subnet_grp
    if sg_id:
        kwargs['VpcSecurityGroupIds'] = [sg_id]

    logger.info(f'PITR restore: {source_id} → {target_id}')
    try:
        rds.restore_db_instance_to_point_in_time(**kwargs)
    except ClientError as e:
        if 'already exists' in str(e):
            logger.warning(f'{target_id} already exists — assuming in-progress restore.')
        else:
            raise
    return {'pitr_target_identifier': target_id}


# ── check_db_status ───────────────────────────────────────────────────

def _check_db_status(event):
    region    = os.environ['AWS_REGION']
    target_id = event.get('pitr_target_identifier', '')
    rds       = boto3.client('rds', region_name=region)
    resp      = rds.describe_db_instances(DBInstanceIdentifier=target_id)
    instance  = resp['DBInstances'][0]
    status    = instance['DBInstanceStatus']
    endpoint  = instance.get('Endpoint', {}).get('Address', '')
    port      = instance.get('Endpoint', {}).get('Port', 3306)
    available = status == 'available'
    logger.info(f'DB {target_id}: status={status} endpoint={endpoint}')
    return {
        'pitr_target_identifier': target_id,
        'db_status':    status,
        'db_available': available,
        'db_endpoint':  endpoint,
        'db_port':      port,
    }


# ── update_secrets ────────────────────────────────────────────────────

def _update_secrets(event):
    """
    Writes PITR endpoint to Secrets Manager (DB_HOST) and SSM Parameter Store.
    Must be called after check_db_status returns db_available=true.
    """
    region      = os.environ['AWS_REGION']
    db_endpoint = event.get('db_endpoint', '')
    secret_arn  = event.get('dr_db_secret_arn', '')
    ssm_path    = event.get('pitr_endpoint_ssm_path', '')

    if not db_endpoint:
        raise ValueError('db_endpoint is required — check_db_status must succeed first.')

    if secret_arn:
        sm     = boto3.client('secretsmanager', region_name=region)
        resp   = sm.get_secret_value(SecretId=secret_arn)
        secret = json.loads(resp['SecretString'])
        secret['DB_HOST'] = db_endpoint
        sm.put_secret_value(SecretId=secret_arn, SecretString=json.dumps(secret))
        logger.info(f'Updated secret {secret_arn} with endpoint {db_endpoint}')

    if ssm_path:
        ssm = boto3.client('ssm', region_name=region)
        ssm.put_parameter(Name=ssm_path, Value=db_endpoint, Type='String', Overwrite=True)
        logger.info(f'Updated SSM {ssm_path} with endpoint {db_endpoint}')

    return {'secrets_updated': True, 'db_endpoint': db_endpoint}


# ── update_stack ──────────────────────────────────────────────────────

def _update_stack_action(event):
    region       = os.environ['AWS_REGION']
    stack_name   = event.get('stack_name', '')
    stack_type   = event.get('stack_type', 'app')   # 'network' or 'app'
    extra        = event.get('extra_params', {})
    template_url = event.get('network_template_url',
                              os.environ.get('DEFAULT_NETWORK_TEMPLATE_URL', ''))

    cf = boto3.client('cloudformation', region_name=region)
    logger.info(f'Updating stack: {stack_name} (type={stack_type})')

    if stack_type == 'network':
        _cfn_update(cf, stack_name, extra, template_url=template_url or None)
    else:
        _cfn_update(cf, stack_name, extra, preserve_yaml=True)

    return {'stack_name': stack_name, 'submitted': True}


# ── check_stack_status ────────────────────────────────────────────────

def _check_stack_status(event):
    region     = os.environ['AWS_REGION']
    stack_name = event.get('stack_name', '')
    cf         = boto3.client('cloudformation', region_name=region)
    resp       = cf.describe_stacks(StackName=stack_name)
    status     = resp['Stacks'][0]['StackStatus']
    complete   = status in TERMINAL_STATES
    rollback   = status in ROLLBACK_STATES
    logger.info(f'Stack {stack_name}: {status}')
    return {
        'stack_name':     stack_name,
        'stack_status':   status,
        'stack_complete': complete,
        'stack_rollback': rollback,
    }


# ── notify ────────────────────────────────────────────────────────────

def _notify(event):
    topic   = event.get('sns_topic_arn', '')
    subject = event.get('subject', 'DR Failover Notification')
    message = event.get('message', '')
    if not topic:
        logger.info('No sns_topic_arn provided — skipping notification.')
        return {'notified': False}
    try:
        boto3.client('sns').publish(TopicArn=topic, Subject=subject, Message=message)
        logger.info(f'SNS notification sent: {subject}')
    except Exception:
        logger.warning('SNS publish failed', exc_info=True)
    return {'notified': True}


# ── helpers ───────────────────────────────────────────────────────────

def _fetch_db_password(region, secret_arn):
    sm     = boto3.client('secretsmanager', region_name=region)
    resp   = sm.get_secret_value(SecretId=secret_arn)
    secret = json.loads(resp['SecretString'])
    pw     = secret.get('DB_ROOT_PASSWORD', '')
    if not pw:
        raise Exception(f'DB_ROOT_PASSWORD not in secret: {secret_arn}')
    return pw


def _find_automated_backup_arn(rds, db_instance_identifier):
    """
    Finds the replicated automated backup ARN in the DR region.
    Cross-region automated backup replication creates a backup entry with
    status 'replicating' in the DR region — this ARN is required for
    cross-region restore-db-instance-to-point-in-time calls.
    """
    resp    = rds.describe_db_instance_automated_backups(
        DBInstanceIdentifier=db_instance_identifier
    )
    backups = resp.get('DBInstanceAutomatedBackups', [])
    if not backups:
        raise Exception(
            f'No automated backups found for {db_instance_identifier} in this region. '
            f'Ensure EnableCrossRegionBackupReplication=true is set in the app stack '
            f'and the replication has had time to complete at least one backup cycle.'
        )
    available = [b for b in backups if b.get('Status') in ('replicating', 'retained')]
    if not available:
        statuses = [b.get('Status') for b in backups]
        raise Exception(
            f'No replicating/retained automated backup for {db_instance_identifier}. '
            f'Found statuses: {statuses}. Backup replication may still be initialising.'
        )
    return available[0]['DBInstanceAutomatedBackupsArn']


def _find_latest_snapshot(region, db_id):
    rds = boto3.client('rds', region_name=region)
    for snap_type in ['manual', 'automated']:
        resp  = rds.describe_db_snapshots(DBInstanceIdentifier=db_id, SnapshotType=snap_type)
        snaps = [s for s in resp.get('DBSnapshots', []) if s.get('Status') == 'available']
        if snaps:
            snaps.sort(key=lambda x: x['SnapshotCreateTime'], reverse=True)
            return snaps[0]['DBSnapshotArn']
    raise Exception(f'No available snapshots for: {db_id}')


def _find_latest_redshift_snapshot(region, cluster_id):
    rs = boto3.client('redshift', region_name=region)
    for snap_type in ['manual', 'automated']:
        resp  = rs.describe_cluster_snapshots(ClusterIdentifier=cluster_id, SnapshotType=snap_type)
        snaps = [s for s in resp.get('Snapshots', []) if s.get('Status') == 'available']
        if snaps:
            snaps.sort(key=lambda x: x['SnapshotCreateTime'], reverse=True)
            return snaps[0]['SnapshotIdentifier']
    raise Exception(f'No available Redshift snapshots for: {cluster_id}')


def _find_latest_ami(region, org_name, app_name):
    ec2    = boto3.client('ec2', region_name=region)
    resp   = ec2.describe_images(
        Owners=['self'],
        Filters=[
            {'Name': 'name',  'Values': [f'{org_name}_{app_name}_dr-image_*']},
            {'Name': 'state', 'Values': ['available']},
        ]
    )
    images = resp.get('Images', [])
    if not images:
        raise Exception(f'No DR AMIs found matching: {org_name}_{app_name}_dr-image_*')
    images.sort(key=lambda x: x['CreationDate'], reverse=True)
    return images[0]['ImageId']


def _get_current_params(cf, stack_name):
    resp = cf.describe_stacks(StackName=stack_name)
    return {p['ParameterKey']: p['ParameterValue']
            for p in resp['Stacks'][0].get('Parameters', [])}


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
            float(s); return _j.dumps(s)
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


def _cfn_update(cf, stack_name, extra_params, template_url=None, preserve_yaml=False):
    current = _get_current_params(cf, stack_name)
    params  = []
    for key in current:
        if key in extra_params:
            params.append({'ParameterKey': key, 'ParameterValue': str(extra_params[key])})
        else:
            params.append({'ParameterKey': key, 'UsePreviousValue': True})
    for key, val in extra_params.items():
        if key not in current:
            params.append({'ParameterKey': key, 'ParameterValue': str(val)})

    caps = ['CAPABILITY_IAM', 'CAPABILITY_NAMED_IAM', 'CAPABILITY_AUTO_EXPAND']
    if template_url:
        kwargs = dict(StackName=stack_name, TemplateURL=template_url,
                      Parameters=params, Capabilities=caps)
    elif preserve_yaml:
        body   = _fetch_as_yaml(cf, stack_name)
        kwargs = dict(StackName=stack_name, TemplateBody=body,
                      Parameters=params, Capabilities=caps)
    else:
        kwargs = dict(StackName=stack_name, UsePreviousTemplate=True,
                      Parameters=params, Capabilities=caps)

    try:
        cf.update_stack(**kwargs)
        logger.info(f'[UPDATE_STACK] Submitted | stack={stack_name}')
    except ClientError as e:
        code = e.response['Error']['Code']
        msg  = e.response['Error']['Message']
        if code == 'ValidationError' and 'No updates are to be performed' in msg:
            logger.info(f'[UPDATE_STACK] No changes needed | stack={stack_name}')
            return
        raise
