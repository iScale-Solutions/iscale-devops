# DR Engine — `dr-engine.yaml`

Centralized, app-agnostic disaster recovery orchestration for all PCHC applications.  
**Deployed once** in the DR region (`us-west-2`). All per-app `dr-failover` stacks target this engine's exported resources.

---

## Overview

```
┌──────────────────────────────────────────────────────────┐
│                   dr-engine.yaml (1 stack)               │
│                                                          │
│  FailoverLambda       ←── EventBridge (per-app trigger)  │
│  FailbackLambda       ←── FailbackStateMachine           │
│  FailbackStateMachine ←── EventBridge (per-app trigger)  │
└──────────────────────────────────────────────────────────┘
        ↕ (Fn::ImportValue)
┌──────────────────────┐   ┌──────────────────────┐
│  dr-failover (app A) │   │  dr-failover (app B) │  ...10 apps
└──────────────────────┘   └──────────────────────┘
```

Each PCHC app has its own `dr-failover` stack that registers EventBridge rules. Those rules import the engine's Lambda ARN and State Machine ARN via `Fn::ImportValue` and inject per-app config through an InputTransformer. The engine itself has no app-specific knowledge.

---

## Resources

| Resource | Type | Purpose |
|---|---|---|
| `FailoverLambdaRole` | IAM Role | Execution role for the Failover Lambda — broad provisioning permissions needed to update any app's CF stacks |
| `FailbackLambdaRole` | IAM Role | Execution role for the Failback Lambda — CloudFormation delete/update only |
| `StepFunctionsRole` | IAM Role | Allows the state machine to invoke `FailbackLambdaFunction` and write CloudWatch logs |
| `FailoverLambdaFunction` | Lambda (Python 3.12) | Non-blocking failover: discovers snapshot + AMI, updates network then app stack |
| `FailbackLambdaFunction` | Lambda (Python 3.12) | Step-by-step failback: called by the state machine for delete, poll, and teardown actions |
| `FailbackStateMachine` | Step Functions Standard | Orchestrates failback: delete server stacks → poll → teardown ELBs + network |

---

## Parameters

| Parameter | Default | Description |
|---|---|---|
| `SNSStackName` | `pchc-productiondr-uw2-sns` | SNS stack exporting `${SNSStackName}-TopicArn`. Topic ARN is set as env var on both Lambdas. |
| `SNSTopicArn` | *(blank)* | Optional direct ARN override for the SNS topic. Falls back to `SNSStackName` import if blank. |

---

## Stack Outputs (exported)

| Export Name | Description |
|---|---|
| `${StackName}-FailoverLambdaArn` | ARN of the Failover Lambda — imported by each per-app `dr-failover` stack |
| `${StackName}-FailoverLambdaName` | Name of the Failover Lambda |
| `${StackName}-FailbackStateMachineArn` | ARN of the Failback State Machine — imported by each per-app `dr-failover` stack |
| `${StackName}-FailbackStateMachineName` | Name of the Failback State Machine |

---

## Failover Lambda

**Function name:** `${StackName}-failover`  
**Timeout:** 60 seconds  
**Invocation:** Non-blocking — fires CloudFormation `update_stack` calls and returns immediately. CloudFormation provisions asynchronously (DB restore: 20–60 min).

### What it does

1. Auto-fetches DB master password from Secrets Manager (`DR_ROOT_PASSWORD` key in the secret at `dr_db_secret_arn`) — if not provided in the payload.
2. Auto-discovers the latest available RDS snapshot in the DR region for `db_instance_identifier` — tries `manual` first (cross-region copies), falls back to `automated`.
3. Auto-discovers the latest available DR AMI matching the pattern `{org_name}_{app_name}_dr-image_*`.
4. Updates the **network stack** with `DeployPaidResources=true` → provisions NAT Gateways, Jump Host, VPC Endpoints.
5. Updates the **app stack** with `DeployPaidResources=true` and injects `SnapshotIdentifier`, `DBMasterUserPassword`, `InstanceAMI` → provisions DB (from snapshot), Cache, LBs, App Servers.

### Event payload

All config is injected by the per-app `dr-failover` EventBridge InputTransformer. For direct Lambda invocation:

