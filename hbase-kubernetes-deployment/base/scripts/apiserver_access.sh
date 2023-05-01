#! /usr/bin/env bash
# Defines used accessing the apiserver.
NAMESPACE=$(cat /var/run/secrets/kubernetes.io/serviceaccount/namespace)
export NAMESPACE
APISERVER=https://$KUBERNETES_SERVICE_HOST:$KUBERNETES_SERVICE_PORT
export APISERVER
CACERT=/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
export CACERT
TOKEN=$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)
export TOKEN
