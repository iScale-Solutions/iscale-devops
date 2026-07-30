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
    if action == 'discover':                  return _discover(event)
    if action == 'pitr_restore':              return _pitr_restore(event)
    if action == 'check_db_status':           return _check_db_status(event)
    if action == 'update_secrets':            return _update_secrets(event)
    if action == 'check_efs_recovery_point':  return _check_efs_recovery_point(event)
    if action == 'restore_efs':               return _restore_efs(event)
    if action == 'check_restore_job':         return _check_restore_job(event)
    if action == 'update_stack':              return _update_stack_action(event)
    if action == 'check_stack_status':        return _check_stack_status(event)
    if action == 'notify':                    return _notify(event)
    if action == 'scale_ecs_service':         return _scale_ecs_service(event)
    if action == 'set_asg_capacity':          return _set_asg_capacity(event)
    if action == 'check_all_asgs_healthy':    return _check_all_asgs_healthy(event)
    if action == 'check_scale_results':       return _check_scale_results(event)
    if action == 'detach_codedeploy_asgs':    return _detach_codedeploy_asgs(event)
    if action == 'update_codedeploy_group':   return _update_codedeploy_group(event)
    if action == 'trigger_codedeploy':        return _trigger_codedeploy(event)
    if action == 'check_codedeploy':          return _check_codedeploy(event)
    raise ValueError(f'Unknown action: {action!r}')


# â”€â”€ discover â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _discover(event):
    region       = os.environ['AWS_REGION']
    org_name     = event.get('org_name', '')
    app_name     = event.get('app_name', '')
    use_pitr     = event.get('use_pitr', False)
    db_id        = event.get('db_instance_identifier', '')
    secret_arn   = event.get('dr_db_secret_arn', '')
    snapshot_id  = event.get('snapshot_identifier', '')
    db_password  = event.get('db_master_password', '')
    rs_cluster   = event.get('redshift_cluster_identifier', '')
    rs_snapshot  = event.get('redshift_snapshot_identifier', '')

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
        'instance_ami':                  instance_ami,
        'snapshot_identifier':           snapshot_id,
        'db_master_password':            db_password,
        'redshift_snapshot_identifier':  rs_snapshot,
    }


# â”€â”€ pitr_restore â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _find_automated_backup_arn(rds, db_instance_identifier):
    resp    = rds.describe_db_instance_automated_backups(
        DBInstanceIdentifier=db_instance_identifier
    )
    backups = resp.get('DBInstanceAutomatedBackups', [])
    if not backups:
        raise Exception(
            f'No automated backups found for {db_instance_identifier} in this region. '
            f'Ensure EnableCrossRegionBackupReplication=true is set in the app stack '
            f'and replication has completed at least one backup cycle.'
        )
    available = [b for b in backups if b.get('Status') in ('replicating', 'retained')]
    if not available:
        statuses = [b.get('Status') for b in backups]
        raise Exception(
            f'No replicating/retained automated backup for {db_instance_identifier}. '
            f'Found statuses: {statuses}. Backup replication may still be initialising.'
        )
    return available[0]['DBInstanceAutomatedBackupsArn']

def _pitr_restore(event):
    """
    Cross-region PITR restore using SourceDBInstanceAutomatedBackupsArn.
    SourceDBInstanceIdentifier only works for same-region restores â€” for
    cross-region we must supply the replicated backup ARN in the DR region.
    """
    region    = os.environ['AWS_REGION']
    source_id = event.get('db_instance_identifier', '')
    target_id = event.get('pitr_target_identifier', '')
    subnet_grp = event.get('pitr_subnet_group', '')
    sg_id     = event.get('pitr_security_group_id', '')

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

    logger.info(f'PITR restore: {source_id} â†’ {target_id}')
    try:
        rds.restore_db_instance_to_point_in_time(**kwargs)
    except ClientError as e:
        if 'already exists' in str(e):
            logger.warning(f'{target_id} already exists â€” assuming in-progress restore.')
        else:
            raise
    return {'pitr_target_identifier': target_id}


# â”€â”€ check_db_status â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _check_db_status(event):
    region    = os.environ['AWS_REGION']
    target_id = event.get('pitr_target_identifier', '')
    rds = boto3.client('rds', region_name=region)
    resp     = rds.describe_db_instances(DBInstanceIdentifier=target_id)
    instance = resp['DBInstances'][0]
    status   = instance['DBInstanceStatus']
    endpoint = instance.get('Endpoint', {}).get('Address', '')
    port     = instance.get('Endpoint', {}).get('Port', 3306)
    available = status == 'available'
    logger.info(f'DB {target_id}: status={status} endpoint={endpoint}')
    return {
        'pitr_target_identifier': target_id,
        'db_status':    status,
        'db_available': available,
        'db_endpoint':  endpoint,
        'db_port':      port,
    }


