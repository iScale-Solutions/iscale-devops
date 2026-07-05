# CICS DR Failover — Runbook

Engine: [cics-dr-failover.yaml](cics-dr-failover.yaml) — a CICS-dedicated fork of the app-agnostic [dr/dr-failover-v2.yaml](../dr/dr-failover-v2.yaml). Deploy it **once** in the DR region with the stack parameters below (stack names, DB ids, secret ARNs, SNS topic); trigger it by starting a Step Functions execution with the much smaller per-invocation payload.

---

## Why a dedicated engine (not dr-failover-v2)

CICS differs from the apps the generic engine was built for (pesonet, SmartAPI):

| Generic engine assumes | CICS reality | Effect on this engine |
|---|---|---|
| One app stack (+ optional child stacks) | **Single monolithic** [cics.yaml](cics.yaml); `DBStack`/`DBFEStack`/`ELBStack`/`FileServerStack`/`BackupStack` are all nested | Removed the `ecs_app_group` / prereq / `parallel_stacks` machinery — one app-stack update only |
| One database | **Two** — `cics` (`DBStack`) **and** `cicsfe` (`DBFEStack`) | Restores **both** DBs and updates **both** DR secrets |
| EFS via AWS Backup | **FSx for OpenZFS** (NFS), gated `IsMainRegion` | EFS restore removed; FSx handled out of band (see [README.md](README.md) §"DR FSx") |
| `{org}_{app}_dr-image_*` AMI discovery + Redshift | Hard-coded SIOS/Windows AMIs, no Redshift | AMI/Redshift discovery removed |
| `PITRDBEndpoint` param wired into every server | CICS has only `IsPITRMode` (suppresses the DB stacks) | App servers read the endpoint from the **DR secret** (`DB_HOST`), written by `update_secrets` |
| — | CICS needs the public hostname repointed | Added an explicit **Route53 cutover** to the DR ALB ([README.md](README.md) §"Option B") |

---

## Flow

```
UpdateNetworkStack (scale-up flags) ──► poll until UPDATE_COMPLETE
  └─ RouteByMode
       ├─ [use_pitr=true]  PITRRestoreParallel (Parallel — both branches run simultaneously)
       │                   ├─ branch 1: PITRRestoreMain  (cics)   ─► poll until available ─► UpdateSecretsMain
       │                   └─ branch 2: PITRRestoreFe    (cicsfe) ─► poll until available ─► UpdateSecretsFe
       │                   └── both complete ──► UpdateAppStackPITR (IsPITRMode=true)
       │
       └─ [use_pitr=false] DiscoverSnapshots (latest cics + cicsfe snapshots)
                           UpdateAppStackSnapshot (SnapshotIdentifier + SnapshotIdentifierFe)
       │
       └──────────────► poll app stack until UPDATE_COMPLETE
                        StartCicsInstances (start all stopped EC2 tagged System=CICS)
                        DNSCutover (UPSERT hostname → DR ALB)
                        NotifyComplete (SNS) ─► Complete / FailoverFailed
```

> **StartCicsInstances** force-starts every EC2 instance tagged `System=CICS` in the DR
> region that is currently `stopped` (e.g. left off by the start/stop schedule), before DNS
> is flipped. It's idempotent — already-running instances are untouched. The tag key/value
> are hard-coded in the state machine (`System` / `CICS`); change them there if needed.

> **Network scale-up.** `UpdateNetworkStack` does **not** touch the `DeployPaidResources`
> master switch (left at its previous value, already `true`). Instead it flips four flags to
> `true`: `CreateJumpHost`, `CreateMultipleNat`, `CreateVpcEndpoint`, `S3GatewayVpcEndpoint`
> — bringing up the jump host, a NAT instance **per AZ** (`NatInstance2`/`NatInstance3`; the
> existing `NatInstance1` is unaffected since its condition doesn't depend on
> `CreateMultipleNat`), the VPC interface endpoints, and the S3 gateway endpoint. NAT stays
> instance-based (`NatInstanceOrGateway` untouched).
>
> The update submits via `TemplateURL`, which re-resolves `NatInstanceAMI` (SSM
> `al2023-latest`), so `NatInstance1` may be replaced on update. **This is acceptable by
> design** — the NAT instance is treated as ephemeral (purely a NAT-gateway replacement),
> so being recreated during failover is fine.

