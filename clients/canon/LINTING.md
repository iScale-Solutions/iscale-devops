# Canon linting

Canon deployment workflows run a lint gate before any CloudFormation change set is created or executed.

## Local setup

Install the same tools used by GitHub Actions:

```sh
python3 -m pip install --user cfn-lint
brew install shellcheck
```

If your Python user scripts directory is not on `PATH`, add it before running the checks. On macOS this is commonly:

```sh
export PATH="$HOME/Library/Python/3.9/bin:$PATH"
```

## Run checks locally

Check explicit files:

```sh
clients/canon/lint-canon.sh --files \
  .github/workflows/canon-aws-plan.yml \
  clients/canon/canon-iam.yaml \
  clients/canon/audit/export-canon-aws-inventory.sh
```

Check files changed against `origin/master`:

```sh
clients/canon/lint-canon.sh --changed origin/master...HEAD
```

## What is checked

- Tabs and trailing whitespace in Canon YAML, shell, Python, JavaScript, and TypeScript files.
- GitHub Actions workflow YAML parse errors.
- Canon CloudFormation templates with `cfn-lint`; warnings are reported, but only errors fail the gate.
- Shell scripts with `bash -n` and `shellcheck` when available.
- Standalone Python files with `python3 -m py_compile`.
- JavaScript/TypeScript files with the repo's ESLint setup when one exists.

There are currently no standalone Canon Lambda/source script files outside inline CloudFormation code and the audit shell script. If standalone Lambda code is added later, place it under `clients/canon/` so this gate can check it.
