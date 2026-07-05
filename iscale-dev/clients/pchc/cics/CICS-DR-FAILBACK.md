# CICS DR Failback — Runbook

Engine: [cics-dr-failback.yaml](cics-dr-failback.yaml) — the **reverse** of [cics-dr-failover.yaml](cics-dr-failover.yaml). Run it once the **main region is restored and healthy** to tear the DR region back down to cold / pilot-light and stop paying for the DR resources the failover brought up. Deploy it **once** in the DR region with the stack parameters below; trigger it by starting a Step Functions execution with the per-invocation payload.

> Read the failover runbook first — [CICS-DR-FAILOVER.md](CICS-DR-FAILOVER.md). Failback undoes exactly what it did, so the identifiers you passed at failover (PITR instance ids, SSM paths, DNS record) are the inputs here.

---

## What failback reverses

| Failover did | Failback does |
|---|---|
| `DNSCutover` → hostname aliased to **DR** ALB | **Repoints the hostname back to the MAIN ALB** (first, so clients drain off DR before teardown) |
| PITR-restored `cics` + `cicsfe` out of band | **Snapshots + deletes both PITR instances**, clears both endpoint SSM params |
| App stack `DeployPaidResources=true` (+`IsPITRMode=true`) | App stack **`DeployPaidResources=false`, `IsPITRMode=false`** (ELB, DB ingress/DNS, in-stack DBs torn down) |
| `StartCicsInstances` | ⚠️ **not reversed** — see "Known limitation" below. `DeployPaidResources=false` does **not** stop the EC2 app servers |
| Network scale-up: 4 `Create*` = `true` | **Network scale-down: 4 `Create*` = `false`** (`DeployPaidResources` untouched, as at failover) |

**Out of scope (same as failover):** FSx for OpenZFS. The DR file system was restored out of band — delete it manually after reconciling data back to main (see [README.md](README.md) §"DR FSx", activation-sequence step 6).

> ### ⚠️ Known limitation — EC2 app servers are not stopped
>
> `DeployPaidResources=false` tears down the ELB, DB ingress/DNS, and (snapshot path) the nested DBs — but **not** the EC2 app servers. In [cics.yaml](cics.yaml) the instances are gated on `None` (always) or `IsMainRegion` (second-AZ, absent in DR), **never** `IsDeployPaidResources`. So any `System=CICS` instances the failover's `StartCicsInstances` powered on **keep running (and billing) after failback**. Until this engine gains a `StopCicsInstances` step, stop them yourself:
> ```bash
> aws ec2 describe-instances --region <dr-region> \
>   --filters "Name=tag:System,Values=CICS" "Name=instance-state-name,Values=running" \
>   --query "Reservations[].Instances[].InstanceId" --output text \
> | xargs -r aws ec2 stop-instances --region <dr-region> --instance-ids
> ```
> (Or let the DR start/stop schedule stop them at its next window.) The two final DB snapshots failback takes (`<pitr-id>-failback-<ts>`) are also **retained** — delete them once the drill/data is no longer needed.

---

## Flow

```
RepointDNSMain (UPSERT hostname → MAIN ALB) ──► RouteByMode
  ├─ [use_pitr=true]  PITRCleanupParallel (both branches run simultaneously)
  │                   ├─ branch 1 (cics):   snapshot → poll → delete → poll gone → clear SSM
  │                   └─ branch 2 (cicsfe): snapshot → poll → delete → poll gone → clear SSM
  │                   └── both complete ──► ScaleDownAppStack
  │
  └─ [use_pitr=false] ScaleDownAppStack           (no out-of-band DBs to clean up)
       │
       ▼
  ScaleDownAppStack (DeployPaidResources=false, IsPITRMode=false) ─► poll until UPDATE_COMPLETE
  ScaleDownNetworkStack (CreateJumpHost/CreateMultipleNat/CreateVpcEndpoint/S3GatewayVpcEndpoint=false)
       ─► poll until UPDATE_COMPLETE ─► NotifyComplete ─► Complete / FailbackFailed
```

> **Why DNS first.** Failback presupposes the main region is already healthy. Repointing DNS before any teardown moves live traffic back to main immediately, so the DR stack is idle when it is scaled down. If `dns_record_name` is blank the repoint is skipped.

> **Why PITR cleanup before the app scale-down.** The out-of-band PITR instances hold a DB security group. `DeployPaidResources=false` on the app stack would fail to delete that SG (`DependencyViolation`) while the instances still reference it. Each DB is snapshotted (final manual snapshot, `SkipFinalSnapshot=true` on delete), deleted, then confirmed gone; the endpoint SSM param is cleared. Steps are **idempotent** — an already-deleted instance is skipped.