# â”€â”€ update_secrets â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _update_secrets(event):
    region      = os.environ['AWS_REGION']
    db_endpoint = event.get('db_endpoint', '')
    secret_arn  = event.get('dr_db_secret_arn', '')
    ssm_path    = event.get('pitr_endpoint_ssm_path', '')

    if not db_endpoint:
        raise ValueError('db_endpoint is required â€” check_db_status must succeed first.')

    if secret_arn:
        sm   = boto3.client('secretsmanager', region_name=region)
        resp = sm.get_secret_value(SecretId=secret_arn)
        secret = json.loads(resp['SecretString'])
        secret['DB_HOST'] = db_endpoint
        sm.put_secret_value(SecretId=secret_arn, SecretString=json.dumps(secret))
        logger.info(f'Updated secret {secret_arn} with endpoint {db_endpoint}')

    if ssm_path:
        ssm = boto3.client('ssm', region_name=region)
        ssm.put_parameter(Name=ssm_path, Value=db_endpoint, Type='String', Overwrite=True)
        logger.info(f'Updated SSM {ssm_path} with endpoint {db_endpoint}')

    return {'secrets_updated': True, 'db_endpoint': db_endpoint}


# â”€â”€ check_efs_recovery_point â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _check_efs_recovery_point(event):
    region     = os.environ['AWS_REGION']
    vault_name = event.get('efs_backup_vault_name', '')
    if not vault_name:
        logger.info('No efs_backup_vault_name in event â€” skipping EFS restore.')
        return {'efs_found': False, 'recovery_point_arn': '', 'source_efs_id': ''}
    backup = boto3.client('backup', region_name=region)
    resp   = backup.list_recovery_points_by_backup_vault(
        BackupVaultName=vault_name,
        ByResourceType='EFS',
    )
    points = [p for p in resp.get('RecoveryPoints', []) if p.get('Status') == 'COMPLETED']
    if not points:
        logger.info(f'No completed EFS recovery points in vault: {vault_name}')
        return {'efs_found': False, 'recovery_point_arn': '', 'source_efs_id': ''}
    points.sort(key=lambda p: p['CreationDate'], reverse=True)
    latest        = points[0]
    source_efs_id = latest['ResourceArn'].split('/')[-1]
    logger.info(f'Latest EFS recovery point: {latest["RecoveryPointArn"]} source={source_efs_id}')
    return {
        'efs_found':          True,
        'recovery_point_arn': latest['RecoveryPointArn'],
        'source_efs_id':      source_efs_id,
    }


# â”€â”€ restore_efs â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _restore_efs(event):
    import time
    region          = os.environ['AWS_REGION']
    vault_name      = event.get('backup_vault_name', '') or event.get('efs_backup_vault_name', '')
    backup_role_arn = event.get('backup_role_arn', '')
    if not vault_name or not backup_role_arn:
        raise ValueError('backup_vault_name and backup_role_arn are required for EFS restore.')
    backup = boto3.client('backup', region_name=region)
    resp   = backup.list_recovery_points_by_backup_vault(
        BackupVaultName=vault_name,
        ByResourceType='EFS',
    )
    points = [p for p in resp.get('RecoveryPoints', []) if p.get('Status') == 'COMPLETED']
    if not points:
        raise Exception(f'No completed EFS recovery points found in vault: {vault_name} (region={region})')
    points.sort(key=lambda p: p['CreationDate'], reverse=True)
    latest        = points[0]
    recovery_arn  = latest['RecoveryPointArn']
    source_efs_id = latest['ResourceArn'].split('/')[-1]
    backup_size   = latest.get('BackupSizeInBytes', 0)
    logger.info(
        f'Latest EFS recovery point: {recovery_arn} source={source_efs_id} '
        f'created={latest["CreationDate"]} size={backup_size}B'
    )
    if backup_size < 10 * 1024 * 1024:
        logger.warning(
            f'Recovery point size is {backup_size}B â€” this is likely an incremental backup. '
            f'If the DR vault is missing intermediate recovery points, the restore will not '
            f'reflect the full live EFS state. Ensure all incremental backups are copied cross-region.'
        )
    meta_resp = backup.get_recovery_point_restore_metadata(
        BackupVaultName=vault_name,
        RecoveryPointArn=recovery_arn,
    )
    metadata = meta_resp.get('RestoreMetadata', {})
    pascal_to_lower = {
        'PerformanceMode': 'performancemode',
        'KmsKeyId':        'kmskeyid',
    }
    for pascal, lower in pascal_to_lower.items():
        if pascal in metadata and lower not in metadata:
            metadata[lower] = metadata.pop(pascal)
    # Drop whatever the source says about Encrypted â€” cross-region backup copies
    # sometimes return Encrypted=false even when the source was encrypted.
    # Always force true: EFS encryption is a one-way door (cannot encrypt after creation).
    metadata.pop('Encrypted', None)
    metadata['encrypted'] = 'true'
    # AWS Backup requires kmskeyid when encrypted=true. If the source had no explicit
    # CMK (unencrypted or default AWS-managed key), look up the AWS-managed EFS key.
    if 'kmskeyid' not in metadata:
        kms      = boto3.client('kms', region_name=region)
        key_info = kms.describe_key(KeyId='alias/aws/elasticfilesystem')
        metadata['kmskeyid'] = key_info['KeyMetadata']['Arn']
        logger.info(f'Using AWS-managed EFS key: {metadata["kmskeyid"]}')
    if 'performancemode' not in metadata:
        metadata['performancemode'] = 'generalPurpose'
    metadata['newFileSystem'] = 'true'
    metadata['creationtoken'] = f'{source_efs_id}-dr-{int(time.time())}'
    resp   = backup.start_restore_job(
        RecoveryPointArn=recovery_arn,
        Metadata=metadata,
        IamRoleArn=backup_role_arn,
        ResourceType='EFS',
        CopySourceTagsToRestoredResource=True,
    )
    job_id = resp['RestoreJobId']
    logger.info(f'EFS restore job started: {job_id}')
    return {'restore_job_id': job_id}


