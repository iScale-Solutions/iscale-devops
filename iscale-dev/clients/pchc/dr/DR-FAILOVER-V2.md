# DR Failover V2 — Change Summary

## Overview

`dr-failover-v2.yaml` replaces the per-app failover model with a single app-agnostic engine.
It introduces a Step Functions state machine with two restore paths — PITR (primary) and snapshot (fallback) — and fixes the cross-region PITR restore to use the correct AWS API parameter.

---

## What Changed

### 1. Architecture — From Per-App Lambda to Centralized Engine

| | `dr-failover.yaml` (old) | `dr-failover-v2.yaml` (new) |
|---|---|---|
| Deploy count | Once per app (10 stacks) | Once total |
| App config | Env vars baked at deploy time | Event payload at invocation time |
| Lambda | 1 per app | 1 shared worker |
| State machine | 1 per app | 1 shared |
| EventBridge rule | Embedded in each stack | Separate `dr-trigger-<app>.yaml` (future) |
| Trigger target | Lambda directly | Step Functions state machine |
| Execution model | Non-blocking (fire and forget) | Orchestrated with polling and error handling |

### 2. Step Functions State Machine (New)

The old `dr-failover.yaml` fired `update_stack()` and returned immediately. CloudFormation provisioned asynchronously with no visibility.

The new state machine orchestrates every step with polling, retries, and failure detection:

```
Discover
  └─ UpdateNetworkStack → poll until UPDATE_COMPLETE
       └─ RouteByMode
            ├─ [use_pitr=true]  PITRRestore → poll until DB available
            │                   UpdateSecrets (Secrets Manager + SSM)
            │                   UpdateAppStackPITR (IsPITRMode=true)
            │                   └─ poll until UPDATE_COMPLETE
            │
            └─ [use_pitr=false] UpdateAppStackSnapshot (SnapshotIdentifier)
                                └─ poll until UPDATE_COMPLETE

            → NotifyComplete (SNS)
            → Complete / FailoverFailed
```

### 3. PITR Path (New)

The old template always restored from a snapshot (`restore-db-instance-from-db-snapshot`), giving up to 24-hour RPO.

The PITR path uses `restore-db-instance-to-point-in-time` with `UseLatestRestorableTime=True`, giving **~5 min RPO** from the cross-region automated backup replication already set up via `DBReplicationStack` in `pesonet20.yaml`.

Key design decisions:
- DB is restored **outside CloudFormation** by the Step Functions worker Lambda
- App stack is updated with `IsPITRMode=true` — this suppresses `DBStack` in `pesonet20.yaml` so CloudFormation does not create a second DB instance
- PITR endpoint is written to **Secrets Manager** and **SSM Parameter Store** before the app stack update so app servers connect to the right DB on startup
- Pre-deployed `DBStandbySubnetGroup` and `DBStandbySecurityGroup` from the app stack are used for the restored instance — no new networking resources needed

### 4. Cross-Region PITR Fix — `SourceDBInstanceAutomatedBackupsArn`

**Bug in `dr-failover.yaml`:** `pitr_restore` used `SourceDBInstanceIdentifier` which looks for the source DB instance in the **DR region**. The source instance lives in the **live region (us-west-2)**, so RDS in us-east-2 always returned `DBInstanceNotFoundFault`.

**Fix in `dr-failover-v2.yaml`:** Uses `SourceDBInstanceAutomatedBackupsArn` — the ARN of the replicated automated backup in the DR region — which is the correct parameter for cross-region PITR restores. The ARN is auto-discovered via `describe_db_instance_automated_backups`.

```python
# Before (wrong for cross-region)
SourceDBInstanceIdentifier = "pchc-test-uw2-pesonet20"   # not found in us-east-2

# After (correct for cross-region)
SourceDBInstanceAutomatedBackupsArn = "arn:aws:rds:us-east-2:...:auto-backup:..."
```

This fix was also backported to `dr-failover.yaml` and both `handler.py` files.

### 5. Snapshot Path Preserved (Fallback)

Setting `use_pitr=false` in the event payload follows the original snapshot restore flow. Useful when:
- Cross-region automated backup replication is not yet set up
- A specific snapshot ARN needs to be targeted
- PITR is unavailable (backup replication still initialising)

### 6. `pesonet20.yaml` — PITR Mode Support (New Parameters)

Two new parameters added with safe defaults so **live Singapore stacks are completely unaffected**:

| Parameter | Default | Purpose |
|---|---|---|
| `IsPITRMode` | `false` | Suppresses `DBStack` when set to `true` by the Step Functions machine |
| `PITRDBEndpoint` | `''` | PITR instance endpoint passed to app servers when `IsPITRMode=true` |

New conditions added:
- `IsDeployPaidResourcesAndNotPITR` — gates `DBStack`, `DBSchedulerStack`, `BackupStack`
- `IsDashboardDeployedAndNotPITR` — gates the CloudWatch dashboard

