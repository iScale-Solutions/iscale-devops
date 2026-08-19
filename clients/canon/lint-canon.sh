#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  clients/canon/lint-canon.sh --files <path> [<path> ...]
  clients/canon/lint-canon.sh --changed <base-ref> [<head-ref>]

Checks Canon deployment inputs before they reach AWS:
  - tabs and trailing whitespace in YAML and shell/source files
  - GitHub Actions YAML parse errors
  - CloudFormation template errors with cfn-lint
  - shell syntax with bash -n and shellcheck when installed
  - Python syntax for standalone .py files

Only files under clients/canon/ and .github/workflows/canon-*.yml are considered.
USAGE
}

repo_root="$(git rev-parse --show-toplevel)"
cd "${repo_root}"

mode="${1:-}"
if [[ -z "${mode}" || "${mode}" == "-h" || "${mode}" == "--help" ]]; then
  usage
  exit 0
fi
shift

case "${mode}" in
  --files)
    if [[ "$#" -eq 0 ]]; then
      echo "No files were provided."
      exit 1
    fi
    files=("$@")
    ;;
  --changed)
    base_ref="${1:-}"
    if [[ -z "${base_ref}" ]]; then
      echo "--changed requires a base ref."
      exit 1
    fi
    files=()
    if [[ "$#" -gt 1 ]]; then
      head_ref="${2}"
      while IFS= read -r file; do
        files+=("${file}")
      done < <(git diff --name-only --diff-filter=ACMRT "${base_ref}" "${head_ref}")
    else
      while IFS= read -r file; do
        files+=("${file}")
      done < <(git diff --name-only --diff-filter=ACMRT "${base_ref}")
    fi
    ;;
  *)
    echo "Unknown mode: ${mode}"
    usage
    exit 1
    ;;
esac

in_scope() {
  case "$1" in
    clients/canon/*|.github/workflows/canon-*.yml|.github/workflows/canon-*.yaml)
      return 0
      ;;
    *)
      return 1
      ;;
  esac
}

is_yaml() {
  case "$1" in
    *.yaml|*.yml) return 0 ;;
    *) return 1 ;;
  esac
}

is_shell() {
  case "$1" in
    *.sh) return 0 ;;
    *) return 1 ;;
  esac
}

is_python() {
  case "$1" in
    *.py) return 0 ;;
    *) return 1 ;;
  esac
}

is_javascript_or_typescript() {
  case "$1" in
    *.js|*.jsx|*.ts|*.tsx) return 0 ;;
    *) return 1 ;;
  esac
}

is_cfn_template() {
  [[ "$1" == clients/canon/* ]] && is_yaml "$1"
}

has_command() {
  command -v "$1" >/dev/null 2>&1
}

github_group_start() {
  if [[ "${GITHUB_ACTIONS:-}" == "true" ]]; then
    echo "::group::$1"
  else
    echo
    echo "==> $1"
  fi
}

github_group_end() {
  if [[ "${GITHUB_ACTIONS:-}" == "true" ]]; then
    echo "::endgroup::"
  fi
}

report_failure() {
  echo "$1"
  failed=1
}

scoped_files=()
for file in "${files[@]}"; do
  [[ -f "${file}" ]] || continue
  if in_scope "${file}"; then
    scoped_files+=("${file}")
  fi
done

if [[ "${#scoped_files[@]}" -eq 0 ]]; then
  echo "No Canon workflow files matched the lint scope."
  exit 0
fi

unique_scoped_files=()
while IFS= read -r file; do
  unique_scoped_files+=("${file}")
done < <(printf '%s\n' "${scoped_files[@]}" | sort -u)
scoped_files=("${unique_scoped_files[@]}")

echo "Canon lint scope:"
printf '  %s\n' "${scoped_files[@]}"

failed=0

github_group_start "Whitespace"
for file in "${scoped_files[@]}"; do
  case "${file}" in
    *.yaml|*.yml|*.sh|*.py|*.js|*.jsx|*.ts|*.tsx)
      if LC_ALL=C grep -n $'\t' "${file}"; then
        report_failure "Tabs found in ${file}."
      fi
      if LC_ALL=C grep -n '[[:blank:]]$' "${file}"; then
        report_failure "Trailing whitespace found in ${file}."
      fi
      ;;
  esac
done
github_group_end

workflow_yaml=()
cfn_templates=()
shell_scripts=()
python_files=()
js_ts_files=()

for file in "${scoped_files[@]}"; do
  if [[ "${file}" == .github/workflows/* ]] && is_yaml "${file}"; then
    workflow_yaml+=("${file}")
  elif is_cfn_template "${file}"; then
    cfn_templates+=("${file}")
  elif is_shell "${file}"; then
    shell_scripts+=("${file}")
  elif is_python "${file}"; then
    python_files+=("${file}")
  elif is_javascript_or_typescript "${file}"; then
    js_ts_files+=("${file}")
  fi
done

if [[ "${#workflow_yaml[@]}" -gt 0 ]]; then
  github_group_start "GitHub Actions YAML"
  for file in "${workflow_yaml[@]}"; do
    echo "Parsing ${file}"
    if ! ruby -e 'require "yaml"; ARGV.each { |path| YAML.load_file(path) }' "${file}"; then
      report_failure "GitHub Actions YAML parse failed for ${file}."
    fi
  done
  github_group_end
fi

if [[ "${#cfn_templates[@]}" -gt 0 ]]; then
  github_group_start "CloudFormation lint"
  if ! has_command cfn-lint; then
    report_failure "cfn-lint is required for CloudFormation checks. Install it with: python3 -m pip install --user cfn-lint"
  else
    for file in "${cfn_templates[@]}"; do
      echo "Linting ${file}"
      if ! cfn-lint --non-zero-exit-code error "${file}"; then
        report_failure "CloudFormation lint failed for ${file}."
      fi
    done
  fi
  github_group_end
fi

if [[ "${#shell_scripts[@]}" -gt 0 ]]; then
  github_group_start "Shell scripts"
  for file in "${shell_scripts[@]}"; do
    echo "Checking shell syntax for ${file}"
    if ! bash -n "${file}"; then
      report_failure "bash -n failed for ${file}."
    fi
    if has_command shellcheck; then
      echo "Running shellcheck for ${file}"
      if ! shellcheck "${file}"; then
        report_failure "shellcheck failed for ${file}."
      fi
    else
      echo "shellcheck is not installed; skipping shellcheck for ${file}."
    fi
  done
  github_group_end
fi

if [[ "${#python_files[@]}" -gt 0 ]]; then
  github_group_start "Python scripts"
  for file in "${python_files[@]}"; do
    echo "Compiling ${file}"
    if ! python3 -m py_compile "${file}"; then
      report_failure "Python syntax check failed for ${file}."
    fi
  done
  github_group_end
fi

if [[ "${#js_ts_files[@]}" -gt 0 ]]; then
  github_group_start "JavaScript and TypeScript scripts"
  if [[ -f package.json && -x node_modules/.bin/eslint ]]; then
    if ! node_modules/.bin/eslint "${js_ts_files[@]}"; then
      report_failure "ESLint failed for Canon JavaScript/TypeScript files."
    fi
  else
    echo "No repo JavaScript/TypeScript lint tooling is configured; files present:"
    printf '  %s\n' "${js_ts_files[@]}"
  fi
  github_group_end
fi

if [[ "${failed}" -ne 0 ]]; then
  echo "Canon lint failed."
  exit 1
fi

echo "Canon lint passed."