# â”€â”€ check_restore_job â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _check_restore_job(event):
    region        = os.environ['AWS_REGION']
    job_id        = event.get('restore_job_id', '')
    ssm_path      = event.get('efs_id_ssm_path', '')
    network_stack = event.get('network_stack_name', '')
    app_stack     = event.get('app_stack_name', '')
    backup        = boto3.client('backup', region_name=region)
    resp          = backup.describe_restore_job(RestoreJobId=job_id)
    status        = resp['Status']
    if status in ('FAILED', 'ABORTED', 'EXPIRED'):
        raise Exception(f'EFS restore job {job_id} failed: {resp.get("StatusMessage", "")} (status={status})')
    complete = status == 'COMPLETED'
    efs_id   = ''
    if complete:
        created_arn = resp.get('CreatedResourceArn', '')
        efs_id      = created_arn.split('/')[-1] if created_arn else ''
        logger.info(f'EFS restore COMPLETED: efs_id={efs_id}')
        if efs_id and network_stack:
            cf    = boto3.client('cloudformation', region_name=region)
            sg_id = _get_stack_output(cf, app_stack, 'EFSStandbySecurityGroupId') if app_stack else ''
            _create_efs_mount_targets(region, efs_id, network_stack, sg_id, cf=cf)
        if efs_id:
            _tag_efs(region, efs_id, app_stack)
        if ssm_path and efs_id:
            ssm = boto3.client('ssm', region_name=region)
            ssm.put_parameter(Name=ssm_path, Value=efs_id, Type='String', Overwrite=True)
            logger.info(f'SSM {ssm_path} = {efs_id}')
    return {
        'restore_job_id':   job_id,
        'restore_complete': complete,
        'restore_status':   status,
        'efs_id':           efs_id,
    }


# â”€â”€ update_stack â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _update_stack_action(event):
    region      = os.environ['AWS_REGION']
    stack_name  = event.get('stack_name', '')
    stack_type  = event.get('stack_type', 'app')   # 'network' or 'app'
    extra       = event.get('extra_params', {})
    template_url = event.get('network_template_url',
                             os.environ.get('DEFAULT_NETWORK_TEMPLATE_URL', ''))

    cf = boto3.client('cloudformation', region_name=region)
    logger.info(f'Updating stack: {stack_name} (type={stack_type})')

    if stack_type == 'network':
        _cfn_update(cf, stack_name, extra, template_url=template_url or None)
    else:
        _cfn_update(cf, stack_name, extra)  # UsePreviousTemplate â€” avoids 51200-byte TemplateBody limit

    return {'stack_name': stack_name, 'submitted': True}


# â”€â”€ check_stack_status â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _check_stack_status(event):
    region     = os.environ['AWS_REGION']
    stack_name = event.get('stack_name', '')
    cf    = boto3.client('cloudformation', region_name=region)
    resp  = cf.describe_stacks(StackName=stack_name)
    stack = resp['Stacks'][0]
    status   = stack['StackStatus']
    complete = status in TERMINAL_STATES
    rollback = status in ROLLBACK_STATES
    params   = {p['ParameterKey']: p.get('ParameterValue', '')
                for p in stack.get('Parameters', [])}
    # Testing/re-run optimization: if the stack is already UPDATE_COMPLETE with
    # DeployPaidResources=true, the paid resources are already live â€” the state
    # machine can skip re-submitting the (slow) CFN update entirely.
    deploy_paid_active = complete and params.get('DeployPaidResources', '').lower() == 'true'
    logger.info(
        f'Stack {stack_name}: {status} DeployPaidResources={params.get("DeployPaidResources")}'
    )
    return {
        'stack_name':                   stack_name,
        'stack_status':                 status,
        'stack_complete':               complete,
        'stack_rollback':               rollback,
        'deploy_paid_resources_active': deploy_paid_active,
    }


# â”€â”€ notify â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _notify(event):
    topic   = event.get('sns_topic_arn', '')
    subject = event.get('subject', 'DR Failover Notification')
    message = event.get('message', '')
    if not topic:
        logger.info('No sns_topic_arn provided â€” skipping notification.')
        return {'notified': False}
    try:
        boto3.client('sns').publish(TopicArn=topic, Subject=subject, Message=message)
        logger.info(f'SNS notification sent: {subject}')
    except Exception:
        logger.warning('SNS publish failed', exc_info=True)
    return {'notified': True}


