# PCHC DR — Handover Notes

## Overview

Two CloudFormation stacks handle DR automation for PCHC applications. They are independent — each is deployed once per app.

| Stack | File | Purpose |
|-------|------|---------|
| `dr-failover` | `dr-failover.yaml` | Activates DR (sets `DeployPaidResources=true`) and tears it down (failback via `DeployPaidResources=false`). Triggered by EventBridge. Non-blocking Lambda. |
| `dr-failback` | `dr-failback.yaml` | Orchestrates the full ordered failback sequence via Step Functions. Handles template patching + parameter updates in the correct order. |

---

## dr-failover.yaml

### What it does
A Lambda + two EventBridge rules scoped to a specific `app_name`. Non-blocking — fires `update_stack` calls and returns immediately. CloudFormation provisions/deprovisions asynchronously.

- **Failover**: sets `DeployPaidResources=true` on network stack first, then app stack. Auto-discovers latest DR AMI and RDS snapshot.
- **Failback**: sets `DeployPaidResources=false` on app stack first, then network stack. Requires `confirm_failback=true` as a safety pin.

### Trigger payloads

**Failover via EventBridge:**
```json
{
  "Source": "pchc.dr.failover",
  "DetailType": "FailoverRequest",
  "Detail": {
    "app_name": "pesonet20",
    "snapshot_identifier": "<rds-snapshot-arn-or-blank>",
    "db_master_password": "<password-or-blank>"
  }
}
```

**Failback via EventBridge:**
```json
{
  "Source": "pchc.dr.failover",
  "DetailType": "FailbackRequest",
  "Detail": {
    "app_name": "pesonet20",
    "confirm_failback": true
  }
}
```

**Direct Lambda invocation:**
```json
{ "mode": "failover", "snapshot_identifier": "<arn>", "db_master_password": "<pw>" }
{ "mode": "failback", "confirm_failback": true }
```

### Notes
- `snapshot_identifier` and `db_master_password` are auto-discovered if blank (requires `DBInstanceIdentifier` and `DRDBSecretArn` parameters set on the stack).
- `UsePreviousTemplate=True` is intentional here — dr-failover never reads the template back, so format normalisation to JSON is harmless.

---

## dr-failback.yaml

### What it does
A Lambda + Step Functions Standard state machine that runs the full ordered failback sequence. Blocking — polls CloudFormation until each step is terminal before proceeding to the next.

### Lambda source
The Lambda code lives in two places that must be kept in sync:
- `dr-failback/handler.py` — source of truth for development/review
- `dr-failback.yaml` ZipFile — what actually gets deployed; must match `handler.py`

### 4-step failback workflow (`action: "failback"`)

```
Step 1 — Comment LoadBalancerStackName
  → Patches app stack template (YAML text-level, no parser)
  → Submits UpdateStack with patched template
  → Polls until UPDATE_COMPLETE

Step 2 — Set DeployPaidResources=false (app stack)
  → DB, Cache, LBs, App Servers down
  → Polls until UPDATE_COMPLETE

Step 3 — Uncomment LoadBalancerStackName
  → Restores app stack template
  → Submits UpdateStack with restored template
  → Polls until UPDATE_COMPLETE

Step 4 — Set DeployPaidResources=false (network stack only)
  → NAT Gateways, Jump Host, VPC Endpoints down
  → Polls until UPDATE_COMPLETE
```

> **Why Comment/Uncomment?** The app stack references `LoadBalancerStackName` which imports from a cross-stack export. Setting `DeployPaidResources=false` would delete the LB, which would break the export reference and cause a rollback. Commenting it out first removes the dependency so the stack can safely delete the LB.

### Step Functions input payloads

| Action | Payload | Description |
|--------|---------|-------------|
| `failback` | `{"app_name": "...", "action": "failback", "network_stack_name": "..."}` | Full 4-step ordered failback |
| `comment` | `{"app_name": "...", "action": "comment"}` | Comment out `LoadBalancerStackName` only |
| `uncomment` | `{"app_name": "...", "action": "uncomment"}` | Restore `LoadBalancerStackName` only |
| `set_deploy_paid_false` | `{"app_name": "...", "action": "set_deploy_paid_false"}` | Set `DeployPaidResources=false` + poll |

