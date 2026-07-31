# PCHC Base Image Pipeline

EC2 Image Builder system that builds hardened **Amazon Linux 2023** and
**Windows Server 2022** base AMIs (and application AMIs) in a source account,
distributes them cross-account, and keeps each account's AMI tags and SSM
parameters rotated via a lifecycle Lambda.

All templates are deployed in the **Prod SG region (`ap-southeast-1`)** unless noted.

## Templates in this folder

| File | Purpose | Deploy as |
|------|---------|-----------|
| [`pchc-base-image-linux.yaml`](pchc-base-image-linux.yaml) | EC2 Image Builder recipe, infrastructure config, distribution config, and pipeline for the **AL2023 base image**. Shares/copies the AMI to the target accounts and secondary regions. | Regular stack (source account) |
| [`pchc-base-image-windows.yaml`](pchc-base-image-windows.yaml) | Same, for the **Windows Server 2022 base image**. Uses the AWS-managed Windows components (`aws-cli-version-2-windows`, `amazon-cloudwatch-agent-windows`, `update-windows`, `chocolatey`) rather than the inline components the Linux recipe defines. | Regular stack (source account) |
| [`pchc-application-images.yaml`](pchc-application-images.yaml) | Image Builder pipeline for **application AMIs** built on top of the base image, with an AMI-retention lifecycle policy (`RetainAmiCount`). | Regular stack (source account) |
| [`pchc-image-builder-sns.yaml`](pchc-image-builder-sns.yaml) | SNS topic that Image Builder publishes build notifications to. Exports `${StackName}-TopicArn`. | Regular stack (source account) |
| [`pchc-ami-lifecycle-lambda.yaml`](pchc-ami-lifecycle-lambda.yaml) | Python Lambda + execution role, subscribed to the SNS topic. On each successful build it rotates `*_Latest`/`*_Previous` AMI tags, rotates `/image_Builder/*` SSM parameters, and deregisters superseded AMIs — in the source account and every target account. Exports `${StackName}-LambdaExecRoleArn`. | Regular stack (source account) |
| [`pchc-stackset-xaccount-roles.yaml`](pchc-stackset-xaccount-roles.yaml) | The two cross-account IAM roles that must exist **in each target account**: `Image_Builder_Lambda` (assumed by the lifecycle Lambda) and `EC2ImageBuilderDistributionCrossAccountRole` (required by Image Builder to distribute AMIs). | **StackSet** → target accounts |

## How it fits together

```
                       SOURCE ACCOUNT (ap-southeast-1)
  ┌──────────────────────────────────────────────────────────────┐
  │  pchc-base-image-linux / -windows / -application-images      │
  │      │ builds AMI, distributes via TargetAccountIds           │
  │      │ publishes "AVAILABLE" ─────────────► SNS topic         │
  │                                              (pchc-image-      │
  │                                               builder-sns)    │
  │                                                  │            │
  │  pchc-ami-lifecycle-lambda  ◄────────────────────┘ (subscribe)│
  │      │ rotates tags + SSM, deregisters old AMIs               │
  └──────┼───────────────────────────────────────────────────────┘
         │ sts:AssumeRole  Image_Builder_Lambda
         ▼
  TARGET ACCOUNTS  470455329885, 050821737631  (StackSet)
  ┌──────────────────────────────────────────────────────────────┐
  │  Image_Builder_Lambda                 (trusts Lambda exec role)│
  │  EC2ImageBuilderDistributionCrossAccountRole (trusts ImageBldr)│
  │  AMI copy + /image_Builder/* SSM params + *_Latest/*_Previous  │
  └──────────────────────────────────────────────────────────────┘
```

- The **target account list** (`470455329885,050821737631`) is the
  `ShareAccountList` in the pipeline templates and the StackSet's deployment targets.
- Each target account owns its **own copy** of every AMI (distinct AMI ID), which is
  why the lifecycle Lambda deregisters per-account.

## Deployment order

1. **`pchc-image-builder-sns.yaml`** — creates the SNS topic. Note the stack name; it
   becomes `SNSStackName` for the other stacks (default `pchc-prd-ase1-image-builder-sns`).
2. **`pchc-ami-lifecycle-lambda.yaml`** — subscribes to the SNS topic and exports
   `LambdaExecRoleArn`. That ARN is the principal the target-account `Image_Builder_Lambda`
   role must trust.
