# data "aws_eks_cluster" "eks_cluster" {
#   depends_on = [
#     module.eks
#   ]
#   name = module.eks.aws_eks_cluster_name
# }

# data "aws_eks_cluster_auth" "eks_cluster" {
#   name = module.eks.aws_eks_cluster_name
# }
