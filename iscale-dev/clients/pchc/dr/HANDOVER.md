# PCHC DR — Handover Notes

**Live region:** `us-west-2` (Oregon)
**DR region:** `us-east-2` (Ohio)
**Repo:** `iscale-devops` → `iscale-dev/clients/pchc/`
**Account ID:** `050821737631`

---

## DR Automation Stack Overview

| File | Deploy count | Purpose |
|---|---|---|
| `dr-failover.yaml` | Once per app | Per-app failover engine (Step Functions + Lambda). Has EventBridge rule embedded. |
| `dr-failover-v2.yaml` | Once total | **App-agnostic engine — use this going forward.** All app config passed in event payload. |
| `dr-failback.yaml` | Once total | Ordered teardown — Step Functions 4-step sequence (comment → set false → uncomment → network false). |

---

## What Was Done — Failover PITR Session

### 1. `dr-failover.yaml` — Converted from Lambda to Step Functions

Original was a single non-blocking Lambda (fire and forget). Rewritten as a **Step Functions state machine + worker Lambda** with two paths:

- **PITR path** (`use_pitr=true`) — `restore-db-instance-to-point-in-time` with `UseLatestRestorableTime=True`, ~5 min RPO
- **Snapshot path** (`use_pitr=false`) — original snapshot auto-discovery behavior, ~24h RPO (fallback)

Both paths: network stack update → DB restore → update Secrets Manager + SSM → app stack update. Each step polled to completion.

### 2. `dr-failover-v2.yaml` — New App-Agnostic Engine

Same Step Functions logic as v1 but:
- Deploy **once** (not 10 times for 10 apps)
- All app config (stack names, DB IDs, PITR params) passed in **state machine input payload** at invocation time
- Per-app EventBridge trigger rules will live in a future `dr-trigger-<app>.yaml`

See `DR-FAILOVER-V2.md` for full details.

### 3. `pesonet20.yaml` — PITR Mode Support Added

Two new parameters with **safe defaults — live Singapore stacks are completely unaffected**:

| Parameter | Default | Purpose |
|---|---|---|
| `IsPITRMode` | `'false'` | Suppresses `DBStack` when Step Functions sets `'true'` |
| `PITRDBEndpoint` | `''` | PITR instance endpoint injected by Step Functions before app stack update |

New conditions: `IsDeployPaidResourcesAndNotPITR`, `IsDashboardDeployedAndNotPITR`, etc.

All `!GetAtt [DBStack, Outputs.xxx]` references wrapped with `!If [IsPITRMode, <pitr-value>, <cfn-value>]`:
- `DatabaseEndpoint` → `PITRDBEndpoint`
- `DatabaseSecurityGroupId` → pre-deployed `DBStandbySecurityGroup`
- `DatabasePort` → `'3306'` (MySQL always)
- `SharedSecretId` → `DRDBSecret` (already updated with PITR endpoint by Step Functions)

### 4. Critical Bug Fix — Cross-Region PITR API Parameter

**Bug:** Used `SourceDBInstanceIdentifier` which looks for the source DB **in the DR region (us-east-2)** — not found, returned `DBInstanceNotFoundFault`.

**Fix:** Use `SourceDBInstanceAutomatedBackupsArn` — the ARN of the **replicated automated backup in us-east-2**. Auto-discovered via `describe_db_instance_automated_backups`.

```python
# WRONG — fails with DBInstanceNotFoundFault
SourceDBInstanceIdentifier = "pchc-test-uw2-pesonet20"

# CORRECT — cross-region restore
SourceDBInstanceAutomatedBackupsArn = "arn:aws:rds:us-east-2:...:auto-backup:..."
```

Fix applied to: `dr-failover.yaml`, `dr-failover-v2.yaml`, `dr-failover/handler.py`, `dr-failover-v2/handler.py`.

### 5. `handler.py` Companion Files Added

Lambda code lives in both the YAML `ZipFile` block AND a standalone Python file (mirrors `dr-failback/handler.py` pattern).

**Rule: edit `handler.py` first, then sync to `ZipFile` in the YAML.**

### 6. Key Design Decision — `database.yaml` Not Touched

PITR restore happens entirely via SDK outside CloudFormation. `DBStack` (which calls `database.yaml`) is suppressed via `IsPITRMode=true`. This keeps `database.yaml` clean and shared across all apps.

---

## Team Commits After PITR Session (same day)

These set up the EFS backup pipeline needed for the next task:

| Commit | What |
|---|---|
| `70d8554` | Extended `BackupStack` to all DR environments |
| `5b7e693` | Added opt-in hourly incremental backup plan to `backup.yaml` |
| `fe8661c` | **Cross-region EFS backup copy** — `EnableCrossRegionBackup` + `CrossRegionBackupVaultArn` params in `backup.yaml`. Live stack copies EFS backups to DR vault. |
| `9ee5d45` | Made DR vault ARN dynamic in `pesonet20.yaml` using `DRRegion` + `DREnvName` mappings |
| `da4e95c` | Extended `ProdBackupPlan` and `ProdBackupVault` to all DR environments in `backup.yaml` |
| `781a5f6` | **Always-on `DRBackupVault`** added to `pesonet20.yaml` (IsDR condition) — vault exists even when `DeployPaidResources=false`. `BackupStack` excluded from DR envs to avoid naming conflict at failover. |

**Net result:** EFS backup pipeline is now end-to-end. Live stack copies EFS backups cross-region to the DR vault. DR vault always exists (cold standby). Recovery points are available — but failover automation does not yet restore them.

---

## Current State

| Item | Status |
|---|---|
| Network stack failover (NAT GW, Jump Host) | Working |
| PITR DB restore via Step Functions | Bug fixed — **not yet re-tested after fix** |
| Snapshot DB restore (fallback path) | Should work — not re-tested after Step Functions rewrite |
| EFS backup → DR vault pipeline | Set up by team — recovery points exist |
| EFS restore at failover | **Implemented** — CheckEFSRecoveryPoint → RestoreEFS → CheckRestoreJob states in dr-failover-v2.yaml; handler.py actions: check_efs_recovery_point, restore_efs, check_restore_job |
| App servers (ASG, ALB, ElastiCache) | Should work once DB is up |
| Secrets Manager + SSM endpoint update | Implemented, not tested end-to-end |

**Pre-flight before re-testing PITR:**
```bash
# Must show Status: "replicating" or "retained" before triggering
aws rds describe-db-instance-automated-backups \
  --db-instance-identifier pchc-test-uw2-pesonet20 \
  --region us-east-2 \
  --query "DBInstanceAutomatedBackups[*].{Status:Status,ARN:DBInstanceAutomatedBackupsArn}"
```

---

## EFS Restore — Completed

### What was implemented

`dr-failover-v2.yaml` + `dr-failover-v2/handler.py` now fully restore EFS from AWS Backup before the app stack update. `pesonet20.yaml` passes the restored EFS ID to `TreasuryServerStack` via `ExternalEFSId`.

**State machine flow (inserted between UpdateSecrets and UpdateAppStackPITR):**

```
CheckEFSRecoveryPoint → EFSCheckRoute
  ├─ efs_found=true  → RestoreEFS → WaitEFSRestore (60s) → CheckRestoreJob
  │                                  └──────────────────────────────────┘ (poll loop)
  │                                        ↓ restore_complete=true → UpdateAppStackPITR
  └─ efs_found=false → SetNoEFS ($.efs_result.efs_id = "") → UpdateAppStackPITR
```

**Lambda actions added:**

| Action | What it does |
|---|---|
| `check_efs_recovery_point` | Queries DR vault, filters COMPLETED EFS recovery points, returns latest by CreationDate. Returns `efs_found: false` gracefully if vault missing/empty. |
| `restore_efs` | Calls `backup.start_restore_job` with `newFileSystem=true`. Returns `restore_job_id`. |
| `check_restore_job` | Polls job. On COMPLETED: looks up `EFSStandbySecurityGroupId` from app stack output, creates mount targets in InternalSubnetId1/2, writes EFS ID to SSM. |

**EFS SG — no manual rule management needed:**
`AllowExternalEFSConnectionFromAppServer` (Condition: `UseExternalEFS`) in `appserver-basic2.yaml` automatically adds NFS (2049) ingress from each app server SG (Treasury, API, Sidekiq, CS) to `EFSStandbySecurityGroup` during the app stack update. Identical to live region.

**Input payload keys (PITR path only — omit to skip EFS restore):**
```json
{
  "efs_backup_vault_name": "pchc-tdr-ue2-pesonet20-vault",
  "efs_id_ssm_path":       "/pchc/tdr/pesonet20/pitr-efs-id",
  "backup_role_arn":       "<BackupRestoreRoleArn output from dr-failover-v2 stack>"
}
```

**Files changed:**
- `dr-failover-v2.yaml` — `BackupRestoreRole` IAM resource, `BackupRestoreRoleArn` output, 7 new state machine states
- `dr-failover-v2/handler.py` — 3 new actions + `_get_stack_output` + `_create_efs_mount_targets` helpers
- `pesonet/pesonet20.yaml` — `ExternalEFSId` param, `EFSStandbySecurityGroup` resource (IsDR), `EFSStandbySecurityGroupId` output

---

## dr-failback.yaml — Reference

### 4-step failback workflow

```
Step 1 — Comment LoadBalancerStackName in app stack template → UpdateStack → poll
Step 2 — Set DeployPaidResources=false on app stack (DB, Cache, LBs, Servers down) → poll
Step 3 — Uncomment LoadBalancerStackName → UpdateStack → poll
Step 4 — Set DeployPaidResources=false on network stack (NAT GW, Jump Host down) → poll
```

