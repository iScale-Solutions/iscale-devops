# Canon AWS Audit

This audit captures live Canon AWS inventory without making changes. It is the first reconciliation step before letting CloudFormation manage IAM again.

The GitHub workflow `Canon AWS Audit` assumes the Canon OIDC role, confirms account `780347486043`, exports inventory, and uploads it as a workflow artifact.

The audit includes:

- Optional IAM users, groups, roles, customer-managed policies, inline policies, attached policies, access-key metadata, MFA devices, and login-profile presence when `include_iam=true`.
- Optional CloudFormation stacks, resources, and templates for the selected regions when `include_cloudformation=true`.
- Optional CloudFormation drift detection when `include_drift=true`.

It does not call `secretsmanager:GetSecretValue`, does not read secret values, and does not create, update, or delete AWS resources.

Run locally with AWS credentials pointed at the Canon account:

```bash
clients/canon/audit/export-canon-aws-inventory.sh canon-audit ap-southeast-1 true false false
```
