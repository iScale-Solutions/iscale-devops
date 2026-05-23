import json
import logging
import boto3
from botocore.exceptions import ClientError

logger = logging.getLogger()
logger.setLevel(logging.INFO)


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
    """Submit DeployPaidResources=false on a single stack. Returns {submitted, reason}."""
    params = []
    for p in _get_current_parameters(cfn, stack_name):
        if p['ParameterKey'] == 'DeployPaidResources':
            logger.info("[SET_DEPLOY_PAID_FALSE] Current value=%s | stack=%s", p['ParameterValue'], stack_name)
            params.append({'ParameterKey': 'DeployPaidResources', 'ParameterValue': 'false'})
        else:
            params.append({'ParameterKey': p['ParameterKey'], 'UsePreviousValue': True})
    try:
        cfn.update_stack(
            StackName=stack_name,
            UsePreviousTemplate=True,
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
    """Fetch template, patch it, return modified template + whether a change was made."""
    app_name = _get_app_name(event)
    logger.info("[PATCH] Start | stack=%s | action=%s", app_name, action)

    cfn = boto3.client('cloudformation')
    response = cfn.get_template(StackName=app_name, TemplateStage='Original')
    template_body = response['TemplateBody']

    if isinstance(template_body, dict):
        import json as _json
        template_body = _json.dumps(template_body, indent=2)
        logger.info("[PATCH] Template returned as dict by boto3 (CFN stores internally as JSON) — serialised to JSON string | stack=%s", app_name)
    else:
        first_char = template_body.lstrip()[:1]
        fmt = 'JSON' if first_char == '{' else 'YAML'
        logger.info("[PATCH] Template returned as string | format=%s | stack=%s", fmt, app_name)

    logger.info("[PATCH] Template downloaded | size=%d chars | stack=%s", len(template_body), app_name)

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
# Action: set_deploy_paid_false  (parameter-only update)
# ---------------------------------------------------------------------------

def _handle_set_deploy_paid_false(event: dict) -> dict:
    """
    Set DeployPaidResources=false on the target stack using UsePreviousTemplate.
    All other parameters are preserved via UsePreviousValue.
    Gracefully handles the case where DeployPaidResources is already false.
    """
    app_name = _get_app_name(event)
    logger.info("[SET_DEPLOY_PAID_FALSE] Start | stack=%s", app_name)

    cfn = boto3.client('cloudformation')
    result = _submit_deploy_paid_false(cfn, app_name)

    if result['submitted']:
        return {'submitted': True, 'stack_name': app_name}
    return {'submitted': False, 'reason': result.get('reason', 'already_false'), 'stack_name': app_name}


# ---------------------------------------------------------------------------
# Action: set_deploy_paid_false_both  (submit both stacks in parallel)
# ---------------------------------------------------------------------------

def _handle_set_deploy_paid_false_both(event: dict) -> dict:
    """
    Submit DeployPaidResources=false on both app_name and network_stack_name.
    network_stack_name defaults to '{app_name}-network' if omitted.
    Returns per-stack submission results.
    """
    app_name = _get_app_name(event)
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
        'app_name':          app_name,
        'network_stack_name': network_stack,
        'app_submitted':     app_result['submitted'],
        'network_submitted': network_result['submitted'],
    }


# ---------------------------------------------------------------------------
# Action: check_stack_status  (poll CloudFormation for terminal state)
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
    """
    Describe the stack and return its current status plus two boolean flags
    for the Step Functions Choice state to branch on:
      update_complete   — True when a terminal state is reached
      rollback_occurred — True when the terminal state is a rollback/failure
    """
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
# Action: check_both_stacks_status  (poll both app + network stacks)
# ---------------------------------------------------------------------------

def _handle_check_both_stacks_status(event: dict) -> dict:
    """
    Check both app_name and network_stack_name stacks.
    Returns:
      both_complete  — True when both are in a terminal state
      any_rollback   — True when either is in a rollback/failure state
    Fails fast: if either stack has rolled back, any_rollback=True regardless of the other.
    """
    app_name = _get_app_name(event)
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
        'app_name':            app_name,
        'network_stack_name':  network_stack,
        'app_status':          app_s['status'],
        'network_status':      network_s['status'],
        'both_complete':       both_complete,
        'any_rollback':        any_rollback,
    }


# ---------------------------------------------------------------------------
# Lambda entry point
# ---------------------------------------------------------------------------

def handler(event, context):
    """
    Dispatch table:

    action = "comment"                    → patch template (comment LB params)
    action = "uncomment"                  → patch template (restore LB params)
    action = "update_stack"               → submit CFN UpdateStack with provided template_body
    action = "set_deploy_paid_false"      → set DeployPaidResources=false via parameter update
    action = "set_deploy_paid_false_both" → set DeployPaidResources=false on app + network stacks
    action = "check_stack_status"         → poll CFN for terminal state (used by SFN polling loop)
    action = "check_both_stacks_status"   → poll both app + network stacks for terminal state

    Returns a flat dict for direct Step Functions consumption.
    """
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