- **PITR path** (`use_pitr=true`) — primary, ~5 min RPO. Both DBs restored **outside** CloudFormation from the cross-region replicated automated backups (`DBReplicationStack`/`DBFEReplicationStack`), then `IsPITRMode=true` suppresses `DBStack`/`DBFEStack` so CFN doesn't create duplicate DBs.
- **Snapshot path** (`use_pitr=false`) — fallback, up to ~24h RPO. CFN restores both nested DBs in-stack from the supplied/discovered snapshot ids.

---

## Stacks the failover touches

1. **DR network stack** — scaled up via `CreateJumpHost` / `CreateMultipleNat` / `CreateVpcEndpoint` / `S3GatewayVpcEndpoint` = `true` (see the note under "Flow"). `DeployPaidResources` is left as-is.
2. **CICS app stack** (`cics.yaml`) — `DeployPaidResources=true` (+ `IsPITRMode=true` on the PITR path). All nested stacks follow the parent.
3. **Two RDS instances** (`cics` + `cicsfe`) — restored out of band; DR secrets updated.
4. **EC2 instances tagged `System=CICS`** — any that are `stopped` are force-started (idempotent).
5. **Route53** — hostname aliased to the DR ALB.

---

## Stack parameters (set once at deploy)

These are **CloudFormation parameters**, not per-invocation input — they're stable for a given DR deployment, so they live on the stack. Changing one is a stack update, not a new execution input.

| Parameter | Required | Meaning |
|---|---|---|
| `NetworkStackName` | yes | DR network stack — scaled up via the four `Create*` flags (jump host, NAT-per-AZ, VPC + S3 endpoints) |
| `NetworkTemplateUrl` | has default | S3 URL for `common/network.yaml` (avoids the 51,200-byte TemplateBody limit) |
| `AppStackName` | yes | The deployed `cics.yaml` stack in the DR region |
| `DbInstanceIdentifier` | yes | **Live-region** `cics` DB id — used to find the replicated automated backup (PITR) or the latest snapshot (snapshot path) |
| `DrDbSecretArn` | yes | `DRDBSecret` ARN — gets `DB_HOST` written (PITR) / `DB_ROOT_PASSWORD` read (snapshot) |
| `DbFeInstanceIdentifier` | yes | **Live-region** `cicsfe` DB id (same role for the front-end DB) |
| `DrDbFeSecretArn` | yes | `DRDBFESecret` ARN (same role for the front-end DB) |
| `SnsTopicArn` | optional (`''`) | Completion/notification topic; blank = skip notify |
| `Name` / `OrgName` / `LogRetentionDays` | have defaults | Resource naming and log retention |

> ⚠️ **`cics.yaml`'s `Outputs:` are intentionally commented out**, so the DB ids, DR secret ARNs, and stack names above are **not** readable from app-stack exports — set them explicitly at deploy. Get them from the DR-region console / CLI (see pre-flight).

---

## State machine input payload

