#!/usr/bin/env bash
set -euo pipefail
export LC_ALL=C

out_dir="${1:-canon-audit}"
regions_csv="${2:-ap-southeast-1}"
include_drift="${3:-false}"

mkdir -p "${out_dir}/meta" "${out_dir}/iam" "${out_dir}/cloudformation"

run_json() {
  local output_file="$1"
  local error_file="${output_file}.stderr"
  shift

  if "$@" > "${output_file}" 2> "${error_file}"; then
    rm -f "${error_file}"
    return 0
  fi

  local status=$?
  jq -n \
    --arg status "${status}" \
    --arg command "$*" \
    --rawfile stderr "${error_file}" \
    '{error: true, exitStatus: ($status | tonumber), command: $command, stderr: $stderr}' \
    > "${output_file}"
  rm -f "${error_file}"
  return 0
}

safe_name() {
  printf '%s' "$1" | tr -c '[:alnum:]_.+=,@-' '_'
}

write_lines_json() {
  local output_file="$1"
  shift
  if [[ "$#" -eq 0 ]]; then
    jq -n '[]' > "${output_file}"
    return 0
  fi
  printf '%s\n' "$@" | jq -R . | jq -s . > "${output_file}"
}

json_lines() {
  local jq_filter="$1"
  local input_file="$2"
  jq -r "${jq_filter}" "${input_file}"
}

timestamp="$(date -u +"%Y-%m-%dT%H:%M:%SZ")"
jq -n \
  --arg generatedAt "${timestamp}" \
  --arg regions "${regions_csv}" \
  --arg includeDrift "${include_drift}" \
  '{generatedAt: $generatedAt, regions: ($regions | split(",") | map(gsub("^\\s+|\\s+$"; ""))), includeDrift: ($includeDrift == "true")}' \
  > "${out_dir}/meta/audit-run.json"

run_json "${out_dir}/meta/caller-identity.json" aws sts get-caller-identity --output json
run_json "${out_dir}/iam/account-summary.json" aws iam get-account-summary --output json

run_json "${out_dir}/iam/users.json" aws iam list-users --output json
run_json "${out_dir}/iam/groups.json" aws iam list-groups --output json
run_json "${out_dir}/iam/roles.json" aws iam list-roles --output json
run_json "${out_dir}/iam/customer-managed-policies.json" aws iam list-policies --scope Local --output json

users=()
while IFS= read -r line; do users+=("${line}"); done < <(json_lines '.Users[]?.UserName' "${out_dir}/iam/users.json")
groups=()
while IFS= read -r line; do groups+=("${line}"); done < <(json_lines '.Groups[]?.GroupName' "${out_dir}/iam/groups.json")
roles=()
while IFS= read -r line; do roles+=("${line}"); done < <(json_lines '.Roles[]?.RoleName' "${out_dir}/iam/roles.json")
policies=()
while IFS= read -r line; do policies+=("${line}"); done < <(json_lines '.Policies[]?.Arn' "${out_dir}/iam/customer-managed-policies.json")

write_lines_json "${out_dir}/iam/user-names.json" "${users[@]}"
write_lines_json "${out_dir}/iam/group-names.json" "${groups[@]}"
write_lines_json "${out_dir}/iam/role-names.json" "${roles[@]}"
write_lines_json "${out_dir}/iam/customer-managed-policy-arns.json" "${policies[@]}"

mkdir -p "${out_dir}/iam/users" "${out_dir}/iam/groups" "${out_dir}/iam/roles" "${out_dir}/iam/policies"

for user in "${users[@]}"; do
  safe_user="$(safe_name "${user}")"
  user_dir="${out_dir}/iam/users/${safe_user}"
  mkdir -p "${user_dir}"

  run_json "${user_dir}/groups.json" aws iam list-groups-for-user --user-name "${user}" --output json
  run_json "${user_dir}/attached-policies.json" aws iam list-attached-user-policies --user-name "${user}" --output json
  run_json "${user_dir}/inline-policy-names.json" aws iam list-user-policies --user-name "${user}" --output json
  run_json "${user_dir}/access-keys.json" aws iam list-access-keys --user-name "${user}" --output json
  run_json "${user_dir}/mfa-devices.json" aws iam list-mfa-devices --user-name "${user}" --output json
  run_json "${user_dir}/login-profile.json" aws iam get-login-profile --user-name "${user}" --output json

  inline_user_policies=()
  while IFS= read -r line; do inline_user_policies+=("${line}"); done < <(json_lines '.PolicyNames[]?' "${user_dir}/inline-policy-names.json")
  mkdir -p "${user_dir}/inline-policies"
  for policy_name in "${inline_user_policies[@]}"; do
    safe_policy="$(safe_name "${policy_name}")"
    run_json "${user_dir}/inline-policies/${safe_policy}.json" \
      aws iam get-user-policy --user-name "${user}" --policy-name "${policy_name}" --output json
  done
done

