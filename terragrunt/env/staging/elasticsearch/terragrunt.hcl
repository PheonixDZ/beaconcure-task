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
  namespace        = "monitoring"
  release_name     = "image-processing-elasticsearch-${local.common_vars.environment}"
  chart            = "elasticsearch"
  chart_version    = "7.17.3"
  repository       = "https://helm.elastic.co"
  create_namespace = true
  eks_cluster_name = dependency.eks.outputs.aws_eks_cluster_name

  list_set = [
    {
      name  = "persistence.storageClass"
      value = "gp2"
    },
    {
      name  = "volumeClaimTemplate.storageClassName"
      value = "gp2"
    },
    {
      name  = "replicas"
      value = "1"
    }
  ]
}
