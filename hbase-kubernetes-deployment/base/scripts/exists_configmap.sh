#!/usr/bin/env bash
# Check passed in configmap exists.
# Also checks if configmap with the POD_NAME exists too.
# Returns zero if found.
set -x
configmap_name="${1}"
outfile=$(mktemp /tmp/$(basename $0).XXXX)
trap 'rm -f -- "$outfile"' EXIT
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${script_dir}/apiserver_access.sh"
# Following model described here: https://chengdol.github.io/2019/11/06/k8s-api/
# http_code is the return status code
# From https://docs.okd.io/3.7/rest_api/api/v1.ConfigMap.html#Delete-api-v1-namespaces-namespace-configmaps-name
http_code=$(curl -w  "%{http_code}" -sS --cacert $CACERT -H "Content-Type: application/json" -H "Accept: application/json, */*" -H "Authorization: Bearer $TOKEN" "$APISERVER/api/v1/namespaces/$NAMESPACE/configmaps/$configmap_name" -o $outfile)
[[ $http_code -eq 200 ]] || (
  # The configmap does not exist. Look for a configmap with this POD_NAME as a suffix too.
  http_code=$(curl -w  "%{http_code}" -sS --cacert $CACERT -H "Content-Type: application/json" -H "Accept: application/json, */*" -H "Authorization: Bearer $TOKEN" "$APISERVER/api/v1/namespaces/$NAMESPACE/configmaps/$configmap_name.${POD_NAME}" -o $outfile)
  [[ $http_code -eq 200 ]]
)