> `network_stack_name` defaults to `{app_name}-network` if omitted.

**Start an execution via CLI:**
```bash
aws stepfunctions start-execution \
  --state-machine-arn arn:aws:states:<region>:<account>:stateMachine:dr-failback \
  --input '{"app_name":"pchc-tdr-ue2-pesonet","action":"failback","network_stack_name":"pchc-tdr-ue2-pesonet-network"}'
```

### Lambda actions (internal, called by state machine)

| Action | Description |
|--------|-------------|
| `comment` | Fetch template, comment out `LoadBalancerStackName` in all `*ServerStack` resources |
| `uncomment` | Fetch template, restore `LoadBalancerStackName` in all `*ServerStack` resources |
| `update_stack` | Submit UpdateStack with a provided template body |
| `set_deploy_paid_false` | Set `DeployPaidResources=false` on one stack + return submitted flag |
| `set_deploy_paid_false_both` | Set `DeployPaidResources=false` on app + network simultaneously |
| `check_stack_status` | Describe one stack; returns `update_complete`, `rollback_occurred`, `status` |
| `check_both_stacks_status` | Describe both stacks; returns `both_complete`, `any_rollback` |

---

## Key technical decisions

### YAML template preservation
CloudFormation can normalise a YAML template to JSON internally when `UsePreviousTemplate=True` is used. Once normalised to JSON, the text-level YAML patcher (`comment`/`uncomment`) fails because it looks for `LoadBalancerStackName:` which no longer exists in that form.

**Fix**: `_fetch_as_yaml` always returns the template as a YAML string (converts dict/JSON response via `_cfn_to_yaml`). `_submit_deploy_paid_false` submits `TemplateBody` explicitly to preserve format.

**Exception**: If the template exceeds 51,200 bytes (CloudFormation's `TemplateBody` API limit), it falls back to `UsePreviousTemplate=True`. This is safe because:
- The app stack (steps 1–3) is small enough to always use `TemplateBody`.
- The network stack (step 4) is large and uses the fallback, but step 4 is the last step — nothing reads its template format afterwards.

### Template patcher
`_patch_cfn_parameter` is a single-pass state machine (no YAML parser). It walks every `*ServerStack` resource, enters the `Properties.Parameters` block, and comments/uncomments the target key plus any continuation lines. Pure stdlib — no PyYAML dependency (not available in Lambda Python 3.12 runtime by default).

### `_cfn_to_yaml`
Pure stdlib dict-to-YAML converter. Used when `get_template` returns a Python `dict` (boto3 deserialises JSON-stored templates automatically) or a JSON string. Handles all CFN template structures: nested dicts, lists, intrinsic functions (`Fn::Sub`, `Ref`, etc.), scalars with special characters.

---

## Files

```
clients/pchc/dr/
├── dr-failover.yaml          # EventBridge-triggered failover/failback Lambda
├── dr-failback.yaml          # Step Functions state machine + Lambda (ZipFile)
├── dr-failback/
│   └── handler.py            # Lambda source (keep in sync with ZipFile above)
└── old-dr/                   # Previous DR engine implementations (archived)
```

---

## Known gaps / next steps

- **dr-failover.yaml `update_stack` and large templates**: If the network or app stack template exceeds 51,200 bytes, `dr-failover.yaml`'s `update_stack` will hit the same constraint error. dr-failover uses `TemplateBody` (added for consistency) but since it never reads the template back, it could safely use `UsePreviousTemplate=True` instead — or apply the same size-check fallback as dr-failback.
- **No S3 template storage**: Large templates would be better served by uploading to S3 and using `TemplateURL`. This would remove the 51,200 byte constraint entirely.
- **dr-failback does not handle failover** — that is intentional. Use `dr-failover.yaml` to activate DR.
