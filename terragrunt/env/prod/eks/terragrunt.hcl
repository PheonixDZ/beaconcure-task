include "remote_state" {
  path = find_in_parent_folders("backend.hcl")
}

include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

terraform {
  source = "../../../modules//eks"
}

# cat > terragrunt/env/staging/eks/terragrunt.hcl << 'EOL'

dependency "vpc" {
  config_path = "../vpc"
}

locals {
  common_vars = yamldecode(file("${find_in_parent_folders("common-vars.yml")}"))
}

inputs = {
  # Common Variables
  region      = local.common_vars.region
  project     = local.common_vars.project
  environment = local.common_vars.environment

  # EKS Cluster Configuration
  eks_cluster_name                     = "image-processing-${local.common_vars.environment}"
  eks_cluster_version                  = "1.30"
  cluster_service_ipv4_cidr            = "172.21.0.0/16"
  cluster_enabled_log_types            = ["api", "audit", "authenticator"]
  cluster_endpoint_private_access      = true
  cluster_endpoint_public_access       = true
  cluster_endpoint_public_access_cidrs = ["0.0.0.0/0"]
  eks_cluster_tag_name                 = "image-processing-${local.common_vars.environment}-cluster"

  # EKS Add-ons
  eks_addon_name    = ["vpc-cni", "coredns", "kube-proxy", "aws-ebs-csi-driver", "aws-efs-csi-driver"]
  eks_addon_version = ["v1.19.2-eksbuild.5", "v1.11.4-eksbuild.2", "v1.30.9-eksbuild.3", "v1.41.0-eksbuild.1", "v2.1.7-eksbuild.1"]


  # Node Group Configuration
  node_group_name               = "image-processing-${local.common_vars.environment}-ng"
  capacity_type                 = "ON_DEMAND"
  eks_node_group_tag_name       = "image-processing-${local.common_vars.environment}-ng"
  eks_node_group_instance_types = ["t3.medium"] # Smaller instance for staging
  eks_node_group_ami_type       = "AL2_x86_64"
  eks_node_group_disk_size      = 20 # Smaller disk for staging
  eks_node_group_desired_size   = 3  # Fewer nodes for staging
  eks_node_group_max_size       = 5
  eks_node_group_min_size       = 1

  # Security Group Configuration
  eks_security_group_name     = "image-processing-${local.common_vars.environment}-eks-sg"
  eks_security_group_tag_name = "image-processing-${local.common_vars.environment}-eks-sg"

  # Security Group Rules
  eks_ingress_rules           = ["https-443-tcp"]
  eks_ingress_cidr_blocks     = ["106.219.85.123/32"] # Whitelist your IP to get access to EKS cluster
  eks_ingress_rules_from_port = [443]
  eks_ingress_rules_to_port   = [443]
  eks_ingress_rules_protocols = ["tcp"]

  eks_egress_rules           = ["all-all"]
  eks_egress_cidr_blocks     = ["0.0.0.0/0"]
  eks_egress_rules_from_port = [0]
  eks_egress_rules_to_port   = [0]
  eks_egress_rules_protocols = ["-1"]

  # VPC and Subnet Configuration (from VPC dependency)
  vpc_id         = dependency.vpc.outputs.vpc_id
  subnet_ids     = dependency.vpc.outputs.private_subnet_ids
  vpc_cidr_block = [dependency.vpc.outputs.vpc_cidr_block]

  # EFS Configuration
  efs_name                 = "efs-for-eks"
  efs_security_groups_name = "efs-security-group"
}
