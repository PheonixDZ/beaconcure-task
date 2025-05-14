resource "helm_release" "aws_load_balancer_controller" {
  name = "aws-load-balancer-controller-${var.environment}"

  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"
  version    = "1.4.2"
  namespace  = "kube-system"

  set {
    name  = "clusterName"
    value = aws_eks_cluster.eks_cluster.name
  }
  set {
    name  = "namespace"
    value = "kube-system"
  }
  set {
    name  = "serviceAccount.create"
    value = true
  }
  set {
    name  = "serviceAccount.name"
    value = "${var.project}-aws-load-balancer-controller-${var.environment}"
  }
  set {
    name  = "attach-policy-arn"
    value = aws_iam_policy.aws_load_balancer_controller.arn
  }
  set {
    name  = "image.tag"
    value = var.image_tag_version
  }
  set {
    name  = "serviceAccount.annotations.eks\\.amazonaws\\.com/role-arn"
    value = module.iam_assumable_role_with_oidc_aws_loadbalancer_controller.this_iam_role_arn
  }

  set {
    name  = "image.repository"
    value = var.aws_load_balancer_controller_ecr_image
  }

  depends_on = [module.iam_assumable_role_with_oidc_aws_loadbalancer_controller]
}

module "iam_assumable_role_with_oidc_aws_loadbalancer_controller" {
  source      = "terraform-aws-modules/iam/aws//modules/iam-assumable-role-with-oidc"
  version     = "~> 3.0"
  create_role = true

  role_name = "${var.project}-aws-load-balancer-controller-${var.environment}"

  tags = {
    "alpha.eksctl.io/cluster-name"                = "${aws_eks_cluster.eks_cluster.name}"
    "alpha.eksctl.io/eksctl-version"              = "0.104.0"
    "alpha.eksctl.io/iamserviceaccount-name"      = "kube-system/${var.project}-aws-load-balancer-controller-${var.environment}"
    "eksctl.cluster.k8s.io/v1alpha1/cluster-name" = "${aws_eks_cluster.eks_cluster.name}"
  }

  provider_url = replace(aws_iam_openid_connect_provider.eks.url, "https://", "")

  role_policy_arns = [
    aws_iam_policy.aws_load_balancer_controller.arn,
  ]
  number_of_role_policy_arns = 1

  oidc_fully_qualified_subjects = ["system:serviceaccount:kube-system:${var.project}-aws-load-balancer-controller-${var.environment}"]
}

resource "aws_iam_policy" "aws_load_balancer_controller" {
  name   = "${var.project}-aws-load-balancer-controller-${var.environment}"
  policy = file("${path.module}/iam-policies/AWSLoadBalancerControllerIAMPolicy.json")
}
