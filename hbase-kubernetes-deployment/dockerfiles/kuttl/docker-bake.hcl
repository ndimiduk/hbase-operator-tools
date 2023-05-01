#
# A convenience script for build the kuttl image.
# See hbase-kubernetes-deployment/dockerfiles/kuttl/README.md
#

# input variables
variable "KUBECTL_SHA_AMD64" {}
variable "KUBECTL_BIN_AMD64" {}
variable "KUBECTL_SHA_ARM64" {}
variable "KUBECTL_BIN_ARM64" {}
variable "KUTTL_CHECKSUMS" {}
variable "KUTTL_BIN_AMD64" {}
variable "KUTTL_BIN_ARM64" {}
variable "KUSTOMIZE_CHECKSUMS" {}
variable "KUSTOMIZE_BIN_AMD64_TGZ" {}
variable "KUSTOMIZE_BIN_ARM64_TGZ" {}
variable "AWS_CLI_SOURCES_TGZ" {}
variable "AWS_CLI_SOURCES_TGZ_SIG" {}

# output variables
variable "USER" {}
variable "IMAGE_TAG" {
  default = "latest"
}
variable "IMAGE_NAME" {
  default = "${USER}/hbase/operator-tools/kuttl"
}

group "default" {
  targets = [ "kuttl" ]
}

target "kuttl" {
  dockerfile = "hbase-kubernetes-deployment/dockerfiles/kuttl/Dockerfile"
  args = {
    KUBECTL_SHA_AMD64 = KUBECTL_SHA_AMD64
    KUBECTL_BIN_AMD64 = KUBECTL_BIN_AMD64
    KUBECTL_SHA_ARM64 = KUBECTL_SHA_ARM64
    KUBECTL_BIN_ARM64 = KUBECTL_BIN_ARM64
    KUTTL_CHECKSUMS = KUTTL_CHECKSUMS
    KUTTL_BIN_AMD64 = KUTTL_BIN_AMD64
    KUTTL_BIN_ARM64 = KUTTL_BIN_ARM64
    KUSTOMIZE_CHECKSUMS = KUSTOMIZE_CHECKSUMS
    KUSTOMIZE_BIN_AMD64_TGZ = KUSTOMIZE_BIN_AMD64_TGZ
    KUSTOMIZE_BIN_ARM64_TGZ = KUSTOMIZE_BIN_ARM64_TGZ
    AWS_CLI_SOURCES_TGZ = AWS_CLI_SOURCES_TGZ
    AWS_CLI_SOURCES_TGZ_SIG = AWS_CLI_SOURCES_TGZ_SIG
  }
  target = "final"
  platforms = [
    "linux/amd64",
    "linux/arm64"
  ]
  tags = [ "${IMAGE_NAME}:${IMAGE_TAG}" ]
}
