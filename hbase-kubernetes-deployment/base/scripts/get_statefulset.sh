#!/usr/bin/env bash
# Get the description of the named statefulset
set -x
statefulset="${1}"
outfile=$(mktemp /tmp/$(basename $0).XXXX)
trap '{ rm -f -- "$outfile"; }' EXIT
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${script_dir}/apiserver_access.sh"
# Following model described here: https://chengdol.github.io/2019/11/06/k8s-api/
# http_code is the return status code
http_code=$(curl -w  "%{http_code}" -sS --cacert $CACERT -H "Content-Type: application/json" -H "Accept: application/json, */*" -H "Authorization: Bearer $TOKEN" "$APISERVER/apis/apps/v1/namespaces/$NAMESPACE/statefulsets/$statefulset" -o $outfile)
if [[ $http_code -ne 200 ]]; then
    echo "{\"Result\": \"Failure\", \"httpReturnCode\":$http_code}" | jq '.'
    exit 1
fi
cat $outfile
