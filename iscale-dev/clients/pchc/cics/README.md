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
6. **RDS** — `DBStack`, `DBStack2` (nested), `DBSubnetGroup2` (DR), and `DIsasterRecoveryDBSecurityGroup` (typo preserved — do **not** rename, it would replace the SG). `SQLServerOptionGroup` + `SQLServerOptionGroup2` for native backup/restore.
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
- **DR awareness**: `DisasterRecoveryRegion` parameter drives `IsDisasterRecoveryRegion` / `IsMainRegion` / `IsProdAndMainRegion`. Many resources (DB exports, subnet picks) are gated on these — preserve the gating when editing.
- **Cross-stack imports** assume `NetworkStackName` (default `pchc-dev-ase1-network`) and `SNSStackName` are deployed first.

---

## When editing — gotchas

- **`DIsasterRecoveryDBSecurityGroup`** is misspelled in the source. Renaming it triggers a replace; leave it alone unless you intend that.
- **`Xfer1–4` S3 buckets** are gated on `Condition: IsTest` — they only exist in Test env. The IAM policy on `CICSAPPSVREC2Role` still references their ARNs unconditionally; that's intentional (IAM allows wildcarding non-existent resources).
- **AMIs are hard-coded** to `ami-0d694fc7ea154072a` / `ami-0526b9747c2c87a0b` / `ami-06b2f14c1d8417d36` (Windows 2019 + SIOS Marketplace). The `DBStack` comment at line 2071 notes: *"some settings were manually updated in Console since we cannot update the whole template yet (outdated AMIs of windows EC2, need to be replaced for this stack to update)"* — be cautious about full-stack updates.
- **SFTP allow-list CIDRs** (`AllowSFTP1`–`8`) are office/carrier IPs maintained by hand. If adding/removing, keep the `Description` field meaningful — that's the only audit trail.
- **`Name` parameter** is capped at 9 chars (`MaxLength: 9`) because it's part of every resource name and AWS has resource-name length limits downstream.
- **`PCHJUMPSVR` ingress rules** reference Aperta / "Noel" by name — these are humans/vendors, not standard CIDR sets. Ask before pruning.

---

## Stack name convention

Deployed CloudFormation stacks for this folder follow `pchc-<env>-<region>-cics[-<suffix>]`, e.g.:

- `pchc-prd-ase1-cics` — production main (Singapore)
- `pchc-test-uw1-cics-dr` — test DR (Oregon)
- `pchc-prd-ase1-cics-vpn`, `pchc-prd-ase1-cics-dr-vpc-peering`, `pchc-prd-ase1-cics-lambda`

`cics-dr-vpc-peering.yaml`'s `CicsStackNameDR` parameter defaults to `pchc-test-uw1-cics-dr` — update when promoting to prod.
