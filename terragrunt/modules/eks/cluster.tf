# data "aws_eks_cluster" "eks_cluster" {
#   depends_on = [
#     module.eks
#   ]
#   name = module.eks.aws_eks_cluster_name
# }

# data "aws_eks_cluster_auth" "eks_cluster" {
#   name = module.eks.aws_eks_cluster_name
# }

########################################################
# EKS Cluster
########################################################

resource "aws_eks_cluster" "eks_cluster" {
  name    = "${var.project}-eks-cluster-${var.environment}"
  version = var.eks_cluster_version

  # IAM role for the EKS cluster
  role_arn = aws_iam_role.eks_cluster_role.arn

  # Kubernetes network configuration
  kubernetes_network_config {
    ip_family         = "ipv4"
    service_ipv4_cidr = var.cluster_service_ipv4_cidr
  }

  # VPC configuration for EKS
  vpc_config {
    endpoint_private_access = var.cluster_endpoint_private_access
    endpoint_public_access  = var.cluster_endpoint_public_access
    public_access_cidrs     = var.cluster_endpoint_public_access_cidrs
    security_group_ids      = [aws_security_group.eks_security_group.id]
    subnet_ids              = var.subnet_ids
  }

  enabled_cluster_log_types = var.cluster_enabled_log_types

  tags = {
    Name = "${var.project}-eks-cluster-${var.environment}"
  }

  depends_on = [
    aws_security_group.eks_security_group
  ]
}

########################################################
# EKS Addons
########################################################

resource "aws_eks_addon" "addon" {
  for_each = { for i, name in var.eks_addon_name : name => i }

  addon_name               = each.key
  addon_version            = var.eks_addon_version[each.value]
  cluster_name             = aws_eks_cluster.eks_cluster.name
  service_account_role_arn = each.key == "aws-ebs-csi-driver" ? module.iam_assumable_role_with_oidc_ebs_csi_driver.this_iam_role_arn : (each.key == "aws-efs-csi-driver" ? module.iam_assumable_role_with_oidc_efs_csi_driver.this_iam_role_arn : null)

  depends_on = [
    aws_eks_cluster.eks_cluster,
    aws_eks_node_group.node_group
  ]
}

########################################################
# EKS Node Group
########################################################

resource "aws_eks_node_group" "node_group" {
  node_group_name = "${var.project}-node-group-${var.environment}"
  cluster_name    = aws_eks_cluster.eks_cluster.id

  # IAM role for the EKS node group
  node_role_arn  = aws_iam_role.eks_node_role.arn
  capacity_type  = var.capacity_type
  subnet_ids     = var.subnet_ids
  ami_type       = var.eks_node_group_ami_type
  disk_size      = var.eks_node_group_disk_size
  instance_types = var.eks_node_group_instance_types

  labels = {
    nodegroup = var.node_group_label
  }
  tags = {
    Name = "${var.project}-node-group-${var.environment}"
  }

  # Scaling configuration for node group
  scaling_config {
    desired_size = var.eks_node_group_desired_size
    min_size     = var.eks_node_group_min_size
    max_size     = var.eks_node_group_max_size
  }
}

########################################################
# OIDC Provider for EKS
########################################################

data "tls_certificate" "eks" {
  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
  url = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}

resource "aws_iam_openid_connect_provider" "eks" {
  depends_on = [
    aws_eks_cluster.eks_cluster
  ]
  url             = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = [data.tls_certificate.eks.certificates[0].sha1_fingerprint]
}
