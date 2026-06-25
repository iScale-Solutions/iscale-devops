# PCHC CICS Stack

CloudFormation templates for the **PCHC CICS** (Clearing House) application environment. This folder holds only the templates specific to the CICS workload for the `pchc` organization — networking, SNS, and shared/common nested stacks live elsewhere.

This README exists to give Claude (and future readers) enough context to safely edit these templates without spelunking through 100k+ lines of YAML.

---

## Files in this folder

| File | Purpose |
|------|---------|
| [cics.yaml](cics.yaml) | **Main stack.** All CICS application infrastructure — EC2 fleet, RDS, ELB, SFTP, S3 transfer buckets, IAM, Active Directory, CloudWatch alarms, backups, dashboard. |
| [cics-dr-vpc-peering.yaml](cics-dr-vpc-peering.yaml) | Cross-region VPC peering between the main CICS region and the DR region. Deployed twice — once as **Requester** (main) and once as **Accepter** (DR). |
| [cics-vpn.yaml](cics-vpn.yaml) | AWS Client VPN endpoint peered into the CICS VPC. |
| [cics-lambda-cron.yaml](cics-lambda-cron.yaml) | Standalone Lambda (Python 3.9) on a CRON schedule that queries the CICS RDS instance. Has its own VPC SG and S3 bucket. |
| [cics-dr-failover.yaml](cics-dr-failover.yaml) | **CICS-dedicated DR failover engine** (Step Functions + Lambda). Forked from `dr/dr-failover-v2.yaml`: dual-DB (cics + cicsfe) PITR/snapshot restore + Route53 cutover, single app stack, no EFS/AMI/Redshift/ECS machinery. |
| [CICS-DR-FAILOVER.md](CICS-DR-FAILOVER.md) | Runbook for `cics-dr-failover.yaml` — flow, **state machine input payload**, pre-flight, and trigger steps. |

---

## cics.yaml — what lives inside

The main template provisions an HA Windows-on-AWS CICS environment. Resource groups (in source order):

1. **Load balancer** — `ELBStack` (nested, `common/loadbalancer.yaml`).
2. **SFTP** — `FTPStack` (nested, `common/sftp.yaml`) plus 8 hard-coded `AllowSFTPn` ingress rules for PCHC office / VPN / Zscaler CIDRs.
3. **Transfer S3 buckets** — `Xfer1`–`Xfer4` (Test-env only, via `Condition: IsTest`).
4. **EC2 server fleets** — each fleet follows the same pattern: `*EC2Role` → `*InstanceProfile` → `*SecurityGroup` → `Allow*` ingress rules → one or two `*Instance` resources → `HighCPU*Alarm`. Fleets:
   - **CICSAPPSVR1/2** — SIOS HA pair (`c5d.9xlarge`, `SIOSInstanceAMI`).
   - **GLBLSCPSVR1/2** — Global script servers.
   - **IWEBAPPSVR1/2** — IWeb app servers (behind ELB).
   - **CICSWITSVR** — Single witness instance for SIOS quorum.
   - **CICSFEAPPSVR1/2** — Front-end app servers (uses `FEInstanceAMI`).
   - **IWEBFEAPPSVR1/2** — IWeb front-end (has extra `EBS1` + `EBS1Mountpoint` data volumes).
   - **PCHJUMPSVR** + **PCHJUMPSVROperator** — Bastion / jump hosts with EIPs and external ingress rules from Aperta, PCHC office, and "Noel" CIDRs.
   - **BKUPSVR** — Backup server.
