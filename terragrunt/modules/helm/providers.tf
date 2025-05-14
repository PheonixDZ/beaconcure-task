terraform {
  required_version = ">= 0.13"
  required_providers {
    kubectl = {
      source  = "gavinbunney/kubectl"
      version = "1.14.0"
    }
    helm = {
      source  = "hashicorp/helm"
      version = "2.9.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "2.19.0"
    }
  }
}

data "aws_eks_cluster" "eks" {
  name = var.eks_cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = var.eks_cluster_name
}

provider "helm" {
  kubernetes {
    config_path = "~/.kube/config"
  }
}

provider "kubectl" {
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  config_path            = "~/.kube/config"
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
}

provider "kubernetes" {
  config_path            = "~/.kube/config"
  host                   = data.aws_eks_cluster.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks_cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.eks_cluster.token
}