3. **`pchc-stackset-xaccount-roles.yaml`** (StackSet) — deploy to the target accounts.
   Pass `LambdaExecRoleArn` (from step 2) and `SourceAccountId` (the pipeline account).
4. **`pchc-base-image-linux.yaml`** / **`pchc-base-image-windows.yaml`**, then
   **`pchc-application-images.yaml`** — the pipelines. Set `SNSStackName`,
   `NetworkStackName`, and `ShareAccountList`. Each base image is its own stack;
   deploy only the ones you need.

## StackSet notes (`pchc-stackset-xaccount-roles.yaml`)

This template is **self-managed** StackSet content; the StackSet plumbing roles are
bootstrapped out-of-band and are *not* created here:

- **Administration role** lives only in the admin account (`470455329885`) and is
  selected at deploy time (`--administration-role-arn`).
- **`AWSCloudFormationStackSetExecutionRole`** is pre-deployed in every target account,
  trusting `arn:aws:iam::470455329885:root`.
- Every StackSet operation needs **`CAPABILITY_NAMED_IAM`** (all roles use fixed names).
- Because the role names are fixed, a pre-existing copy in a target account causes
  `EntityAlreadyExists` / "policy already exists" — clean up orphans from failed runs
  before retrying.

## Tag / SSM conventions produced by the lifecycle Lambda

The same lifecycle Lambda serves **all** pipeline templates
(`pchc-base-image-linux.yaml`, `pchc-base-image-windows.yaml` and
`pchc-application-images.yaml`) off the one SNS topic.
To keep each pipeline isolated, it derives a **per-pipeline key** from the pipeline
name in the SNS event (`sourcePipelineName`, e.g. `pchc-base-mis`) by stripping the
`<org>-base-` prefix → `mis`. Without this, every AL2023-based app pipeline would
collide on the same tag / SSM path and deregister each other's AMIs.

- **App pipelines** (`pchc-base-<app>`):
  - AMI `Name` tags: `PCHC_<app>_Latest` / `_Previous` (e.g. `PCHC_mis_Latest`).
  - SSM parameters: `/image_Builder/<app>/base/latest` and `/previous`
    (e.g. `/image_Builder/mis/base/latest`).
- **Base OS images** (`pchc-base-amazon-linux2023`, `pchc-base-windows2022`) —
  special-cased to keep their OS/arch key so app recipes can consume them as their
  `ParentImage`. The key comes from the OS itself, not the pipeline name, so it is
  proper-cased (`AL2023`, `Windows2022`) rather than the lowercase pipeline slug:
  - AMI `Name` tags: `PCHC_AL2023_Latest` / `PCHC_Windows2022_Latest` (and `_Previous`).
    AL2023 ARM uses `PCHC_AL2023_arm64_Latest` / `_Previous`.
  - SSM parameters: `/image_Builder/AL2023/base/latest` and
    `/image_Builder/Windows2022/base/latest` (and `/previous`).
    ARM: `/image_Builder/AL2023/arm64/base/latest`. ARM detection is AL2023-only,
    so Windows paths are always flat.

  The special-case list is the `pipeline_key in (...)` tuple in
  [`pchc-ami-lifecycle-lambda.yaml`](pchc-ami-lifecycle-lambda.yaml). **A new base OS
  pipeline must be added there before its first build** — otherwise it falls through
  to the app-pipeline branch and takes the lowercase slug (`windows2022`), and
  switching afterwards strands the old SSM parameter and leaves one AMI never
  deregistered.

| Pipeline | SSM parameter | AMI `Name` tag |
|----------|---------------|----------------|
| `pchc-base-amazon-linux2023` | `/image_Builder/AL2023/base/latest` | `PCHC_AL2023_Latest` |
| `pchc-base-windows2022` | `/image_Builder/Windows2022/base/latest` | `PCHC_Windows2022_Latest` |
| `pchc-base-mis` | `/image_Builder/mis/base/latest` | `PCHC_mis_Latest` |
| `pchc-base-maws` | `/image_Builder/maws/base/latest` | `PCHC_maws_Latest` |
| `pchc-base-dd` | `/image_Builder/dd/base/latest` | `PCHC_dd_Latest` |

(…and so on for every recipe in `pchc-application-images.yaml` — no per-app config needed.)
