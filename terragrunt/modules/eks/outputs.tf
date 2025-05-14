output "aws_eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.id
}

output "eks_cluster_role" {
  value = aws_iam_role.eks_cluster_role.arn
}

output "eks_node_role" {
  value = aws_iam_role.eks_node_role.arn
}

# output "rds_monitoring_role" {
#   value = aws_iam_role.rds_monitoring_role.arn
# }

# output "rds_service_role" {
#   value = data.aws_iam_role.rds_service_role.arn
# }