5. **Active Directory** — `ActiveDirectory` (AWS Managed AD) + `EC2JoinADSSMDocument` (joins instances on launch via `SsmAssociations`).
6. **RDS** — `DBStack` (nested, `common/database.yaml`) is the main CICS DB. `SQLServerBackupRestoreIAMRole` + `SQLServerOptionGroup` enable native SQL Server backup/restore against the archive bucket. DR-only resources (`Condition: IsDR`): `DRDBSecret` (placeholder Secrets Manager secret synced from the live region by the secrets-sync Lambda), `DBStandbySubnetGroup` (pre-provisioned for PITR restore), and `DBReplicationStack` (cross-region backup replication, only when `EnableCrossRegionBackupReplication=true`). The FE DB has the parallel `DBFEStack` / `DRDBFESecret` / `DBFEStandbySubnetGroup` / `DBFEReplicationStack` set (see §9).
7. **Routing into RDS** — `AllowCICSAPPSVRIntoDB`, `AllowGLBLSCPSVRIntoDB`, `AllowBKUPSVRIntoDB` and DB2/DR variants.
8. **ELB wiring** — `CICSListenerRule`, `CICSTargetGroup`, `SlowTargetResponseTimeCloudWatchAlarm`, `TargetGroupHealthyHostCountAlarm`.
9. **FE DB stack** — `DBFEStack` + `AllowCICSFEAPPSVRIntoDB`.
10. **Archive bucket + Bank IAM** — `ArchiveS3Bucket`, `BankGroup`, `BankPolicy`.
11. **DNS / Backup / FileServer / Dashboard** — `ALBDNSRecord`, `BackupStack`, `FileServerStack`, `Dashboard` (CloudWatch dashboard pulling every instance ID).

`Outputs:` exports `DBPort`, `DBSecurityGroup`, `DBSecurityGroup2` (main-region only) and `CICSAPPSVRSecurityGroup` — these are consumed by sibling stacks (e.g. peering, lambda) via `!ImportValue`.

---

## Conventions this template relies on

