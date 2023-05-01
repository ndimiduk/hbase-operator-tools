#!/usr/bin/env bash
# Fetch the labels json object for named node
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
${script_dir}/describe_node.sh "${1}" | jq -r '.metadata.labels'