```json
{
  "app_name": "pesonet20",
  "org_name": "pchc",
  "app_stack_name": "pchc-productiondr-uw2-pesonet20",
  "network_stack_name": "pchc-productiondr-uw2-network",
  "db_instance_identifier": "pchc-productiondr-pesonet20-db",
  "dr_db_secret_arn": "arn:aws:secretsmanager:us-west-2:123456789012:secret:pchc-productiondr-pesonet20-db",
  "source_region": "ap-southeast-1",
  "snapshot_identifier": "",
  "db_master_password": ""
}
```

`snapshot_identifier` and `db_master_password` are optional — leave blank to auto-discover/auto-fetch.

### Direct invocation (fallback)

```bash
aws lambda invoke \
  --function-name pchc-productiondr-uw2-dr-engine-failover \
  --region us-west-2 \
  --payload '{
    "app_name": "pesonet20",
    "org_name": "pchc",
    "app_stack_name": "pchc-productiondr-uw2-pesonet20",
    "network_stack_name": "pchc-productiondr-uw2-network",
    "db_instance_identifier": "pchc-productiondr-pesonet20-db",
    "dr_db_secret_arn": "<secret-arn>",
    "source_region": "ap-southeast-1",
    "snapshot_identifier": "",
    "db_master_password": ""
  }' \
  response.json
```

---

## Failback Lambda

**Function name:** `${StackName}-failback`  
**Timeout:** 60 seconds  
**Invocation:** Called exclusively by `FailbackStateMachine` — not invoked directly by EventBridge.

### Actions

The Lambda dispatches on `event.action`:

| Action | Called by state | What it does |
|---|---|---|
| `delete_server_stacks` | `DeleteServerStacks` | Resolves physical stack IDs from logical IDs via `describe_stack_resource`, calls `delete_stack` on each (non-blocking). Skips stacks already in `DELETE_IN_PROGRESS` or `DELETE_COMPLETE`. |
| `check_deletion_status` | `CheckDeletionStatus` | Polls each server stack's resource status. Returns `{"all_deleted": true/false, "pending": [...]}`. |
| `teardown_infrastructure` | `TeardownInfrastructure` | Updates app stack then network stack with `DeployPaidResources=false`. Server stacks are already gone at this point so ELB cross-stack export dependencies are cleared. |
| `notify_failure` | `FailbackFailed` | Publishes failure notification to SNS before transitioning to the Fail state. |

---

## Failback State Machine

**Name:** `${StackName}-failback`  
**Type:** Standard (supports executions longer than 5 minutes; full visual audit trail in AWS console)

### Flow

```
[START]
   │
   ▼
ValidateConfirmFailback ──(confirm_failback ≠ true)──► FailbackRejected (Fail)
   │
   (confirm_failback = true)
   │
   ▼
DeleteServerStacks ──(error)──► FailbackFailed ──► FailState (Fail)
   │
   ▼
WaitForDeletion (30s)
   │
   ▼
CheckDeletionStatus ──(error)──► FailbackFailed ──► FailState (Fail)
   │
   ├──(all_deleted = false)──► WaitForDeletion  (loops until done)
   │
   └──(all_deleted = true)
          │
          ▼
   TeardownInfrastructure ──(error)──► FailbackFailed ──► FailState (Fail)
          │
         [END]
```

### Why server stacks are deleted first

CloudFormation tracks `Fn::ImportValue` statically — it will block any update that removes an export while another stack imports it, regardless of `!If` conditions. Server stacks (ASG/EC2) import ELB exports (listener ARNs, hosted zone IDs, DNS names). During failback, when `DeployPaidResources=false` removes ELB resources, CloudFormation refuses because the server stacks still hold active imports.

**Solution:** Delete the server stacks first. They are stateless — no data lives in them (data is in RDS, EFS, S3). Once they are gone, the ELB exports are unclaimed and CloudFormation allows the teardown update to proceed.

### Input payload (injected by EventBridge FailbackTriggerRule InputTransformer)