- **Naming pattern**: every named resource uses `!Join ['-', [OrgName, EnvShort, RegionShort, Name, <resource-tag>]]`. `EnvShort` / `RegionShort` come from the included `mappings.yaml`. Match this pattern when adding new resources or AWS will reject duplicates on re-deploy.
- **Shared includes** (do not inline — they're loaded via `AWS::Include` transform):
  - `s3://iscale-dev-cloudformation/include/mappings.yaml` — `EnvShort`, `RegionShort`, AMI lookup tables.
  - `s3://iscale-dev-cloudformation/include/conditions.yaml` — provides `IsProd`, `IsTest`, etc.
- **Nested stack templates** live at `https://iscale-dev-cloudformation.s3-us-west-2.amazonaws.com/common/*.yaml` (loadbalancer, sftp, vpc-peering, vpn, rds, backup, fileserver).
- **DR awareness**: DR is driven by the **`EnvName`** parameter, not a region parameter. The DR variants (`ProductionDR`, `StagingDR`, `DevelopmentDR`, `TestDR`) set the `IsDR` condition; `IsMainRegion` is its inverse (`!Not [IsDR]`), and `IsProdAndMainRegion` combines `IsProd` + `IsMainRegion`. Many resources (second-AZ instances, DB ingress, FileServer, Dashboard) are gated on these — preserve the gating when editing. Cold-standby suppression is a separate axis: `DeployPaidResources=false` drops all paid resources (`IsDeployPaidResources`), and `IsPITRMode=true` suppresses `DBStack` when the DB was restored externally (`IsDeployPaidResourcesAndNotPITR`).
- **Cross-stack imports** assume `NetworkStackName` (default `pchc-dev-ase1-network`) and `SNSStackName` are deployed first.

---

## When editing — gotchas

- **`Xfer1–4` S3 buckets** are gated on `Condition: IsTest` — they only exist in Test env. The IAM policy on `CICSAPPSVREC2Role` still references their ARNs unconditionally; that's intentional (IAM allows wildcarding non-existent resources).
- **AMIs are hard-coded** to `ami-0d694fc7ea154072a` / `ami-0526b9747c2c87a0b` / `ami-06b2f14c1d8417d36` (Windows 2019 + SIOS Marketplace). The `DBStack` comment at line 2071 notes: *"some settings were manually updated in Console since we cannot update the whole template yet (outdated AMIs of windows EC2, need to be replaced for this stack to update)"* — be cautious about full-stack updates.
- **SFTP allow-list CIDRs** (`AllowSFTP1`–`8`) are office/carrier IPs maintained by hand. If adding/removing, keep the `Description` field meaningful — that's the only audit trail.
- **`Name` parameter** is capped at 9 chars (`MaxLength: 9`) because it's part of every resource name and AWS has resource-name length limits downstream.
- **`PCHJUMPSVR` ingress rules** reference Aperta / "Noel" by name — these are humans/vendors, not standard CIDR sets. Ask before pruning.

---

## DR DNS failover — design reference (for the future `dr-failover` Step Functions machine)

> Status: **design, not yet implemented.** This documents the agreed approach ("Option B") for how the dedicated CICS `dr-failover` state machine should cut DNS over to the DR region. Read this before changing `ALBDNSRecord` or building the state machine.

### Context — why this needs care

`ALBDNSRecord` ([cics.yaml](cics.yaml), Route53 group) is a **simple alias A record**:

- **Name** (the record key): `<LoadBalancerHostName>.<ClientDomainName>` — this lives in the **global** public hosted zone, so it is **identical** whether the stack is deployed in the main region or DR.
- **Value**: an alias to `ELBStack.Outputs.DNSName` / `.CanonicalHostedZoneID` — this resolves **per-region** to the **local** ALB.

Because Route53 is global and the record has **no `SetIdentifier` / `Failover` policy**, if the DR stack ever creates this record it issues an **UPSERT** against the *same* name+type and **overwrites** the main region's record, repointing the hostname at the DR ALB. Two stacks would then fight over one record, and **deleting the DR stack would delete the shared record entirely** (DNS outage for main too).

### Why automatic Route53 health-check failover does NOT fit

CICS DR is **cold / pilot-light**: `DeployPaidResources=false` suppresses `ELBStack`, the app servers, and the DB in the standby region. A Route53 failover SECONDARY record needs a **live** target to alias to — but in cold standby **there is no DR ALB to point at**. Health-check failover only works for a *warm* standby (DR ELB + healthy targets always running), which defeats the cost savings `DeployPaidResources` exists to provide. So health-check failover is **out** for this workload.

### Option B — single owner + explicit repoint (the chosen design)

1. **Gate `ALBDNSRecord` to the main region only.** The CloudFormation record's condition should require main region in addition to the existing `IsDeployPaidResourcesAndNotPITR` (e.g. `!And [IsMainRegion, IsDeployPaidResourcesAndNotPITR]`). The **DR stack must never create, own, overwrite, or delete** this record. This removes the UPSERT collision and the delete-cascade risk.
2. **The `dr-failover` state machine performs the cutover explicitly.** After it activates the DR stack (`DeployPaidResources=true`, so the DR `ELBStack` now exists), it makes a single `route53:ChangeResourceRecordSets` UPSERT pointing the hostname at the **DR** ALB. DNS flips to DR exactly when DR comes online.
3. **Failback**: when the main region is restored, the main stack re-asserts its own record (or the state machine repoints back to the main ALB). At all times there is exactly **one owner** of the record — no CloudFormation tug-of-war.

The DNS cutover lives in the **state machine definition**, not in `cics.yaml`. The CloudFormation half of this design is only the main-region gating in step 1.

### Cutover step — `ChangeResourceRecordSets` change batch

The state machine should fetch the DR ALB's `DNSName` and `CanonicalHostedZoneID` (from the DR `ELBStack` outputs or `elbv2:DescribeLoadBalancers`) and submit:

```json
{
  "Comment": "CICS DR failover cutover — point hostname at DR ALB",
  "Changes": [
    {
      "Action": "UPSERT",
      "ResourceRecordSet": {
        "Name": "<LoadBalancerHostName>.<ClientDomainName>.",
        "Type": "A",
        "AliasTarget": {
          "HostedZoneId": "<DR ALB CanonicalHostedZoneID>",
          "DNSName": "<DR ALB DNSName>",
          "EvaluateTargetHealth": false
        }
      }
    }
  ]
}
```

- The `HostedZoneId` passed to the `ChangeResourceRecordSets` **call** is the **client's public hosted zone** (`ClientDomainName`).
- The `AliasTarget.HostedZoneId` **inside** the batch is the **ALB's own canonical zone** (region-specific), not the client zone — do not confuse the two.
- Mirror the same batch with the **main** ALB's values for failback.

### Guardrails

- Do **not** run a main-stack update while failed over to DR — it would re-assert the main ALB and silently undo the cutover.
- The `dr-failover` machine needs `route53:ChangeResourceRecordSets` on the client hosted zone and `elasticloadbalancing:DescribeLoadBalancers` (or read access to the DR `ELBStack` outputs).

---

## DR FSx (OpenZFS) backup copy + restore — design reference (for the future `dr-failover` Step Functions machine)

> Status: **design, not yet implemented.** This documents the agreed approach ("Option B") for replicating the CICS file system to the DR region and recreating it there on activation. Read this before changing `FileServerStack` / `common/nfs-windows-fsx.yaml` or building the state machine.

### What the file system actually is

`FileServerStack` ([cics.yaml](cics.yaml)) → `common/nfs-windows-fsx.yaml`. Despite the file name, the resource (`WindowsFSX`) is **FSx for OpenZFS**, **NFS**, with **no Active Directory** — so none of the AD-join / directory-override concerns that apply to FSx for Windows apply here. Current config:

- `FileSystemType: OPENZFS`, `DeploymentType: SINGLE_AZ_1`, `ThroughputCapacity: 1024`, `StorageCapacity: 100`, `StorageType: SSD`, in `${NetworkStackName}-PrivateSubnetId1`.
- **Native** automatic backups are on: `AutomaticBackupRetentionDays: 30`, `DailyAutomaticBackupStartTime: 01:00`.
- Clients reach it over NFS on ports 111, 2049, 20001–20003 from `IWEBAPPSVRSecurityGroup` (= `CICSFEAPPSVRSecurityGroup`).
- The nested stack **outputs only the file-system id** (`WindowsFSX` = `!Ref`). It does **not** output the DNS name or the ARN — relevant below.

### The core constraint

FSx **native** automatic backups (the daily ones configured above) **stay in the source region** and **cannot be auto-copied cross-region**. AWS Backup can only copy recovery points **it** created, so it cannot reach into FSx native automatic backups either. Two ways out:

- **Option A** — back the file system up *via AWS Backup* (`common/backup.yaml` already supports cross-region copy through `EnableCrossRegionBackup` + `CrossRegionBackupVaultArn` + per-rule `CopyActions`), and disable FSx native backups. Zero custom code; restore via `start-restore-job`.
- **Option B (chosen here)** — keep FSx native automatic backups and run a small **EventBridge + Lambda** copier that calls `fsx copy-backup` into the DR region; recreate the file system from that copy on activation.

### Option B — cross-region copy of native backups

1. **EventBridge rule** — daily, just after the `01:00` backup window (or react to the FSx backup-completed event).
2. **Lambda** — find the newest automatic backup for the source file system and copy it to DR:
   ```python
   fsx_dr = boto3.client("fsx", region_name="<DR-region>")
   fsx_dr.copy_backup(
       SourceBackupId=latest_backup_id,
       SourceRegion="<main-region>",
       CopyTags=True,
       # KmsKeyId="<DR-region CMK>",   # only if encrypting copies with a CMK
   )
   ```
3. Add lifecycle cleanup of old DR copies — `copy-backup` copies do **not** inherit any auto-expiry.

### Recreating the file system in DR on activation

FSx restore is **API-only** — `AWS::FSx::FileSystem` has **no `BackupId` property**, so this lives in the state machine, not in `cics.yaml`. OpenZFS uses `OpenZFSConfiguration` (no AD):

```python
fsx_dr = boto3.client("fsx", region_name="<DR-region>")

# pick the latest copied backup, don't hard-code an id
backups = fsx_dr.describe_backups(
    Filters=[{"Name": "file-system-id", "Values": ["<source fs id>"]}]
)["Backups"]
latest = max(backups, key=lambda b: b["CreationTime"])["BackupId"]

resp = fsx_dr.create_file_system_from_backup(
    BackupId=latest,
    SubnetIds=["<DR-PrivateSubnetId1>"],         # SINGLE_AZ_1 = 1 subnet
    SecurityGroupIds=["<DR FSx SG>"],
    OpenZFSConfiguration={
        "DeploymentType": "SINGLE_AZ_1",          # must match the backup
        "ThroughputCapacity": 1024,
    },
)
new_fs_id  = resp["FileSystem"]["FileSystemId"]
new_fs_dns = resp["FileSystem"]["DNSName"]        # NEW name — must repoint clients
```

The backup is a **full image** — root volume, all child volumes, NFS export settings, record size, compression, snapshots — so the DR file system comes back with the same volume layout and export paths; none of that is re-declared.

### Gotchas

- **New file system = new DNS name + new volume ids.** Restore never reuses the old name, so the old NFS mount target is dead in DR. The state machine must publish `new_fs_dns` (and the export path) to **SSM / Secrets Manager** — the same pattern the machine uses for `PITRDBEndpoint` — and the app servers re-mount from that on boot.
- **The nested stack doesn't output DNS or ARN.** To wire repoint cleanly, add a `DNSName` output to `nfs-windows-fsx.yaml` (and an ARN output if you ever switch to Option A); otherwise the machine must `describe-file-systems` to resolve them.
- **`DeploymentType` / throughput must match the backup** — OpenZFS rejects mismatched restores.
- **Pick the newest copied backup at activation**, filtered by source file-system id or a tag the copy Lambda stamps.

### Stack wiring for cold standby

- **Gate `FileServerStack` off in DR.** It currently has **no condition**, so a DR deploy would stand up an *empty* OpenZFS file system that collides with the restored one. CloudFormation's only DR job is to **not** create FSx; the `dr-failover` machine owns the restored DR file system.
- Independent reason it must be gated: `nfs-windows-fsx.yaml`'s `EnvName` only allows `Production/Staging/Development/Test` — a DR env value (`ProductionDR`, etc.) would **fail parameter validation** anyway. (Either gate the stack off in DR, or add the DR `EnvName` values to the nested template before it can ever deploy there.)

### Activation sequence

1. `describe_backups` in DR → newest copied backup.
2. `create_file_system_from_backup` with DR subnet / SG / matching `OpenZFSConfiguration`.
3. Poll `describe_file_systems` until `AVAILABLE`.
4. Write new DNS name + export path to SSM / Secrets Manager.
5. `DeployPaidResources=true` → clients re-mount NFS from the published DNS.
6. (Failback) delete the DR file system after reconciling data back to main.

### IAM the machine needs

`fsx:DescribeBackups`, `fsx:CopyBackup`, `fsx:CreateFileSystemFromBackup`, `fsx:DescribeFileSystems`, `fsx:DeleteFileSystem` (failback), plus SSM/Secrets Manager write for the new DNS name, and KMS use on the DR CMK if copies are CMK-encrypted.

---

## Stack name convention

Deployed CloudFormation stacks for this folder follow `pchc-<env>-<region>-cics[-<suffix>]`, e.g.:

- `pchc-prd-ase1-cics` — production main (Singapore)
- `pchc-test-uw1-cics-dr` — test DR (Oregon)
- `pchc-prd-ase1-cics-vpn`, `pchc-prd-ase1-cics-dr-vpc-peering`, `pchc-prd-ase1-cics-lambda`

`cics-dr-vpc-peering.yaml`'s `CicsStackNameDR` parameter defaults to `pchc-test-uw1-cics-dr` — update when promoting to prod.
