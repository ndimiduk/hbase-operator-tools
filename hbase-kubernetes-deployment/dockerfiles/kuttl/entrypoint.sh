#!/usr/bin/env bash

set -e
set -o pipefail
set -x

declare ENVTEST_K8S_VERSION

declare KUBEBUILDER_ASSETS
KUBEBUILDER_ASSETS="$(setup-envtest use -i "${ENVTEST_K8S_VERSION}" -p path)"
export KUBEBUILDER_ASSETS

/usr/local/bin/kubectl kuttl test "$@"
