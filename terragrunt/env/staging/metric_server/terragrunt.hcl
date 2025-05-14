include "remote_state" {
  path = find_in_parent_folders("backend.hcl")
}

include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

dependency "eks" {
  config_path = "../eks"
}

terraform {
  source = "../../../modules//helm"
}

locals {
  common_vars = yamldecode(file("${find_in_parent_folders("common-vars.yml")}"))
}

inputs = {
  namespace        = "kube-system"
  release_name     = "image-processing-metrics-server-${local.common_vars.environment}"
  chart            = "metrics-server"
  chart_version    = "3.11.0"
  repository       = "https://kubernetes-sigs.github.io/metrics-server/"
  create_namespace = false
  eks_cluster_name = dependency.eks.outputs.aws_eks_cluster_name

  list_set = [
    {
      name  = "replicas"
      value = "2"
    },
    {
      name  = "resources.requests.cpu"
      value = "100m"
    },
    {
      name  = "resources.requests.memory"
      value = "200Mi"
    },
    {
      name  = "resources.limits.cpu"
      value = "200m"
    },
    {
      name  = "resources.limits.memory"
      value = "400Mi"
    },
    {
      name  = "args[0]"
      value = "--kubelet-insecure-tls"
    },
    {
      name  = "args[1]"
      value = "--kubelet-preferred-address-types=InternalIP"
    },
    {
      name  = "securityContext.runAsNonRoot"
      value = "true"
    },
    {
      name  = "securityContext.runAsUser"
      value = "1000"
    },
    {
      name  = "nodeSelector.kubernetes\\.io/os"
      value = "linux"
    },
    {
      name  = "podAntiAffinity"
      value = "soft"
    },
    {
      name  = "priorityClassName"
      value = "system-cluster-critical"
    }
  ]
}
