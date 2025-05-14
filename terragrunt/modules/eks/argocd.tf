# resource "kubectl_manifest" "argocd" {
#   yaml_body = templatefile("${path.module}/files/argocd.tmpl", {
#     name      = "image-processing"
#     namespace = "argocd"
#   })
#   depends_on = [
#     aws_eks_cluster.eks_cluster
#   ]
# }