# â”€â”€ scale_ecs_service â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _scale_ecs_service(event):
    """
    Register a new ECS task definition revision using the latest image
    in the DR ECR repo, then update the service to desired_count.
    cluster_name and service_name are read from CFN stack outputs so
    the state machine doesn't need to hard-code them.
    ecr_repo and desired_count are optional â€” old payloads without
    them skip the image swap and default desired_count to 2.
    """
    inp           = event.get('input', event)
    region        = os.environ['AWS_REGION']
    stack_name    = inp.get('stack_name', '')
    ecr_repo      = inp.get('ecr_repo', '')
    desired_count = int(inp.get('desired_count', 2))

    cf           = boto3.client('cloudformation', region_name=region)
    cluster_name = _get_stack_output(cf, stack_name, 'ECSClusterName')
    service_name = _get_stack_output(cf, stack_name, 'EcsServiceName')
    if not cluster_name or not service_name:
        raise ValueError(
            f'ECSClusterName or EcsServiceName output missing from stack: {stack_name}'
        )

    ecs = boto3.client('ecs', region_name=region)
    svc        = ecs.describe_services(cluster=cluster_name, services=[service_name])['services'][0]
    td         = ecs.describe_task_definition(taskDefinition=svc['taskDefinition'])['taskDefinition']

    new_image = _get_latest_ecr_image(region, ecr_repo) if ecr_repo else None
    if new_image:
        logger.info(f'Latest DR ECR image: {new_image}')

    keep = {
        'family', 'taskRoleArn', 'executionRoleArn', 'networkMode',
        'containerDefinitions', 'volumes', 'placementConstraints',
        'requiresCompatibilities', 'cpu', 'memory',
        'pidMode', 'ipcMode', 'proxyConfiguration', 'inferenceAccelerators',
        'ephemeralStorage', 'runtimePlatform',
    }
    new_td = {k: v for k, v in td.items() if k in keep and v is not None}
    if new_image:
        for c in new_td.get('containerDefinitions', []):
            c['image'] = new_image

    new_td_arn = ecs.register_task_definition(**new_td)['taskDefinition']['taskDefinitionArn']
    logger.info(f'Registered task definition: {new_td_arn}')

    ecs.update_service(
        cluster=cluster_name,
        service=service_name,
        taskDefinition=new_td_arn,
        desiredCount=desired_count,
        forceNewDeployment=True,
    )
    logger.info(f'Service updated: {service_name} desiredCount={desired_count}')
    return {
        'stack_name':          stack_name,
        'cluster_name':        cluster_name,
        'service_name':        service_name,
        'task_definition_arn': new_td_arn,
        'desired_count':       desired_count,
        'image_uri':           new_image or 'unchanged',
    }


def _get_latest_ecr_image(region, repo_uri):
    """Return URI of the most recently pushed git-SHA-tagged image in an ECR repo."""
    import re
    registry = repo_uri.split('/')[0]
    repo     = '/'.join(repo_uri.split('/')[1:])
    ecr      = boto3.client('ecr', region_name=region)
    images   = ecr.describe_images(
        repositoryName=repo,
        filter={'tagStatus': 'TAGGED'},
    ).get('imageDetails', [])
    if not images:
        raise Exception(f'No tagged images in ECR repo: {repo}')
    images.sort(key=lambda x: x.get('imagePushedAt', 0), reverse=True)
    sha_re = re.compile(r'^[0-9a-f]{40}$')
    for image in images:
        sha_tags = [t for t in image.get('imageTags', []) if sha_re.match(t)]
        if sha_tags:
            tag = sha_tags[0]
            logger.info(f'Latest git-SHA image: {repo}:{tag}')
            return f'{registry}/{repo}:{tag}'
    raise Exception(f'No git-SHA-tagged images found in ECR repo: {repo}')


# â”€â”€ set_asg_capacity â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _set_asg_capacity(event):
    inp              = event.get('input', event)
    region           = os.environ['AWS_REGION']
    asg_name         = inp.get('asg_name') or ''
    tag_suffix       = inp.get('tag_suffix', '')
    app_stack_name   = event.get('app_stack_name', '')
    min_size         = int(inp.get('min_size', 0))
    desired_capacity = int(inp.get('desired_capacity', 0))
    max_size         = int(inp.get('max_size', desired_capacity))
    if not asg_name and not tag_suffix:
        raise ValueError('asg_name or tag_suffix is required for set_asg_capacity')
    if not asg_name:
        asg_name = _discover_live_asg(region, app_stack_name, tag_suffix)
        logger.info(f'Discovered ASG: {asg_name} (app_stack_name={app_stack_name} tag_suffix={tag_suffix})')
    if not asg_name:
        raise Exception(f'Could not resolve an ASG name for tag_suffix={tag_suffix}')
    asg = boto3.client('autoscaling', region_name=region)
    # Freeze dynamic scaling BEFORE setting DR capacity. Idle DR app servers sit
    # near 0% CPU, so a CPU target-tracking policy's AlarmLow (and any Scheduler
    # stack "stop" schedule) would otherwise claw the group back down to MinSize
    # within minutes â€” CheckASGsHealthy would then never see the desired count
    # InService and the failover would poll until the state machine's 1-year cap.
    # Suspend only AlarmNotification + ScheduledActions; Launch/Terminate/HealthCheck
    # stay active so the group can still reach the capacity we set. Resumed
    # implicitly at failback teardown (ASG desired=0 / stack delete).
    try:
        asg.suspend_processes(
            AutoScalingGroupName=asg_name,
            ScalingProcesses=['AlarmNotification', 'ScheduledActions'],
        )
        logger.info(f'Suspended AlarmNotification/ScheduledActions on {asg_name}')
    except ClientError:
        logger.warning(f'Could not suspend scaling processes on {asg_name}', exc_info=True)
    asg.update_auto_scaling_group(
        AutoScalingGroupName=asg_name,
        MinSize=min_size,
        MaxSize=max_size,
        DesiredCapacity=desired_capacity,
    )
    logger.info(f'ASG {asg_name}: min={min_size} desired={desired_capacity} max={max_size}')
    return {
        'asg_name':         asg_name,
        'min_size':         min_size,
        'desired_capacity': desired_capacity,
        'max_size':         max_size,
    }


