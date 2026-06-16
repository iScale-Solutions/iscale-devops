# PCHC Base Image Pipeline

EC2 Image Builder system that builds hardened **Amazon Linux 2023** base AMIs (and
application AMIs) in a source account, distributes them cross-account, and keeps
each account's AMI tags and SSM parameters rotated via a lifecycle Lambda.

All templates are deployed in the **Prod SG region (`ap-southeast-1`)** unless noted.

## Templates in this folder

| File | Purpose | Deploy as |
|------|---------|-----------|
| [`pchc-base-image.yaml`](pchc-base-image.yaml) | EC2 Image Builder recipe, infrastructure config, distribution config, and pipeline for the **AL2023 base image**. Shares/copies the AMI to the target accounts and secondary regions. | Regular stack (source account) |
| [`pchc-application-images.yaml`](pchc-application-images.yaml) | Image Builder pipeline for **application AMIs** built on top of the base image, with an AMI-retention lifecycle policy (`RetainAmiCount`). | Regular stack (source account) |
| [`pchc-image-builder-sns.yaml`](pchc-image-builder-sns.yaml) | SNS topic that Image Builder publishes build notifications to. Exports `${StackName}-TopicArn`. | Regular stack (source account) |
| [`pchc-ami-lifecycle-lambda.yaml`](pchc-ami-lifecycle-lambda.yaml) | Python Lambda + execution role, subscribed to the SNS topic. On each successful build it rotates `*_Latest`/`*_Previous` AMI tags, rotates `/image_Builder/*` SSM parameters, and deregisters superseded AMIs — in the source account and every target account. Exports `${StackName}-LambdaExecRoleArn`. | Regular stack (source account) |
| [`pchc-stackset-xaccount-roles.yaml`](pchc-stackset-xaccount-roles.yaml) | The two cross-account IAM roles that must exist **in each target account**: `Image_Builder_Lambda` (assumed by the lifecycle Lambda) and `EC2ImageBuilderDistributionCrossAccountRole` (required by Image Builder to distribute AMIs). | **StackSet** → target accounts |

## How it fits together

```
                       SOURCE ACCOUNT (ap-southeast-1)
  ┌──────────────────────────────────────────────────────────────┐
  │  pchc-base-image / pchc-application-images                    │
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
4. **`pchc-base-image.yaml`** then **`pchc-application-images.yaml`** — the pipelines.
   Set `SNSStackName`, `NetworkStackName`, and `ShareAccountList`.

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

- AMI `Name` tags: `PCHC_<PlatformTag>_Latest` / `_Previous`
  (ARM AL2023 uses `PCHC_AL2023_arm64_Latest` / `_Previous`).
- SSM parameters: `/image_Builder/<PlatformTag>/base/latest` and `/previous`
  (ARM: `/image_Builder/<PlatformTag>/arm64/base/latest`).
- `<PlatformTag>` is derived from the OS (e.g. `AL2023`, `RHEL8`, `Ubuntu22`, `Windows2022`).
