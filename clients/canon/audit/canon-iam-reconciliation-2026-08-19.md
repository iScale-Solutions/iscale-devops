# Canon IAM Reconciliation - 2026-08-19

Source audit:

- GitHub Actions run: `32202996577`
- Artifact: `canon-aws-audit-32202996577`
- AWS account: `780347486043`
- Scope: IAM only, CloudFormation inventory disabled
- Local artifact path used for this report: `/tmp/canon-audit-32202996577/canon-aws-audit-32202996577`

This report compares live IAM inventory against `clients/canon/canon-iam.yaml`. It is a review checkpoint only; no CloudFormation deployment should be run from `canon-iam.yaml` until these differences are intentionally reconciled.

## Summary

Live IAM inventory:

- 9 IAM users
- 14 IAM groups
- 149 IAM roles
- 6 customer-managed IAM policies

`canon-iam.yaml` currently defines:

- `CITechDevelopers` group
- Canon staff users: `JM_Capulong@canon.com.ph`, `Michael_Palmiano@canon.com.ph`, `Roy_San_Luis@canon.com.ph`
- CI Tech users: `edward_bernardo@canon.com.ph`, `lawrence_lomotan@canon.com.ph`, `elizza_razalan@canon.com.ph`, `Edsel_Sabulao@canon.com.ph`
- ThinkBit user/group: `developer@thinkbitsolutions.com`, `canon-prd-ThinkBit-group`
- Terraform user/group/access key: `canon-prd-terraform-user`, `canon-prd-terraform-group`

## Matches

These repo-defined IAM objects exist live and broadly match the template:

- `CITechDevelopers`
- `canon-prd-terraform-group`
- `canon-prd-terraform-user`
- `developer@thinkbitsolutions.com`
- `edward_bernardo@canon.com.ph`
- `JM_Capulong@canon.com.ph`
- `Michael_Palmiano@canon.com.ph`
- `Roy_San_Luis@canon.com.ph`

The live `CITechDevelopers` attached policies match the repo:

- `arn:aws:iam::aws:policy/ReadOnlyAccess`
- `arn:aws:iam::aws:policy/IAMUserChangePassword`

The live `CITechDevelopers` inline `SSMAccess` policy matches the repo intent, with account/region substitutions resolved in AWS.

The live `canon-prd-terraform-group` inline `TerraformBetaAccess` policy matches the repo intent.

## Repo Users Missing In Live AWS

These users are defined in `canon-iam.yaml` but were not present in the live audit:

- `lawrence_lomotan@canon.com.ph`
- `elizza_razalan@canon.com.ph`
- `Edsel_Sabulao@canon.com.ph`

Risk:

- A future CloudFormation update may attempt to recreate or reconcile these users depending on current stack drift state.
- Before deploying `canon-iam.yaml`, decide whether these users should be restored, removed from the template, or imported/repaired in the existing stack.

## Live Users Not In `canon-iam.yaml`

These users exist live but are not defined in `canon-iam.yaml`:

- `beta.canonph.app`
- `cloudwatch-user`
- `delightful-staging-user`

Observed live access:

- `beta.canonph.app`
  - Attached policy: `arn:aws:iam::780347486043:policy/iam_app_beanstalk_policy`
  - Inline policies: `CloudFormation`, `Custom`
  - No console login profile
- `cloudwatch-user`
  - Group: `CloudWatchGroup`
  - No console login profile
- `delightful-staging-user`
  - Attached policy: `arn:aws:iam::780347486043:policy/DelightfulAppStagingGitlabAccess`
  - No console login profile

Recommendation:

- Do not add these blindly to `canon-iam.yaml`.
- Decide whether they belong in separate app-specific templates, likely `delightfulapp.yaml` or a new legacy/app IAM template.
- `beta.canonph.app` looks like legacy Elastic Beanstalk app access.
- `delightful-staging-user` looks like deployment access for CMP Delightful staging.
- `cloudwatch-user` looks like a monitoring/reporting service user.

## ThinkBit Manual Drift

`canon-prd-ThinkBit-group` has live permissions beyond the repo template.

Extra attached managed policy live but not in repo:

- `arn:aws:iam::aws:policy/AmazonSESFullAccess`

Extra live inline policies not in repo:

- `AutoScalingAccess`
- `cmp-delightful-app-s3-access`
- `Lambda`
- `SecretsAccess`
- `SES`
- `SSMAccessOnEC2`

The repo already has these live inline policies:

- `CanonDevAccess`
- `SSM`

Notable live difference inside existing `SSM` policy:

- Live `SSM` has an additional `Events` statement allowing:
  - `events:PutRule`
  - `events:Put*`
  - `events:Get*`
  - `events:List`

`developer@thinkbitsolutions.com` also has direct user-level permissions beyond the repo template:

- Attached policy: `arn:aws:iam::780347486043:policy/iam_app_beanstalk_policy`
- Attached policy: `arn:aws:iam::aws:policy/AWSCertificateManagerFullAccess`
- Attached policy: `arn:aws:iam::aws:policy/AmazonEventBridgeReadOnlyAccess`
- Inline policy: `ImportCreateEC2KeyPair`

Risk:

- Deploying the repo template as-is may remove these manually added ThinkBit permissions if the CloudFormation stack owns the group/user policy attachments.

Recommendation:

- Preserve ThinkBit live permissions in source control before running any IAM change set.
- Prefer codifying group-level grants over direct user-level grants where possible.
- Review the breadth of `AmazonSESFullAccess`, `AWSCertificateManagerFullAccess`, `SecretsAccess`, and `iam_app_beanstalk_policy` before carrying them forward unchanged.

## Existing External Groups

These groups are referenced or used live but are not created by `canon-iam.yaml`:

- `Administrators`
- `MFA`
- `ReadOnly`
- `AWSSupportGroup`
- `Billing`
- `CloudWatchGroup`

Ownership note:

- `MFA`, `Administrators`, scheduler groups, and some app/service policies are owned by other stacks and are out of scope for `canon-iam.yaml` reconciliation.

The repo-defined Canon staff users still rely on existing external groups:

- `Administrators`
- `MFA`

The live `MFA` group contains an inline policy named `canon-mfa-user-policy`. `canon-iam.yaml` references the group but does not define or manage it.

Recommendation:

- Keep treating these as externally owned shared/account foundation groups.
- Do not import them into `canon-iam.yaml`.

## Scheduler Groups

Several live groups are generated-looking scheduler groups, for example:

- `canon-prd-ase1-scheduler-CASCD-UserPermissionsGroup-waqP2faXbXcS`
- `canon-prd-ase1-scheduler-Citec-UserPermissionsGroup-daYcVhhVfC1w`
- `canon-prd-ase1-scheduler-Kiosk-UserPermissionsGroup-Cpk40hy7QuWR`
- `canon-prd-ase1-scheduler-PPDev-UserPermissionsGroup-inj9tWTtnKdR`
- `canon-prd-ase1-scheduler-RedRe-UserPermissionsGroup-r0m0YZsvohmf`

These should not be folded into `canon-iam.yaml` without checking the scheduler stack/template ownership.

Ownership note:

- These scheduler groups are owned by another stack and are out of scope for this IAM reconciliation.

## Customer-Managed Policies Not In Repo

Live customer-managed IAM policies:

- `arn:aws:iam::780347486043:policy/service-role/AWSLambdaBasicExecutionRole-947034fa-bf0b-4f95-b02b-9697f9f478b1`
- `arn:aws:iam::780347486043:policy/DelightfulAppStagingGitlabAccess`
- `arn:aws:iam::780347486043:policy/iam_app_beanstalk_policy`
- `arn:aws:iam::780347486043:policy/service-role/CloudTrailPolicyForCloudWatchLogs_0e6fe697-15c5-4c0b-abab-10568288308c`
- `arn:aws:iam::780347486043:policy/CloudwatchLogsForSESMonitoringPolicy`
- `arn:aws:iam::780347486043:policy/Managed-Own-MFA`

Recommendation:

- Classify each policy as account-foundation, app-specific, or legacy/manual.
- Bring app-specific policies into the appropriate app templates before deploying those stacks.
- Keep service-role generated policies out of hand-authored templates unless they are intentionally managed.
- Do not move externally owned app/service policies into `canon-iam.yaml`.

## Suggested Next Steps

1. Review the `canon-iam.yaml` update that preserves live ThinkBit permissions and the `SSM` `Events` statement.
2. Review the removal of the three repo users missing live:
   - restore them,
   - remove them from the template,
   - or leave them pending until Canon confirms.
3. Keep `MFA`, `Administrators`, scheduler groups, and externally owned app/service policies out of `canon-iam.yaml`.
4. Do not execute an IAM change set until the change set shows no unintended deletes or permission removals.

## Applied In Repo Draft

The `canon-iam.yaml` draft was updated after this report to:

- remove the three CI Tech users missing from live AWS,
- add ThinkBit direct user policy attachments and inline `ImportCreateEC2KeyPair`,
- add live ThinkBit group managed policy `AmazonSESFullAccess`,
- add live ThinkBit group inline policies:
  - `AutoScalingAccess`,
  - `cmp-delightful-app-s3-access`,
  - `Lambda`,
  - `SecretsAccess`,
  - `SES`,
  - `SSMAccessOnEC2`,
- add the live `Events` statement to the existing ThinkBit `SSM` inline policy.