# â”€â”€ check_all_asgs_healthy â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _check_all_asgs_healthy(event):
    """Poll all ASGs in asg_configs until desired instances reach InService.
    Returns an incremented 'attempts' counter so ASGsHealthyRoute can bound this
    poll loop and fail fast (HealthCheckTimedOut) instead of retrying for the whole
    execution lifetime if a group never reaches its target."""
    region         = os.environ['AWS_REGION']
    asg_configs    = event.get('asg_configs', [])
    app_stack_name = event.get('app_stack_name', '')
    attempt        = int(event.get('attempt', 0))
    asg_client     = boto3.client('autoscaling', region_name=region)
    all_healthy = True
    results     = []
    for cfg in asg_configs:
        asg_name   = cfg.get('asg_name') or ''
        tag_suffix = cfg.get('tag_suffix', '')
        desired    = int(cfg.get('desired_capacity', 0))
        if desired == 0:
            results.append({'asg_name': asg_name or tag_suffix, 'desired': 0, 'in_service': 0, 'healthy': True})
            continue
        if not asg_name:
            asg_name = _discover_live_asg(region, app_stack_name, tag_suffix)
        resp       = asg_client.describe_auto_scaling_groups(AutoScalingGroupNames=[asg_name])
        group      = resp['AutoScalingGroups'][0]
        in_service = len([i for i in group['Instances'] if i['LifecycleState'] == 'InService'])
        healthy    = in_service >= desired
        if not healthy:
            all_healthy = False
        logger.info(f'ASG {asg_name}: desired={desired} in_service={in_service} healthy={healthy}')
        results.append({'asg_name': asg_name, 'desired': desired, 'in_service': in_service, 'healthy': healthy})
    logger.info(f'All ASGs healthy: {all_healthy} (attempt {attempt + 1})')
    return {'all_healthy': all_healthy, 'asg_health': results, 'attempts': attempt + 1}


# â”€â”€ check_scale_results â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _check_scale_results(event):
    """ScaleASGs runs every ASG in parallel and isolates per-item failures (each
    iteration ends normally with {'failed': true, ...} instead of a Fail state) so
    one ASG erroring doesn't cancel its still-running siblings. This runs once after
    every iteration has actually been attempted, to decide whether the failover
    should proceed or stop."""
    results  = event.get('asg_results', [])
    failures = [r for r in results if r.get('failed')]
    if failures:
        logger.warning(f'ASG scaling failures: {failures}')
    return {'all_succeeded': not failures, 'failures': failures}


# â”€â”€ trigger_codedeploy / check_codedeploy â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _trigger_codedeploy(event):
    # Accepts event directly or wrapped under 'input' (state machine passes "input.$": "$")
    inp         = event.get('input', event)
    region      = os.environ['AWS_REGION']
    app_name    = inp.get('application_name', '')
    dg_name     = inp.get('deployment_group_name', '')
    s3_bucket   = inp.get('s3_bucket', '')
    s3_key      = inp.get('s3_key', '')
    s3_prefix   = inp.get('s3_prefix', 'app-')
    bundle_type = inp.get('bundle_type', 'zip')
    if not app_name or not s3_bucket:
        raise ValueError(
            'application_name and s3_bucket are required for trigger_codedeploy'
        )
    cd = boto3.client('codedeploy', region_name=region)
    if not dg_name:
        # Auto-discover: deployment group name has a random CFN suffix
        dg_list = cd.list_deployment_groups(applicationName=app_name).get('deploymentGroups', [])
        if not dg_list:
            raise Exception(f'No deployment groups found for application: {app_name}')
        dg_name = dg_list[0]
        logger.info(f'Auto-discovered deployment group: {dg_name}')
    if not s3_key:
        s3_key = _get_latest_s3_artifact(region, s3_bucket, s3_prefix)
    resp = cd.create_deployment(
        applicationName=app_name,
        deploymentGroupName=dg_name,
        revision={
            'revisionType': 'S3',
            's3Location': {
                'bucket':     s3_bucket,
                'key':        s3_key,
                'bundleType': bundle_type,
            },
        },
        ignoreApplicationStopFailures=True,
    )
    deployment_id = resp['deploymentId']
    logger.info(f'CodeDeploy deployment created: {deployment_id} ({app_name}/{dg_name}) s3_key={s3_key}')
    return {
        'deployment_id':          deployment_id,
        'application_name':       app_name,
        'deployment_group_name':  dg_name,
        's3_key':                 s3_key,
    }