Per-invocation input is now just the **PITR/snapshot identifiers, SSM paths, and DNS settings** — the deploy-time constants moved to stack parameters (above). Supply **every** key shown (use `""` for the ones a given path doesn't need — Step Functions errors on a missing `$.field` reference). `dns_alb_dns_name`/`dns_alb_hosted_zone_id` may be left blank **if** `dns_alb_name_contains` is set (the engine auto-discovers the DR ALB).

```json
{
  "use_pitr":                   true,

  "pitr_target_identifier":     "pchc-productiondr-uw1-cics-pitr",
  "pitr_subnet_group":          "pchc-prddr-uw1-cics-db-standby",
  "pitr_security_group_id":     "sg-0aaa111bbb222ccc3",
  "pitr_endpoint_ssm_path":     "/pchc/productiondr/cics/pitr-db-endpoint",
  "snapshot_identifier":        "",
  "db_master_password":         "",

  "pitr_fe_target_identifier":  "pchc-productiondr-uw1-cicsfe-pitr",
  "pitr_fe_subnet_group":       "pchc-prddr-uw1-cicsfe-db-standby",
  "pitr_fe_security_group_id":  "sg-0ddd444eee555fff6",
  "pitr_fe_endpoint_ssm_path":  "/pchc/productiondr/cicsfe/pitr-db-endpoint",
  "snapshot_identifier_fe":     "",
  "db_fe_master_password":      "",

  "dns_hosted_zone_id":         "Z0123456789ABCDEFGHIJ",
  "dns_record_name":            "cics.pchcdev.com",
  "dns_alb_dns_name":           "",
  "dns_alb_hosted_zone_id":     "",
  "dns_alb_name_contains":      "productiondr-uw1-cics"
}
```

### Field reference

| Key | Path | Meaning |
|---|---|---|
| `use_pitr` | both | `true` = PITR (default), `false` = snapshot fallback |
| `pitr_target_identifier` | PITR | Name for the new `cics` instance in DR — **must not already exist** |
| `pitr_subnet_group` | PITR | `DBStandbySubnetGroup` name (pre-deployed in DR) |
| `pitr_security_group_id` | PITR | SG to attach to the restored `cics` instance |
| `pitr_endpoint_ssm_path` | PITR | SSM param to also receive the `cics` endpoint (create-if-missing) |
| `snapshot_identifier` | snapshot | Explicit `cics` snapshot ARN; blank = auto-discover latest |
| `db_master_password` | snapshot | Blank = fetched from `DrDbSecretArn` |
| `pitr_fe_*` / `snapshot_identifier_fe` / `db_fe_master_password` | — | Same fields for the **`cicsfe`** DB |
| `dns_hosted_zone_id` | both | Client **public** hosted zone id (the zone for `ClientDomainName`) |
| `dns_record_name` | both | FQDN to repoint (e.g. `cics.pchcdev.com`); blank = skip DNS cutover |
| `dns_alb_dns_name` + `dns_alb_hosted_zone_id` | both | Explicit DR ALB alias target; blank = auto-discover via `dns_alb_name_contains` |
| `dns_alb_name_contains` | both | Substring matched against DR ALB name/DNS when the two above are blank |

> The **source DB ids, DR secret ARNs, stack names, and SNS topic** referenced by these steps come from the **stack parameters**, not this payload — see "Stack parameters" above.

> **These identifiers are reused at failback.** Record the `pitr_target_identifier`, `pitr_fe_target_identifier`, and the two `*_endpoint_ssm_path` values you use here — [CICS-DR-FAILBACK.md](CICS-DR-FAILBACK.md) takes the **same** ids to snapshot + delete the PITR instances and clear their SSM params. Note the DNS fields **flip** at failback: `dns_alb_name_contains` targets the **DR** ALB here but the **MAIN** ALB at failback, and failback adds a `dns_alb_region` (the main region) that failover does not use. If you leave `dns_record_name` blank here (skip the DR cutover), skip it at failback too.

### Snapshot-path payload

Set `"use_pitr": false`. The `pitr_*`, `pitr_fe_*`, and `*_endpoint_ssm_path` keys are unused (keep them as `""`). Optionally pin exact snapshots via `snapshot_identifier` / `snapshot_identifier_fe`; leave blank to auto-discover the latest available.

---

## Pre-flight checklist

```bash
DR_REGION=us-west-1

# 1. Both replicated automated backups exist and are replicating (PITR path)
for SRC in pchc-prd-ase1-cics pchc-prd-ase1-cicsfe; do
  aws rds describe-db-instance-automated-backups \
    --db-instance-identifier "$SRC" --region "$DR_REGION" \
    --query "DBInstanceAutomatedBackups[*].{Status:Status,ARN:DBInstanceAutomatedBackupsArn}"
done
# Expected: Status = "replicating" or "retained"

# 2. Standby subnet groups exist in DR (pre-deployed by cics.yaml IsDR resources)
aws rds describe-db-subnet-groups --region "$DR_REGION" \
  --query "DBSubnetGroups[?contains(DBSubnetGroupName,'standby')].DBSubnetGroupName"

# 3. DR secret ARNs (cics + cicsfe)
aws secretsmanager list-secrets --region "$DR_REGION" \
  --query "SecretList[?contains(Name,'cics')].{Name:Name,ARN:ARN}"

# 4. Client public hosted zone id
aws route53 list-hosted-zones-by-name --dns-name pchcdev.com \
  --query "HostedZones[0].Id" --output text

# 5. DR EC2 instances carry the System=CICS tag (StartCicsInstances matches on this — key is CASE-SENSITIVE)
aws ec2 describe-instances --region "$DR_REGION" \
  --filters "Name=tag:System,Values=CICS" \
  --query "Reservations[].Instances[].{Id:InstanceId,Name:Tags[?Key=='Name']|[0].Value,State:State.Name}"
```

---

## Deploy

```bash
aws cloudformation deploy \
  --template-file cics-dr-failover.yaml \
  --stack-name cics-dr-failover --region us-west-1 \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    NetworkStackName=pchc-testdr-uw1-cics-network \
    AppStackName=pchc-productiondr-uw1-cics \
    DbInstanceIdentifier=pchc-prd-ase1-cics \
    DrDbSecretArn=arn:aws:secretsmanager:us-west-1:<acct>:secret:pchc-prddr-uw1-cics-XXXXXX \
    DbFeInstanceIdentifier=pchc-prd-ase1-cicsfe \
    DrDbFeSecretArn=arn:aws:secretsmanager:us-west-1:<acct>:secret:pchc-prddr-uw1-cicsfe-XXXXXX \
    SnsTopicArn=arn:aws:sns:us-west-1:<acct>:pchc-productiondr-uw1-cics-sns
```

---

## Trigger

```bash
aws stepfunctions start-execution \
  --state-machine-arn "$(aws cloudformation describe-stacks \
      --stack-name cics-dr-failover --region us-west-1 \
      --query "Stacks[0].Outputs[?OutputKey=='StateMachineArn'].OutputValue" --output text)" \
  --region us-west-1 \
  --input file://payload.json
```

Or via Console: **Step Functions → `cics-dr-failover` → Start execution** with the JSON above.

Watch progress in the execution graph; worker logs are in `/aws/lambda/cics-dr-failover`, execution history in `/aws/states/cics-dr-failover`.

---

## RPO / RTO

| Path | RPO | When to use |
|---|---|---|
| PITR (`use_pitr=true`) | ~5 min | Default — cross-region automated backup replication active for both DBs |
| Snapshot (`use_pitr=false`) | up to ~24h | Fallback — replication not yet established, or pinning a specific snapshot |

---

## Known gap — app-side PITR wiring

`IsPITRMode=true` only **suppresses** `DBStack`/`DBFEStack`; CICS has no `PITRDBEndpoint` parameter. The PITR path therefore depends on the **CICS app servers reading `DB_HOST` from `DRDBSecret`/`DRDBFESecret`** (which `update_secrets` populates) at boot. Confirm that wiring on the app side before relying on PITR for a real cutover. The **snapshot path is unaffected** — CFN restores both DBs in-stack and the existing `ExistingSecretArn` plumbing applies.

---

## Out of scope (handle separately)

- **FSx OpenZFS** restore — `FileServerStack` is `IsMainRegion`-gated, so it won't deploy in DR. Restore the file system out of band per [README.md](README.md) §"DR FSx (OpenZFS) backup copy + restore", then re-mount the app servers from the published DNS.