All `!GetAtt [DBStack, Outputs.xxx]` references in server stacks are wrapped with `!If [IsPITRMode, <pitr-value>, <original-value>]`:
- `DatabaseEndpoint` → `PITRDBEndpoint` in PITR mode
- `DatabaseSecurityGroupId` → pre-deployed `DBStandbySecurityGroup` in PITR mode
- `DatabasePort` → `3306` (hardcoded, MySQL always) in PITR mode
- `SharedSecretId` → `DRDBSecret` (already updated with PITR endpoint) in PITR mode

### 7. Companion `handler.py` Files (New)

Mirrors the `dr-failback/handler.py` pattern — the Lambda code lives in two places:

```
dr/
├── dr-failover.yaml
├── dr-failover/
│   └── handler.py          ← readable source for dr-failover.yaml Lambda
├── dr-failover-v2.yaml
└── dr-failover-v2/
    └── handler.py          ← readable source for dr-failover-v2.yaml Lambda
```

The `handler.py` files are the source of truth for editing. After changes, sync to the `ZipFile` block in the corresponding YAML.

---

## Files Changed

| File | Change |
|---|---|
| `dr/dr-failover-v2.yaml` | New — app-agnostic failover engine |
| `dr/dr-failover-v2/handler.py` | New — Lambda source for v2 |
| `dr/dr-failover/handler.py` | New — Lambda source for v1 |
| `dr/dr-failover.yaml` | Updated — PITR fix (`SourceDBInstanceAutomatedBackupsArn`), converted to Step Functions |
| `pesonet/pesonet20.yaml` | Updated — `IsPITRMode`, `PITRDBEndpoint` params, PITR-mode condition guards |

---

## State Machine Input Payload

```json
{
  "app_name":                  "pesonet20",
  "org_name":                  "pchc",
  "use_pitr":                  true,
  "network_stack_name":        "pchc-productiondr-ue2-pesonet20-network",
  "app_stack_name":            "pchc-productiondr-ue2-pesonet20",
  "network_template_url":      "https://iscale-dev-cloudformation.s3-us-west-2.amazonaws.com/common/network.yaml",
  "db_instance_identifier":    "<source DB identifier in live region>",
  "dr_db_secret_arn":          "<DRDBSecretArn output from app stack>",
  "pitr_target_identifier":    "<name for the new PITR instance — must not exist>",
  "pitr_endpoint_ssm_path":    "/pchc/productiondr/pesonet20/pitr-db-endpoint",
  "pitr_subnet_group":         "<DBStandbySubnetGroup output from app stack>",
  "pitr_security_group_id":    "<DBStandbySecurityGroupId output from app stack>",
  "redshift_cluster_identifier":   "",
  "redshift_snapshot_identifier":  "",
  "snapshot_identifier":       "",
  "db_master_password":        "",
  "sns_topic_arn":             "<SNS topic ARN>"
}
```

**Key field notes:**
- `db_instance_identifier` — identifier of the source DB in the live region (us-west-2). Used to find the replicated automated backup ARN in us-east-2 via `describe_db_instance_automated_backups`.
- `pitr_target_identifier` — name for the new DB instance to be created in us-east-2. Must not already exist.
- `pitr_subnet_group` / `pitr_security_group_id` — get these from the DR app stack outputs before triggering.
- `db_master_password` — leave blank if `dr_db_secret_arn` is set; auto-fetched from Secrets Manager.
- `snapshot_identifier` — leave blank when `use_pitr=true`.

---

## Pre-Flight Checklist Before Triggering

```bash
# 1. Confirm replicated automated backup exists and is replicating
aws rds describe-db-instance-automated-backups \
  --db-instance-identifier <source-db-id> \
  --region us-east-2 \
  --query "DBInstanceAutomatedBackups[*].{Status:Status,ARN:DBInstanceAutomatedBackupsArn}"
# Expected: Status = "replicating" or "retained"

# 2. Get DBStandbySubnetGroup and DBStandbySecurityGroupId from app stack
aws cloudformation describe-stacks \
  --stack-name pchc-productiondr-ue2-pesonet20 \
  --region us-east-2 \
  --query "Stacks[0].Outputs[?OutputKey=='DBStandbySubnetGroup'||OutputKey=='DBStandbySecurityGroupId'].{Key:OutputKey,Value:OutputValue}"

# 3. Get DRDBSecretArn from app stack
aws cloudformation describe-stacks \
  --stack-name pchc-productiondr-ue2-pesonet20 \
  --region us-east-2 \
  --query "Stacks[0].Outputs[?OutputKey=='DRDBSecretArn'].OutputValue" \
  --output text
```

---

## How to Trigger

Via AWS Console: **Step Functions → `dr-failover` state machine → Start execution** with the JSON payload above.

Via CLI:
```bash
aws stepfunctions start-execution \
  --state-machine-arn <StateMachineArn from stack output> \
  --region us-east-2 \
  --input '<json payload>'
```

---

## RPO / RTO Summary

| Path | RPO | RTO | When to use |
|---|---|---|---|
| PITR (`use_pitr=true`) | ~5 min | ~35–85 min | Default — automated backup replication active |
| Snapshot (`use_pitr=false`) | Up to 24h | ~35–85 min | Fallback — PITR not available |