def _get_latest_s3_artifact(region, bucket, prefix='app-'):
    """List all objects under prefix, return the key of the most recently modified one."""
    s3      = boto3.client('s3', region_name=region)
    objects = []
    kwargs  = {'Bucket': bucket, 'Prefix': prefix}
    while True:
        resp    = s3.list_objects_v2(**kwargs)
        objects.extend(resp.get('Contents', []))
        if resp.get('IsTruncated'):
            kwargs['ContinuationToken'] = resp['NextContinuationToken']
        else:
            break
    if not objects:
        raise Exception(f'No artifacts found in s3://{bucket} with prefix "{prefix}"')
    objects.sort(key=lambda o: o['LastModified'], reverse=True)
    key = objects[0]['Key']
    logger.info(f'Latest artifact in s3://{bucket}: {key} (modified={objects[0]["LastModified"]})')
    return key

def _check_codedeploy(event):
    region        = os.environ['AWS_REGION']
    deployment_id = event.get('deployment_id', '')
    if not deployment_id:
        raise ValueError('deployment_id is required for check_codedeploy')
    cd   = boto3.client('codedeploy', region_name=region)
    resp = cd.get_deployment(deploymentId=deployment_id)
    info      = resp['deploymentInfo']
    status    = info['status']
    complete  = status in ('Succeeded', 'Failed', 'Stopped')
    succeeded = status == 'Succeeded'
    logger.info(f'CodeDeploy {deployment_id}: {status}')
    return {
        'deployment_id':        deployment_id,
        'deployment_status':    status,
        'deployment_complete':  complete,
        'deployment_succeeded': succeeded,
    }


# â”€â”€ detach_codedeploy_asgs â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _detach_codedeploy_asgs(event):
    """
    Remove every ASG from a deployment group, which also removes CodeDeploy's
    managed launch hook from those ASGs.

    Run BEFORE ScaleASGs. While an ASG is attached to a deployment group, each
    instance it launches enters Pending:Wait and runs a full deployment of the
    group's LAST SUCCESSFUL revision before reaching InService. On a DR failover
    that revision is stale â€” the current build is deployed a second time straight
    afterwards â€” so the launch-time pass is a whole wasted deployment across the
    fleet, sitting on the critical path of the RTO.

    Detaching first lets instances boot from the DR AMI straight to InService with
    no deployment at all. UpdateCodeDeployGroups re-attaches the ASG after the fleet
    is up, and TriggerCodeDeployParallel then runs the single real deployment. That
    deployment succeeds (it has instances), so it becomes the group's last
    successful one and any later scale-out during the DR stay is current too.

    Idempotent: a no-op on a clean DR region. It matters on re-runs, because the DR
    region's deployment groups keep whatever wiring the previous drill left behind.
    """
    # Accepts event directly or wrapped under 'input' (state machine passes "input.$": "$")
    inp      = event.get('input', event)
    region   = os.environ['AWS_REGION']
    app_name = inp.get('application_name', '')
    if not app_name:
        raise ValueError('application_name is required for detach_codedeploy_asgs')
    cd       = boto3.client('codedeploy', region_name=region)
    dg_names = cd.list_deployment_groups(applicationName=app_name).get('deploymentGroups', [])
    if not dg_names:
        logger.info(f'No deployment groups for {app_name} â€” nothing to detach.')
        return {'application_name': app_name, 'detached': False}
    dg_name = dg_names[0]
    info    = cd.get_deployment_group(
        applicationName=app_name,
        deploymentGroupName=dg_name,
    )['deploymentGroupInfo']
    current = [g['name'] for g in info.get('autoScalingGroups', [])]
    if not current:
        logger.info(f'{app_name}/{dg_name} has no ASG attached â€” nothing to detach.')
        return {
            'application_name':      app_name,
            'deployment_group_name': dg_name,
            'detached':              False,
        }
    # Passing an empty list is how UpdateDeploymentGroup clears the ASGs. ec2TagFilters
    # is deliberately NOT passed â€” omitted fields are left untouched, and the tag
    # filters are irrelevant while nothing is being deployed.
    cd.update_deployment_group(
        applicationName=app_name,
        currentDeploymentGroupName=dg_name,
        autoScalingGroups=[],
    )
    logger.info(
        f'Detached {current} from {app_name}/{dg_name} â€” CodeDeploy launch hook removed, '
        f'instances will now reach InService without a deployment.'
    )
    return {
        'application_name':      app_name,
        'deployment_group_name': dg_name,
        'detached':              True,
        'previous_asgs':         current,
    }