```json
{
  "confirm_failback": true,
  "app_name": "pesonet20",
  "app_stack_name": "pchc-productiondr-uw2-pesonet20",
  "network_stack_name": "pchc-productiondr-uw2-network",
  "server_stack_logical_ids": "TreasuryServerStack,APIServerStack,SidekiqServerStack,CustomerServiceServerStack",
  "source_region": "ap-southeast-1"
}
```

`confirm_failback: true` is a mandatory safety pin. The state machine fails immediately without it.

---

## Deployment

### Prerequisites

- SNS stack (`pchc-productiondr-uw2-sns`) must exist in `us-west-2` and export `${SNSStackName}-TopicArn`.
- Deploy this stack **before** any per-app `dr-failover` stacks — they import this stack's outputs.

### Deploy command

```bash
aws cloudformation deploy \
  --stack-name pchc-productiondr-uw2-dr-engine \
  --template-file iscale-dev/clients/pchc/dr/dr-engine.yaml \
  --region us-west-2 \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
  --parameter-overrides SNSStackName=pchc-productiondr-uw2-sns
```

### Upload to S3 (required before nested stack references)

```bash
aws s3 cp iscale-dev/clients/pchc/dr/dr-engine.yaml \
  s3://iscale-dev-cloudformation/clients/pchc/dr/dr-engine.yaml \
  --region us-west-2
```

---

## Wiring a new app

Deploy a `dr-failover` stack for the app with `EngineStackName` pointing to this stack:

```bash
aws cloudformation deploy \
  --stack-name pchc-productiondr-uw2-<APP>-failover \
  --template-file iscale-dev/clients/pchc/dr/dr-failover.yaml \
  --region us-west-2 \
  --capabilities CAPABILITY_IAM CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    AppName=<app> \
    OrgName=pchc \
    EngineStackName=pchc-productiondr-uw2-dr-engine \
    NetworkStackName=pchc-productiondr-uw2-network \
    AppStackName=pchc-productiondr-uw2-<app> \
    SNSStackName=pchc-productiondr-uw2-sns \
    DBInstanceIdentifier=<dr-db-instance-id> \
    DRDBSecretArn=<dr-secret-arn> \
    ServerStackLogicalIds=<comma-separated-logical-ids>
```

`ServerStackLogicalIds` must list every nested server stack (ASG/EC2) in the app stack that imports ELB exports. For `pesonet20` this is:

```
TreasuryServerStack,APIServerStack,SidekiqServerStack,CustomerServiceServerStack
```

---

## Triggering failover via EventBridge

```bash
aws events put-events \
  --region us-west-2 \
  --entries '[{
    "Source": "pchc.dr.failover",
    "DetailType": "FailoverRequest",
    "EventBusName": "default",
    "Detail": "{\"app_name\":\"pesonet20\",\"snapshot_identifier\":\"\",\"db_master_password\":\"\"}"
  }]'
```

Leave `snapshot_identifier` and `db_master_password` blank to use auto-discovery.

---

## Triggering failback via EventBridge

Run this **only after** DNS has been switched back to Singapore and the primary environment is confirmed stable.

```bash
aws events put-events \
  --region us-west-2 \
  --entries '[{
    "Source": "pchc.dr.failover",
    "DetailType": "FailbackRequest",
    "EventBusName": "default",
    "Detail": "{\"app_name\":\"pesonet20\",\"confirm_failback\":true}"
  }]'
```

The EventBridge rule in the per-app `dr-failover` stack catches this event and starts the `FailbackStateMachine` with the full payload injected by the InputTransformer (stack names, logical IDs, etc.).

---

## Monitoring

| Where | What to check |
|---|---|
| AWS Step Functions console → `pchc-productiondr-uw2-dr-engine-failback` | Execution status, per-state output, error details |
| CloudWatch Logs → `/aws/lambda/${StackName}-failover` | Failover Lambda logs: snapshot/AMI discovery, stack update calls |
| CloudWatch Logs → `/aws/lambda/${StackName}-failback` | Failback Lambda logs: per-stack delete/check/teardown progress |
| SNS topic | Notifications on failover initiated, failback initiated, teardown initiated, any failure |
| EventBridge rule `${app}-stack-completion` (in each dr-failover stack) | CloudFormation `UPDATE_COMPLETE` / `UPDATE_ROLLBACK_COMPLETE` notifications per app |
