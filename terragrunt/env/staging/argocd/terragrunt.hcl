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
  namespace        = "argocd"
  release_name     = "image-processing-argocd-${local.common_vars.environment}"
  chart            = "argo-cd"
  chart_version    = "5.33.1"
  repository       = "https://argoproj.github.io/argo-helm"
  create_namespace = true
  eks_cluster_name = dependency.eks.outputs.aws_eks_cluster_name

  list_set = [
    {
      name  = "server.ingress.enabled"
      value = "true"
    },
    {
      name  = "server.service.type"
      value = "LoadBalancer"
    }
  ]
}