# â”€â”€ update_codedeploy_group â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _update_codedeploy_group(event):
    # Accepts event directly or wrapped under 'input' (state machine passes "input.$": "$")
    inp            = event.get('input', event)
    region         = os.environ['AWS_REGION']
    app_name       = inp.get('application_name', '')
    tag_suffix     = inp.get('tag_suffix', '')
    app_stack_name = event.get('app_stack_name', '')
    if not app_name or not tag_suffix:
        raise ValueError(
            'application_name and tag_suffix are required '
            'for update_codedeploy_group'
        )
    # Deployment group name has a random CFN suffix â€” discover it
    cd       = boto3.client('codedeploy', region_name=region)
    dg_names = cd.list_deployment_groups(applicationName=app_name).get('deploymentGroups', [])
    if not dg_names:
        raise Exception(f'No deployment groups found for CodeDeploy application: {app_name}')
    dg_name = dg_names[0]
    logger.info(f'Discovered deployment group: {dg_name} (app={app_name})')
    # ASG resolution is pure tag discovery â€” see _discover_live_asg for why.
    asg_name = _discover_live_asg(region, app_stack_name, tag_suffix)
    # Switch from Ec2TagFilters to AutoScalingGroups so lifecycle hooks fire on scale-out
    cd.update_deployment_group(
        applicationName=app_name,
        currentDeploymentGroupName=dg_name,
        autoScalingGroups=[asg_name],
        ec2TagFilters=[],
    )
    logger.info(f'CodeDeploy group {app_name}/{dg_name} wired to ASG: {asg_name}')
    return {
        'application_name':      app_name,
        'deployment_group_name': dg_name,
        'asg_name':              asg_name,
    }

def _discover_live_asg(region, app_stack_name, tag_suffix):
    """Find the currently-live ASG for one app-server role (e.g. 'api', 'tre', 'skiq',
    'cs') by its LAUNCH TEMPLATE NAME â€” never by the ASG's own physical name, and
    never by asking CodeDeploy or walking CFN stack resources.

    ASG names are not stable: CodeDeploy blue/green replaces the original CFN-managed
    ASG with one it names itself ('CodeDeploy_<deployment-group-id>_d-<deployment-id>'),
    and every subsequent deployment renames it again to a new deployment ID â€” that name
    has no relationship to the app or role it belongs to.

    Tags are NOT a reliable match key either â€” confirmed against live pesonet20
    resources in us-east-2:
    - CFN auto-tags (aws:cloudformation:stack-id/stack-name, which would otherwise
      embed the nested stack's logical id e.g. 'TreasuryServerStack') are present on
      some CFN-native ASGs but were found completely absent from others (e.g. the live
      TreasuryServerStack ASG has no aws:cloudformation:* tags at all despite being
      CFN-native by name) â€” apparently dropped on some AutoScalingReplacingUpdate
      replacements, not just on CodeDeploy swaps.
    - The custom 'Name' tag (built by appserver-basic2.yaml as
      '<OrgName>-<EnvShort>-<RegionShort>-<Name>-<suffix>') can carry stale/wrong data:
      the live TreasuryServerStack ASG's Name tag reads '...-pesonet20-cs', not
      '...-pesonet20-tre' â€” real drift between a past deploy and the current template.
    - CodeDeploy blue/green replacement ASGs only inherit the plain custom Tags
      (Name/Environment/Organization/System), not the 'aws:'-namespaced CFN tags
      (CloudFormation is the only caller allowed to set those).

    LaunchTemplate.LaunchTemplateName IS reliable: appserver-basic2.yaml names it
    '<OrgName>-<EnvShort>-<RegionShort>-<Name>-<suffix>-LaunchTemplate', it's a real
    resource reference (not a freeform tag someone can mistype or that can silently
    drop), and it survives CodeDeploy blue/green â€” the replacement ASG launches
    instances from the same Launch Template as the original. Confirmed directly
    against all four pesonet20 app-server ASGs (cs/skiq/tre, still CFN-native, and
    api, already CodeDeploy-swapped) â€” every one's LaunchTemplateName correctly
    encodes '<app_stack_name>-<suffix>-LaunchTemplate' even where its tags did not.

    Matching requires BOTH app_stack_name and '<app_stack_name>-<tag_suffix>' (with a
    word boundary after the suffix) to appear in the LaunchTemplateName: app_stack_name
    alone would false-match a different app's identically-suffixed ASG (seen in
    practice â€” pesonet20 wired to ddp's api ASG); the bare suffix alone would match
    every app that happens to have an 'api' role.

    If more than one ASG matches (e.g. a stale pre-swap ASG lingering alongside its
    CodeDeploy replacement during a blue/green transition), the most recently created
    one is chosen and the rest are logged as stale candidates.
    """
    if not app_stack_name or not tag_suffix:
        raise ValueError('app_stack_name and tag_suffix are required to discover an ASG')
    import re
    pattern    = re.compile(re.escape(f'{app_stack_name}-{tag_suffix}') + r'(-|$)')
    asg_client = boto3.client('autoscaling', region_name=region)
    paginator  = asg_client.get_paginator('describe_auto_scaling_groups')
    candidates = []
    for page in paginator.paginate():
        for group in page.get('AutoScalingGroups', []):
            lt_spec = group.get('LaunchTemplate')
            if not lt_spec:
                mip = group.get('MixedInstancesPolicy') or {}
                lt_spec = ((mip.get('LaunchTemplate') or {})
                           .get('LaunchTemplateSpecification'))
            lt_name = (lt_spec or {}).get('LaunchTemplateName', '')
            if lt_name and pattern.search(lt_name):
                candidates.append(group)
    if not candidates:
        raise Exception(
            f'No ASG found with a LaunchTemplateName matching app_stack_name={app_stack_name!r} '
            f'tag_suffix={tag_suffix!r} (looked for "{app_stack_name}-{tag_suffix}-LaunchTemplate"). '
            f'Checked every ASG in region {region} by Launch Template name, not by ASG name or tags.'
        )
    if len(candidates) > 1:
        names = [c['AutoScalingGroupName'] for c in candidates]
        logger.warning(
            f'{len(candidates)} ASGs matched app_stack_name={app_stack_name!r} '
            f'tag_suffix={tag_suffix!r}: {names} â€” a stale pre-swap ASG may still '
            f'exist. Picking the most recently created.'
        )
    candidates.sort(key=lambda g: g.get('CreatedTime'), reverse=True)
    chosen = candidates[0]['AutoScalingGroupName']
    logger.info(f'Discovered live ASG by LaunchTemplateName: {chosen} (app_stack_name={app_stack_name} tag_suffix={tag_suffix})')
    return chosen


