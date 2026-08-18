# Canon AWS Bootstrap

This folder is the first step toward bringing Canon AWS changes back under source control without overwriting manual account changes.

`github-actions-role.yaml` creates a GitHub Actions OIDC role for this repository. The default `PermissionMode` is `PlanOnly`, which allows GitHub Actions to read current AWS state and prepare CloudFormation change sets, but not execute them.

## Authentication Model

GitHub Actions must access the Canon AWS account through OIDC only. Do not create or store long-lived AWS access keys in GitHub secrets for this workflow.

The workflow requests the GitHub OIDC token with `id-token: write`, then uses `aws-actions/configure-aws-credentials` to assume the role created by `github-actions-role.yaml`. Store only the role ARN in the GitHub repository variable `CANON_AWS_ROLE_TO_ASSUME`.

## First Manual Deploy

Deploy this stack once from an administrator session in the Canon AWS account `780347486043`. Most Canon stacks run in Singapore, so the default bootstrap region is `ap-southeast-1`.

Before deploying, verify the active AWS account:

```bash
aws sts get-caller-identity --query Account --output text
```

The output must be:

```text
780347486043
```

```bash
aws cloudformation deploy \
  --region ap-southeast-1 \
  --stack-name canon-prd-ase1-github-actions-bootstrap \
  --template-file clients/canon/bootstrap/github-actions-role.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    GitHubOrg=iScale-Solutions \
    GitHubRepo=iscale-devops \
    GitHubBranch=master \
    CreateGitHubOIDCProvider=no \
    PermissionMode=PlanOnly \
    BootstrapStackName=canon-prd-ase1-github-actions-bootstrap \
    SharedIncludeBucketName=iscale-dev-cloudformation
```

If the account does not already have the GitHub OIDC provider, set `CreateGitHubOIDCProvider=yes`.

After deployment, copy the `RoleArn` output into the GitHub repository variable `CANON_AWS_ROLE_TO_ASSUME`:

```bash
aws cloudformation describe-stacks \
  --region ap-southeast-1 \
  --stack-name canon-prd-ase1-github-actions-bootstrap \
  --query 'Stacks[0].Outputs[?OutputKey==`RoleArn`].OutputValue' \
  --output text
```

## Safety Model

- `PlanOnly` can validate templates, inspect IAM and stack state, detect drift, and create or delete change sets.
- `PlanOnly` can execute change sets only for `canon-prd-ase1-github-actions-bootstrap`, so the GitHub Actions role can update its own bootstrap permissions after the first manual deploy.
- `PlanOnly` cannot execute change sets for other Canon stacks.
- Keep existing Canon IAM stacks out of automatic deployment until the repo has been reconciled against the live AWS account.
- Change `PermissionMode` to `Deploy` only after manual drift has been reviewed and the stack ownership model is clear.

## Updating The Bootstrap From GitHub

After this self-management permission has been deployed once, use the `Canon AWS Plan` workflow manually with:

```text
stack_name=canon-prd-ase1-github-actions-bootstrap
template_path=clients/canon/bootstrap/github-actions-role.yaml
create_change_set=true
execute_change_set=true
```

The workflow refuses to execute change sets for any other stack while the role remains in `PlanOnly`.