Why comment/uncomment: `LoadBalancerStackName` creates a cross-stack export dependency. Deleting the LB while the reference exists causes a rollback. Commenting removes the dependency first.

### Trigger

```bash
aws stepfunctions start-execution \
  --state-machine-arn arn:aws:states:<region>:<account>:stateMachine:dr-failback \
  --input '{"app_name":"pchc-tdr-ue2-pesonet20","action":"failback","network_stack_name":"pchc-tdr-ue2-pesonet20-network"}'
```

---

## Architecture Rules — Do Not Revisit Without Strong Reason

1. **`database.yaml` stays untouched** — PITR/snapshot restore via SDK only, never through `database.yaml` changes.
2. **Live stack safety** — all new params in `pesonet20.yaml` must have safe defaults (`'false'` or `''`). Live Singapore stacks must be updatable at any time with zero behavior change.
3. **`dr-failover-v2.yaml` is the engine going forward** — v1 (`dr-failover.yaml`) kept for reference. All new work goes into v2.
4. **Snapshot path stays as fallback** — `use_pitr=false` keeps the original behavior. Never remove it.
5. **SSM as handoff point** — Step Functions writes resource IDs (DB endpoint, EFS ID) to SSM before app stack update. CloudFormation reads via `{{resolve:ssm:...}}`.
6. **handler.py is source of truth** — edit Python in `handler.py`, sync to `ZipFile` in the YAML. Never edit the YAML ZipFile directly.

---

## File Map

```
iscale-dev/clients/pchc/
├── dr/
│   ├── HANDOVER.md                   ← this file
│   ├── DR-FAILOVER-V2.md             ← detailed change doc for dr-failover-v2
│   ├── dr-failover.yaml              ← per-app failover (Step Functions, PITR fixed)
│   ├── dr-failover/
│   │   └── handler.py                ← Lambda source for dr-failover.yaml
│   ├── dr-failover-v2.yaml           ← app-agnostic engine (USE THIS)
│   ├── dr-failover-v2/
│   │   └── handler.py                ← Lambda source for dr-failover-v2.yaml
│   ├── dr-failback.yaml              ← teardown Step Functions
│   └── dr-failback/
│       └── handler.py                ← Lambda source for dr-failback.yaml
├── pesonet/
│   └── pesonet20.yaml                ← IsPITRMode, PITRDBEndpoint, DRBackupVault added
└── ...other apps...

iscale-dev/common/
├── backup.yaml                       ← cross-region EFS backup copy, hourly plan added
├── appserver-basic2.yaml             ← needs ExternalEFSId param (next task)
└── database.yaml                     ← NOT modified, do not touch
```

---

## Quick Reference — Trigger PITR Failover (Test)

```bash
# Step 1 — get stack outputs
aws cloudformation describe-stacks \
  --stack-name pchc-tdr-ue2-pesonet20 \
  --region us-east-2 \
  --query "Stacks[0].Outputs[?OutputKey=='DBStandbySubnetGroup'||OutputKey=='DBStandbySecurityGroupId'||OutputKey=='DRDBSecretArn'].{Key:OutputKey,Value:OutputValue}"

# Step 2 — get state machine ARN
aws cloudformation describe-stacks \
  --stack-name pchc-tdr-ue2-dr-failover \
  --region us-east-2 \
  --query "Stacks[0].Outputs[?OutputKey=='StateMachineArn'].OutputValue" --output text

# Step 3 — fire
aws stepfunctions start-execution \
  --state-machine-arn <arn> \
  --region us-east-2 \
  --input '{
    "app_name": "pesonet20",
    "org_name": "pchc",
    "use_pitr": true,
    "network_stack_name": "pchc-tdr-ue2-pesonet20-network",
    "app_stack_name": "pchc-tdr-ue2-pesonet20",
    "network_template_url": "https://iscale-dev-cloudformation.s3-us-west-2.amazonaws.com/common/network.yaml",
    "db_instance_identifier": "pchc-test-uw2-pesonet20",
    "dr_db_secret_arn": "arn:aws:secretsmanager:us-east-2:050821737631:secret:pchc-tdr-ue2-pesonet20-DqhIQI",
    "pitr_target_identifier": "pchc-tdr-ue2-pesonet20-pitr",
    "pitr_endpoint_ssm_path": "/pchc/tdr/pesonet20/pitr-db-endpoint",
    "pitr_subnet_group": "<DBStandbySubnetGroup output>",
    "pitr_security_group_id": "<DBStandbySecurityGroupId output>",
    "redshift_cluster_identifier": "",
    "redshift_snapshot_identifier": "",
    "snapshot_identifier": "",
    "db_master_password": "",
    "sns_topic_arn": "arn:aws:sns:us-east-2:050821737631:pchc-tdr-ue2-snstopic"
  }'
```
