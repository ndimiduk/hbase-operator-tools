#!/usr/bin/env bash
# Get the labels json object of the node upon which the pod with the provided pod IP is running
script_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
source "${script_dir}/log.sh" "$TOPOLOGY_LOG" # source log function; the $TOPOLOGY_LOG variable is set in topology.sh
nodeName=$(${script_dir}/get_node_name_from_pod_IP.sh "${1}") # requesting node name based on pod IP
if [[ nodeName == "null" ]] # if no node is found when querying with this pod IP
then
  log -w "Unhandled case: Kubernetes instance not found for this pod IP"
  echo "null" # null will get passed back to the topology caller; then when looking for the pertinent labels topology.sh will label this DN with the default rack
else
  log "nodeName found in pod description: $nodeName"
  nodeLabels=$(${script_dir}/get_node_labels.sh $nodeName) # getting the labels of the Kube node the pod is running on
  log "node metadata labels: $nodeLabels"
  echo $nodeLabels
fi
