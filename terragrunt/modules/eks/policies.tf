# Fetch the Amazon EKS Cluster IAM Policy
# Required for EKS cluster operations
data "aws_iam_policy" "eks_cluster_policy" {
  name = "AmazonEKSClusterPolicy"
}

# Fetch the Amazon EKS Worker Node IAM Policy
data "aws_iam_policy" "eks_worker_node_policy" {
  name = "AmazonEKSWorkerNodePolicy"
}

# Fetch the Amazon EC2 Container Registry Read-Only Policy
data "aws_iam_policy" "ec2_container_registry_read_only_policy" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

# Fetch the Amazon EKS CNI Policy
data "aws_iam_policy" "eks_cni_policy" {
  name = "AmazonEKS_CNI_Policy"
}

# Fetch CSI Driver Policies

data "aws_iam_policy" "ebs_csi_driver_policy" {
  name = "AmazonEBSCSIDriverPolicy"
}

data "aws_iam_policy" "efs_csi_driver_policy" {
  name = "AmazonEFSCSIDriverPolicy"
}

data "aws_iam_policy" "EC2ACCESS" {
  name = "AmazonEC2FullAccess"
}

data "aws_iam_policy" "eks_cni" {
  name = "AmazonEKS_CNI_Policy"
}

########################################################
# IAM Policies - RDS Permissions
########################################################

# # Fetch the Amazon RDS Enhanced Monitoring Policy
# data "aws_iam_policy" "rds_monitoring_policy" {
#   name = "AmazonRDSEnhancedMonitoringRole"
# }

# # Fetch the Amazon RDS Service Role Policy
# # Grants necessary permissions for RDS management
# data "aws_iam_policy" "rds_service_role_policy" {
#   name = "AmazonRDSServiceRolePolicy"
# }
