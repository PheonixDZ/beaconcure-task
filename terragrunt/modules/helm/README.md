# helm

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.9.0/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | The Helm chart name. | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of the Helm chart. | `string` | `"1.4.3"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create the namespace if it does not exist. | `bool` | `true` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_list_set"></a> [list\_set](#input\_list\_set) | n/a | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_load_balancer_controller_role_arn"></a> [load\_balancer\_controller\_role\_arn](#input\_load\_balancer\_controller\_role\_arn) | The ARN of the IAM role associated with the AWS Load Balancer Controller. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace to install the release into. | `string` | `"kube-system"` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | The Helm release name. | `string` | `"aws-load-balancer-controller-new"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The Helm repository URL. | `string` | `"https://aws.github.io/eks-charts"` | no |
| <a name="input_service_account_create"></a> [service\_account\_create](#input\_service\_account\_create) | Set whether to create the service account. | `bool` | `true` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account to use. | `string` | `"aws-load-balancer-controller"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | 2.9.0 |
| <a name="requirement_kubectl"></a> [kubectl](#requirement\_kubectl) | 1.14.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | 2.19.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | 2.9.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.this](https://registry.terraform.io/providers/hashicorp/helm/2.9.0/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_chart"></a> [chart](#input\_chart) | The Helm chart name. | `string` | `"aws-load-balancer-controller"` | no |
| <a name="input_chart_version"></a> [chart\_version](#input\_chart\_version) | The version of the Helm chart. | `string` | `"1.4.3"` | no |
| <a name="input_create_namespace"></a> [create\_namespace](#input\_create\_namespace) | Whether to create the namespace if it does not exist. | `bool` | `true` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | The name of the EKS cluster. | `string` | n/a | yes |
| <a name="input_list_set"></a> [list\_set](#input\_list\_set) | n/a | <pre>list(object({<br/>    name  = string<br/>    value = string<br/>  }))</pre> | n/a | yes |
| <a name="input_load_balancer_controller_role_arn"></a> [load\_balancer\_controller\_role\_arn](#input\_load\_balancer\_controller\_role\_arn) | The ARN of the IAM role associated with the AWS Load Balancer Controller. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The Kubernetes namespace to install the release into. | `string` | `"kube-system"` | no |
| <a name="input_release_name"></a> [release\_name](#input\_release\_name) | The Helm release name. | `string` | `"aws-load-balancer-controller-new"` | no |
| <a name="input_repository"></a> [repository](#input\_repository) | The Helm repository URL. | `string` | `"https://aws.github.io/eks-charts"` | no |
| <a name="input_service_account_create"></a> [service\_account\_create](#input\_service\_account\_create) | Set whether to create the service account. | `bool` | `true` | no |
| <a name="input_service_account_name"></a> [service\_account\_name](#input\_service\_account\_name) | The name of the service account to use. | `string` | `"aws-load-balancer-controller"` | no |

## Outputs

No outputs.
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
