########################################################
# IAM Role - EKS Cluster Role
########################################################

resource "aws_iam_role" "eks_cluster_role" {
  name        = "eksClusterRole-${var.region}"
  description = "Allows access to other AWS service resources that are required to operate clusters managed by EKS."
  path        = "/"

  # IAM assume role policy stored in an external JSON file
  assume_role_policy = file("${path.module}/eks_roles/roles/eks_cluster_role.json")

  force_detach_policies = false

  # Attach EKS Cluster policy
  managed_policy_arns = [data.aws_iam_policy.eks_cluster_policy.arn]
}

########################################################
# IAM Role - EKS Node Role
########################################################

resource "aws_iam_role" "eks_node_role" {
  name        = "eksNodeRole-${var.region}"
  description = "Amazon EKS - Node role."
  path        = "/"

  # IAM assume role policy stored in an external JSON file
  assume_role_policy = file("${path.module}/eks_roles/roles/eks_node_role.json")

  force_detach_policies = false

  # Attach required policies for worker nodes
  managed_policy_arns = [
    data.aws_iam_policy.ec2_container_registry_read_only_policy.arn,
    data.aws_iam_policy.eks_worker_node_policy.arn,
    data.aws_iam_policy.eks_cni_policy.arn
  ]
}

########################################################
# IAM Role - EBS CSI Driver Role
########################################################

module "iam_assumable_role_with_oidc_ebs_csi_driver" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "~> 3.0"

  create_role = true

  role_name = "ebs-csi-driver-role-${var.environment}"

  tags = {
    Role = "ebs-csi-driver-role-${var.environment}"
  }

  provider_url = replace(aws_iam_openid_connect_provider.eks.url, "https://", "")

  role_policy_arns = [
    data.aws_iam_policy.ebs_csi_driver_policy.arn
  ]
  number_of_role_policy_arns = 1

  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:ebs-csi-controller-sa"]
}

########################################################
# IAM Role - EFS CSI Driver Role
########################################################

module "iam_assumable_role_with_oidc_efs_csi_driver" {
  source  = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version = "~> 3.0"

  create_role = true

  role_name = "efs-csi-driver-role-${var.environment}"

  tags = {
    Role = "efs-csi-driver-role-${var.environment}"
  }

  provider_url = replace(aws_iam_openid_connect_provider.eks.url, "https://", "")

  role_policy_arns = [
    data.aws_iam_policy.efs_csi_driver_policy.arn
  ]
  number_of_role_policy_arns = 1

  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:efs-csi-controller-sa"]
}


########################################################
# IAM Role - RDS Monitoring Role
########################################################

# resource "aws_iam_role" "rds_monitoring_role" {
#   name                  = "rdsMonitoringRole"
#   description           = "Allows access to RDS service resources that are required to fetch logs and metrics by CloudWatch."
#   path                  = "/"
#   assume_role_policy    = file("${path.module}/eks_roles/roles/rds_monitoring_role.json")
#   force_detach_policies = false
#   managed_policy_arns   = [data.aws_iam_policy.rds_monitoring_policy.arn]
# }
