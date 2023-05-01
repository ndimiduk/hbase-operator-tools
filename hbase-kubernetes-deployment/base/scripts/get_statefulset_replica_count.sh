#!/usr/bin/env bash
# Fetch the replica count for named statefulset
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
${script_dir}/get_statefulset.sh "${1}" | jq '.spec.replicas'