for group in "${groups[@]}"; do
  safe_group="$(safe_name "${group}")"
  group_dir="${out_dir}/iam/groups/${safe_group}"
  mkdir -p "${group_dir}"

  run_json "${group_dir}/group.json" aws iam get-group --group-name "${group}" --output json
  run_json "${group_dir}/attached-policies.json" aws iam list-attached-group-policies --group-name "${group}" --output json
  run_json "${group_dir}/inline-policy-names.json" aws iam list-group-policies --group-name "${group}" --output json

  inline_group_policies=()
  while IFS= read -r line; do inline_group_policies+=("${line}"); done < <(json_lines '.PolicyNames[]?' "${group_dir}/inline-policy-names.json")
  mkdir -p "${group_dir}/inline-policies"
  for policy_name in "${inline_group_policies[@]}"; do
    safe_policy="$(safe_name "${policy_name}")"
    run_json "${group_dir}/inline-policies/${safe_policy}.json" \
      aws iam get-group-policy --group-name "${group}" --policy-name "${policy_name}" --output json
  done
done

for role in "${roles[@]}"; do
  safe_role="$(safe_name "${role}")"
  role_dir="${out_dir}/iam/roles/${safe_role}"
  mkdir -p "${role_dir}"

  run_json "${role_dir}/role.json" aws iam get-role --role-name "${role}" --output json
  run_json "${role_dir}/attached-policies.json" aws iam list-attached-role-policies --role-name "${role}" --output json
  run_json "${role_dir}/inline-policy-names.json" aws iam list-role-policies --role-name "${role}" --output json
  run_json "${role_dir}/instance-profiles.json" aws iam list-instance-profiles-for-role --role-name "${role}" --output json

  inline_role_policies=()
  while IFS= read -r line; do inline_role_policies+=("${line}"); done < <(json_lines '.PolicyNames[]?' "${role_dir}/inline-policy-names.json")
  mkdir -p "${role_dir}/inline-policies"
  for policy_name in "${inline_role_policies[@]}"; do
    safe_policy="$(safe_name "${policy_name}")"
    run_json "${role_dir}/inline-policies/${safe_policy}.json" \
      aws iam get-role-policy --role-name "${role}" --policy-name "${policy_name}" --output json
  done
done

for policy_arn in "${policies[@]}"; do
  safe_policy_arn="$(safe_name "${policy_arn}")"
  policy_dir="${out_dir}/iam/policies/${safe_policy_arn}"
  mkdir -p "${policy_dir}"

  run_json "${policy_dir}/policy.json" aws iam get-policy --policy-arn "${policy_arn}" --output json
  default_version="$(jq -r '.Policy.DefaultVersionId // empty' "${policy_dir}/policy.json")"
  if [[ -n "${default_version}" ]]; then
    run_json "${policy_dir}/default-version.json" \
      aws iam get-policy-version --policy-arn "${policy_arn}" --version-id "${default_version}" --output json
  fi
  run_json "${policy_dir}/versions.json" aws iam list-policy-versions --policy-arn "${policy_arn}" --output json
done

IFS=',' read -ra regions <<< "${regions_csv}"
for raw_region in "${regions[@]}"; do
  region="$(printf '%s' "${raw_region}" | xargs)"
  [[ -n "${region}" ]] || continue

  region_dir="${out_dir}/cloudformation/${region}"
  mkdir -p "${region_dir}/stacks"
  run_json "${region_dir}/stacks.json" aws cloudformation list-stacks \
    --region "${region}" \
    --stack-status-filter CREATE_COMPLETE UPDATE_COMPLETE UPDATE_ROLLBACK_COMPLETE IMPORT_COMPLETE IMPORT_ROLLBACK_COMPLETE ROLLBACK_COMPLETE \
    --output json

  stack_names=()
  while IFS= read -r line; do stack_names+=("${line}"); done < <(json_lines '.StackSummaries[]?.StackName' "${region_dir}/stacks.json")
  write_lines_json "${region_dir}/stack-names.json" "${stack_names[@]}"

  for stack_name in "${stack_names[@]}"; do
    safe_stack="$(safe_name "${stack_name}")"
    stack_dir="${region_dir}/stacks/${safe_stack}"
    mkdir -p "${stack_dir}"

    run_json "${stack_dir}/description.json" aws cloudformation describe-stacks --region "${region}" --stack-name "${stack_name}" --output json
    run_json "${stack_dir}/resources.json" aws cloudformation describe-stack-resources --region "${region}" --stack-name "${stack_name}" --output json
    run_json "${stack_dir}/template.json" aws cloudformation get-template --region "${region}" --stack-name "${stack_name}" --output json
    if [[ "${include_drift}" == "true" ]]; then
      run_json "${stack_dir}/drift.json" aws cloudformation describe-stack-drift-detection-status --region "${region}" --stack-drift-detection-id \
        "$(aws cloudformation detect-stack-drift --region "${region}" --stack-name "${stack_name}" --query StackDriftDetectionId --output text)" \
        --output json
    fi
  done
done

find "${out_dir}" -type f | sort > "${out_dir}/manifest.txt"