# â”€â”€ helpers â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€â”€

def _fetch_db_password(region, secret_arn):
    sm   = boto3.client('secretsmanager', region_name=region)
    resp = sm.get_secret_value(SecretId=secret_arn)
    secret = json.loads(resp['SecretString'])
    pw = secret.get('DB_ROOT_PASSWORD', '')
    if not pw:
        raise Exception(f'DB_ROOT_PASSWORD not in secret: {secret_arn}')
    return pw

def _find_latest_snapshot(region, db_id):
    rds = boto3.client('rds', region_name=region)
    for snap_type in ['manual', 'automated']:
        resp = rds.describe_db_snapshots(DBInstanceIdentifier=db_id, SnapshotType=snap_type)
        snaps = [s for s in resp.get('DBSnapshots', []) if s.get('Status') == 'available']
        if snaps:
            snaps.sort(key=lambda x: x['SnapshotCreateTime'], reverse=True)
            return snaps[0]['DBSnapshotArn']
    raise Exception(f'No available snapshots for: {db_id}')

def _find_latest_redshift_snapshot(region, cluster_id):
    rs = boto3.client('redshift', region_name=region)
    for snap_type in ['manual', 'automated']:
        resp = rs.describe_cluster_snapshots(ClusterIdentifier=cluster_id, SnapshotType=snap_type)
        snaps = [s for s in resp.get('Snapshots', []) if s.get('Status') == 'available']
        if snaps:
            snaps.sort(key=lambda x: x['SnapshotCreateTime'], reverse=True)
            return snaps[0]['SnapshotIdentifier']
    raise Exception(f'No available Redshift snapshots for: {cluster_id}')

def _get_stack_output(cf, stack_name, output_key):
    resp = cf.describe_stacks(StackName=stack_name)
    for o in resp['Stacks'][0].get('Outputs', []):
        if o['OutputKey'] == output_key:
            return o['OutputValue']
    return ''

def _tag_efs(region, efs_id, app_stack_name):
    efs_client = boto3.client('efs', region_name=region)
    name = f'{app_stack_name}-efs' if app_stack_name else efs_id
    try:
        efs_client.tag_resource(
            ResourceId=efs_id,
            Tags=[
                {'Key': 'Name',        'Value': name},
                {'Key': 'Environment', 'Value': 'DR'},
                {'Key': 'ManagedBy',   'Value': 'dr-failover-v2'},
            ],
        )
        logger.info(f'Tagged EFS {efs_id} with Name={name}')
    except Exception:
        logger.warning(f'Failed to tag EFS {efs_id}', exc_info=True)

def _create_efs_mount_targets(region, efs_id, network_stack, sg_id, cf=None):
    if cf is None:
        cf         = boto3.client('cloudformation', region_name=region)
    efs_client = boto3.client('efs', region_name=region)
    subnet1    = _get_stack_output(cf, network_stack, 'InternalSubnetId1')
    subnet2    = _get_stack_output(cf, network_stack, 'InternalSubnetId2')
    for subnet_id in [s for s in [subnet1, subnet2] if s]:
        try:
            mt = efs_client.create_mount_target(
                FileSystemId=efs_id,
                SubnetId=subnet_id,
                SecurityGroups=[sg_id] if sg_id else [],
            )
            logger.info(f'EFS mount target created: {mt["MountTargetId"]} subnet={subnet_id}')
        except ClientError as e:
            if e.response['Error']['Code'] == 'MountTargetConflict':
                logger.warning(f'Mount target already exists in subnet {subnet_id}')
            else:
                raise

def _find_latest_ami(region, org_name, app_name):
    ec2  = boto3.client('ec2', region_name=region)
    resp = ec2.describe_images(
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

def _fetch_as_yaml(cf, stack_name):
    resp = cf.get_template(StackName=stack_name, TemplateStage='Original')
    body = resp['TemplateBody']
    if isinstance(body, dict):
        logger.info(f'[FETCH_TEMPLATE] dict â†’ YAML | stack={stack_name}')
        return _cfn_to_yaml(body)
    if body.lstrip().startswith('{'):
        logger.info(f'[FETCH_TEMPLATE] JSON string â†’ YAML | stack={stack_name}')
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
    for key in extra_params:
        if key not in current:
            logger.warning(f'[UPDATE_STACK] Skipping {key!r} â€” not a parameter in the deployed template of {stack_name}')

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
