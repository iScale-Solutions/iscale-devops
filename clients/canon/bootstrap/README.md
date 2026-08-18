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
  --stack-name canon-github-actions-bootstrap \
  --template-file clients/canon/bootstrap/github-actions-role.yaml \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides \
    GitHubOrg=iScale-Solutions \
    GitHubRepo=iscale-devops \
    GitHubBranch=master \
    CreateGitHubOIDCProvider=no \
    PermissionMode=PlanOnly \
    SharedIncludeBucketName=iscale-dev-cloudformation
```

If the account does not already have the GitHub OIDC provider, set `CreateGitHubOIDCProvider=yes`.

After deployment, copy the `RoleArn` output into the GitHub repository variable `CANON_AWS_ROLE_TO_ASSUME`.

## Safety Model

- `PlanOnly` can validate templates, inspect IAM and stack state, detect drift, and create or delete change sets.
- `PlanOnly` cannot execute change sets.
- Keep existing Canon IAM stacks out of automatic deployment until the repo has been reconciled against the live AWS account.
- Change `PermissionMode` to `Deploy` only after manual drift has been reviewed and the stack ownership model is clear.