> **Network teardown is flag-flipping, not the master switch.** Failover never touched the network `DeployPaidResources`; it flipped four `Create*` flags. Failback flips the same four back to `false` and leaves `DeployPaidResources` alone. The update submits via `TemplateURL` (re-resolves `NatInstanceAMI`), same as failover.

---

## Stack parameters (set once at deploy)

| Parameter | Required | Meaning |
|---|---|---|
| `NetworkStackName` | yes | DR network stack — scaled back down via the four `Create*` flags |
| `NetworkTemplateUrl` | has default | S3 URL for `common/network.yaml` (avoids the 51,200-byte TemplateBody limit) |
| `AppStackName` | yes | The deployed `cics.yaml` stack in the DR region |
| `SnsTopicArn` | optional (`''`) | Completion/notification topic; blank = skip notify |
| `Name` / `OrgName` / `LogRetentionDays` | have defaults | Resource naming and log retention |

> Failback needs **fewer** stack params than failover — it does not restore DBs, so the source DB ids and DR secret ARNs are not required. It snapshots/deletes the PITR instances by the identifiers you pass in the payload.

---

## State machine input payload

Supply **every** key shown (use `""` for the ones a given path doesn't need — Step Functions errors on a missing `$.field` reference). On the snapshot path (`use_pitr=false`) the `pitr_*` keys are unused (keep them as `""`); no out-of-band DBs exist, so DB cleanup is skipped and the app scale-down removes the in-stack DBs.

```json
{
  "use_pitr":                   true,

  "pitr_target_identifier":     "pchc-productiondr-uw1-cics-pitr",
  "pitr_endpoint_ssm_path":     "/pchc/productiondr/cics/pitr-db-endpoint",
  "pitr_fe_target_identifier":  "pchc-productiondr-uw1-cicsfe-pitr",
  "pitr_fe_endpoint_ssm_path":  "/pchc/productiondr/cicsfe/pitr-db-endpoint",

  "dns_hosted_zone_id":         "Z0123456789ABCDEFGHIJ",
  "dns_record_name":            "cics.pchcdev.com",
  "dns_alb_dns_name":           "",
  "dns_alb_hosted_zone_id":     "",
  "dns_alb_name_contains":      "prd-ase1-cics",
  "dns_alb_region":             "ap-southeast-1"
}
```

### Field reference

| Key | Path | Meaning |
|---|---|---|
| `use_pitr` | both | `true` = also snapshot + delete the two PITR DBs; `false` = skip DB cleanup |
| `pitr_target_identifier` | PITR | The `cics` PITR instance id created at failover — snapshotted then deleted |
| `pitr_endpoint_ssm_path` | PITR | SSM param holding the `cics` endpoint — cleared after delete |
| `pitr_fe_target_identifier` / `pitr_fe_endpoint_ssm_path` | PITR | Same for the **`cicsfe`** DB |
| `dns_hosted_zone_id` | both | Client **public** hosted zone id (the zone for `ClientDomainName`) |
| `dns_record_name` | both | FQDN to repoint (e.g. `cics.pchcdev.com`); blank = skip DNS repoint |
| `dns_alb_dns_name` + `dns_alb_hosted_zone_id` | both | Explicit **MAIN** ALB alias target; blank = auto-discover |
| `dns_alb_name_contains` | both | Substring matched against the **MAIN** ALB name/DNS when the two above are blank |
| `dns_alb_region` | both | Region to search for the MAIN ALB (e.g. the live region); blank = this DR region |

> ⚠️ **The MAIN ALB lives in the main region, not the DR region where this engine runs.** Either pass `dns_alb_dns_name` + `dns_alb_hosted_zone_id` explicitly, **or** set `dns_alb_name_contains` **and** `dns_alb_region` so the engine can discover it cross-region. Auto-discovery with a blank `dns_alb_region` searches the DR region and — while the DR ALB is still up at the start of failback — would match the **DR** ALB and repoint the hostname at the load balancer you are about to delete. Always point discovery at the **main** region.

### Skip the DNS repoint

If DNS was **never cut over to DR** during failover (you left `dns_record_name` blank at failover, or main never fully went down), the hostname is already on the main ALB. Set `dns_record_name` to `""` here — the engine skips `RepointDNSMain` entirely and goes straight to teardown. Keep the other `dns_*` keys **present** (blank is fine); Step Functions still dereferences them.

### Snapshot-path payload

Set `"use_pitr": false` — there were never any out-of-band PITR instances, so DB cleanup is skipped and the app scale-down removes the in-stack DBs. The `pitr_*` keys are not dereferenced on this path; keep them as `""`:

```json
{
  "use_pitr":                   false,

  "pitr_target_identifier":     "",
  "pitr_endpoint_ssm_path":     "",
  "pitr_fe_target_identifier":  "",
  "pitr_fe_endpoint_ssm_path":  "",

  "dns_hosted_zone_id":         "Z0123456789ABCDEFGHIJ",
  "dns_record_name":            "cics.pchcdev.com",
  "dns_alb_dns_name":           "",
  "dns_alb_hosted_zone_id":     "",
  "dns_alb_name_contains":      "prd-ase1-cics",
  "dns_alb_region":             "ap-southeast-1"
}
```

---

## Pre-flight checklist

```bash
MAIN_REGION=ap-southeast-1
DR_REGION=us-west-1

# 1. Main region is actually restored and serving (the whole premise of failback)
aws elbv2 describe-load-balancers --region "$MAIN_REGION" \
  --query "LoadBalancers[?contains(LoadBalancerName,'cics')].{Name:LoadBalancerName,DNS:DNSName,State:State.Code}"
# Expected: State = "active"

# 2. The PITR instances you are about to delete (PITR path)
for ID in pchc-productiondr-uw1-cics-pitr pchc-productiondr-uw1-cicsfe-pitr; do
  aws rds describe-db-instances --db-instance-identifier "$ID" --region "$DR_REGION" \
    --query "DBInstances[0].{Id:DBInstanceIdentifier,Status:DBInstanceStatus}" 2>/dev/null \
    || echo "$ID: already gone"
done

# 3. Data on the DR PITR DBs has been reconciled back to main BEFORE deleting them.
#    Failback takes a final snapshot, but confirm main is the system of record first.

# 4. Client public hosted zone id (same one used at failover)
aws route53 list-hosted-zones-by-name --dns-name pchcdev.com \
  --query "HostedZones[0].Id" --output text
```

---

## Deploy

```bash
aws cloudformation deploy \
  --template-file cics-dr-failback.yaml \
  --stack-name cics-dr-failback --region us-west-1 \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    NetworkStackName=pchc-testdr-uw1-cics-network \
    AppStackName=pchc-productiondr-uw1-cics \
    SnsTopicArn=arn:aws:sns:us-west-1:<acct>:pchc-productiondr-uw1-cics-sns
```

---

## Trigger

```bash
aws stepfunctions start-execution \
  --state-machine-arn "$(aws cloudformation describe-stacks \
      --stack-name cics-dr-failback --region us-west-1 \
      --query "Stacks[0].Outputs[?OutputKey=='StateMachineArn'].OutputValue" --output text)" \
  --region us-west-1 \
  --input file://failback-payload.json
```

Or via Console: **Step Functions → `cics-dr-failback` → Start execution** with the JSON above.

Watch progress in the execution graph; worker logs are in `/aws/lambda/cics-dr-failback`, execution history in `/aws/states/cics-dr-failback`.

---

## Order of operations vs. failover

| # | Failover step | Failback step (reverse order) |
|---|---|---|
| 1 | Network scale-up | **DNS repoint → MAIN ALB** |
| 2 | Restore `cics` + `cicsfe` | **Cleanup `cics` + `cicsfe` PITR DBs** (snapshot + delete) |
| 3 | App `DeployPaidResources=true` | **App `DeployPaidResources=false`, `IsPITRMode=false`** |
| 4 | Start `System=CICS` EC2 | *(implicit — teardown removes them)* |
| 5 | DNS → DR ALB | **Network scale-down** (4 `Create*` = false) |

---

## Guardrails

- **Do not run a main-stack update mid-failback.** Per [README.md](README.md) §"Option B" guardrails, a main-stack update re-asserts the main ALB record — which is what failback wants — but running one *during* failback can race the `RepointDNSMain` UPSERT. Let failback own the repoint, or repoint via the main stack, not both.
- **Reconcile DR data back to main before triggering.** Failback deletes the PITR instances (after a final snapshot). Anything written on DR that hasn't been reconciled to main is only recoverable from that snapshot.
- **FSx OpenZFS is not touched.** Delete the restored DR file system out of band once data is reconciled.
- **A rollback aborts failback.** If the app or network stack update rolls back, the machine routes to `FailbackFailed` — check the CF console and CloudWatch Logs, resolve, and re-run (all steps are idempotent).

---

## Out of scope (handle separately)

- **FSx OpenZFS** DR file system deletion — restore/delete is out of band per [README.md](README.md) §"DR FSx".
- **Re-establishing DB backup replication** for the next DR cycle — the failover relies on cross-region automated backup replication being active; confirm it is still configured on the main-region DBs after failback.
