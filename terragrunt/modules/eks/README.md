# eks

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.58 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.addon](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.load_balancer_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_csi_driver_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_node_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.load_balancer_controller_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_security_group.eks_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.eks_egress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_ingress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.EC2ACCESS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.EKS_CSI_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.csi_operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ec2_container_registry_read_only_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.load_balancer_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT` | `string` | `"ON_DEMAND"` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | <pre>[<br/>  "api",<br/>  "audit",<br/>  "authenticator",<br/>  "controllerManager",<br/>  "scheduler"<br/>]</pre> | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | `false` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_cluster_service_ipv4_cidr"></a> [cluster\_service\_ipv4\_cidr](#input\_cluster\_service\_ipv4\_cidr) | The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks | `string` | `"192.168.0.0/16"` | no |
| <a name="input_eks_addon_name"></a> [eks\_addon\_name](#input\_eks\_addon\_name) | Name of EKS Cluster Add ON. | `list(string)` | <pre>[<br/>  "vpc-cni",<br/>  "coredns",<br/>  "kube-proxy"<br/>]</pre> | no |
| <a name="input_eks_addon_version"></a> [eks\_addon\_version](#input\_eks\_addon\_version) | Versions of EKS Cluster Add ON. | `list(string)` | `null` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the EKS cluster | `string` | `"eks-cluster"` | no |
| <a name="input_eks_cluster_role"></a> [eks\_cluster\_role](#input\_eks\_cluster\_role) | Existing IAM role ARN for the cluster. | `string` | `null` | no |
| <a name="input_eks_cluster_tag_name"></a> [eks\_cluster\_tag\_name](#input\_eks\_cluster\_tag\_name) | Tag of EKS Cluster. | `string` | `"eks-cluster-west1"` | no |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | Kubernetes version to use for the EKS cluster (i.e.: `1.24`) | `string` | `"1.30"` | no |
| <a name="input_eks_egress_cidr_blocks"></a> [eks\_egress\_cidr\_blocks](#input\_eks\_egress\_cidr\_blocks) | Egress CIDR Blocks of security group for EKS. | `list(any)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_eks_egress_rules"></a> [eks\_egress\_rules](#input\_eks\_egress\_rules) | Egress rules of security group for EKS. | `list(any)` | <pre>[<br/>  443<br/>]</pre> | no |
| <a name="input_eks_egress_rules_from_port"></a> [eks\_egress\_rules\_from\_port](#input\_eks\_egress\_rules\_from\_port) | Egress rules from port of security group for EKS. | `list(any)` | <pre>[<br/>  443<br/>]</pre> | no |
| <a name="input_eks_egress_rules_protocols"></a> [eks\_egress\_rules\_protocols](#input\_eks\_egress\_rules\_protocols) | Egress rules protocols of security group for EKS. | `list(any)` | <pre>[<br/>  "tcp"<br/>]</pre> | no |
| <a name="input_eks_egress_rules_to_port"></a> [eks\_egress\_rules\_to\_port](#input\_eks\_egress\_rules\_to\_port) | Egress rules to port of security group for EKS. | `list(any)` | <pre>[<br/>  443<br/>]</pre> | no |
| <a name="input_eks_ingress_cidr_blocks"></a> [eks\_ingress\_cidr\_blocks](#input\_eks\_ingress\_cidr\_blocks) | Ingress CIDR Blocks of security group for EKS. | `list(any)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_eks_ingress_rules"></a> [eks\_ingress\_rules](#input\_eks\_ingress\_rules) | Ingress rules of security group for EKS. | `list(any)` | <pre>[<br/>  22,<br/>  80,<br/>  443,<br/>  6443<br/>]</pre> | no |
| <a name="input_eks_ingress_rules_from_port"></a> [eks\_ingress\_rules\_from\_port](#input\_eks\_ingress\_rules\_from\_port) | Ingress rules from port of security group for EKS. | `list(any)` | <pre>[<br/>  22,<br/>  80,<br/>  443<br/>]</pre> | no |
| <a name="input_eks_ingress_rules_protocols"></a> [eks\_ingress\_rules\_protocols](#input\_eks\_ingress\_rules\_protocols) | Ingress rules protocols of security group for EKS. | `list(any)` | <pre>[<br/>  "tcp",<br/>  "tcp",<br/>  "tcp"<br/>]</pre> | no |
| <a name="input_eks_ingress_rules_to_port"></a> [eks\_ingress\_rules\_to\_port](#input\_eks\_ingress\_rules\_to\_port) | Ingress rules to port of security group for EKS. | `list(any)` | <pre>[<br/>  22,<br/>  80,<br/>  443<br/>]</pre> | no |
| <a name="input_eks_node_group_ami_type"></a> [eks\_node\_group\_ami\_type](#input\_eks\_node\_group\_ami\_type) | Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values are `AL2_x86_64`, `AL2_x86_64_GPU`, `AL2_ARM_64`, `CUSTOM`, `BOTTLEROCKET_ARM_64`, `BOTTLEROCKET_x86_64` | `string` | `"AL2_x86_64"` | no |
| <a name="input_eks_node_group_desired_size"></a> [eks\_node\_group\_desired\_size](#input\_eks\_node\_group\_desired\_size) | Desired number of instances/nodes | `number` | `2` | no |
| <a name="input_eks_node_group_disk_size"></a> [eks\_node\_group\_disk\_size](#input\_eks\_node\_group\_disk\_size) | Disk size in GiB for nodes. Defaults to `20`. Only valid when `use_custom_launch_template` = `false` | `number` | `30` | no |
| <a name="input_eks_node_group_instance_types"></a> [eks\_node\_group\_instance\_types](#input\_eks\_node\_group\_instance\_types) | Set of instance types associated with the EKS Node Group. Defaults to `["t3.medium"]` | `list(string)` | <pre>[<br/>  "t3.medium"<br/>]</pre> | no |
| <a name="input_eks_node_group_max_size"></a> [eks\_node\_group\_max\_size](#input\_eks\_node\_group\_max\_size) | Maximum number of instances/nodes | `number` | `3` | no |
| <a name="input_eks_node_group_min_size"></a> [eks\_node\_group\_min\_size](#input\_eks\_node\_group\_min\_size) | Minimum number of instances/nodes | `number` | `2` | no |
| <a name="input_eks_node_group_tag_name"></a> [eks\_node\_group\_tag\_name](#input\_eks\_node\_group\_tag\_name) | Tag of EKS Cluster Node Group. | `string` | `"node-group-west1"` | no |
| <a name="input_eks_node_role"></a> [eks\_node\_role](#input\_eks\_node\_role) | Existing IAM role ARN for the node group. | `string` | `null` | no |
| <a name="input_eks_security_group_name"></a> [eks\_security\_group\_name](#input\_eks\_security\_group\_name) | Name to use on cluster security group created | `string` | `"eks security group west1"` | no |
| <a name="input_eks_security_group_tag_name"></a> [eks\_security\_group\_tag\_name](#input\_eks\_security\_group\_tag\_name) | Tag of EKS Cluster Security group. | `string` | `"eks test security group"` | no |
| <a name="input_node_group_label"></a> [node\_group\_label](#input\_node\_group\_label) | Label for the node group | `string` | `"image-processing-node"` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | Name of the EKS managed node group | `string` | `"node-group-west1"` | no |
| <a name="input_region"></a> [region](#input\_region) | Name of the Region. | `string` | `"us-west-1"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | A list of subnet IDs where the nodes/node groups will be provisioned. If `control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster security group will be provisioned | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_eks_cluster_name"></a> [aws\_eks\_cluster\_name](#output\_aws\_eks\_cluster\_name) | n/a |
| <a name="output_eks_cluster_role"></a> [eks\_cluster\_role](#output\_eks\_cluster\_role) | n/a |
| <a name="output_eks_node_role"></a> [eks\_node\_role](#output\_eks\_node\_role) | n/a |
| <a name="output_load_balancer_controller_role_arn"></a> [load\_balancer\_controller\_role\_arn](#output\_load\_balancer\_controller\_role\_arn) | n/a |
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~> 4.58 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~> 4.58 |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eks_addon.addon](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_addon) | resource |
| [aws_eks_cluster.eks_cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster) | resource |
| [aws_eks_node_group.node_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) | resource |
| [aws_iam_openid_connect_provider.eks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_openid_connect_provider) | resource |
| [aws_iam_policy.load_balancer_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_policy) | resource |
| [aws_iam_role.eks_cluster_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_csi_driver_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.eks_node_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role.load_balancer_controller_role](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_security_group.eks_security_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.eks_egress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.eks_ingress_rules](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |
| [aws_iam_policy.EC2ACCESS](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.EKS_CSI_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.csi_operator](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.ec2_container_registry_read_only_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_cluster_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_cni](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_cni_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.eks_worker_node_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [aws_iam_policy.load_balancer_controller_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy) | data source |
| [tls_certificate.eks](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/data-sources/certificate) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_capacity_type"></a> [capacity\_type](#input\_capacity\_type) | Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT` | `string` | `"ON_DEMAND"` | no |
| <a name="input_cluster_enabled_log_types"></a> [cluster\_enabled\_log\_types](#input\_cluster\_enabled\_log\_types) | A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html) | `list(string)` | <pre>[<br/>  "api",<br/>  "audit",<br/>  "authenticator",<br/>  "controllerManager",<br/>  "scheduler"<br/>]</pre> | no |
| <a name="input_cluster_endpoint_private_access"></a> [cluster\_endpoint\_private\_access](#input\_cluster\_endpoint\_private\_access) | Indicates whether or not the Amazon EKS private API server endpoint is enabled | `bool` | `false` | no |
| <a name="input_cluster_endpoint_public_access"></a> [cluster\_endpoint\_public\_access](#input\_cluster\_endpoint\_public\_access) | Indicates whether or not the Amazon EKS public API server endpoint is enabled | `bool` | `true` | no |
| <a name="input_cluster_endpoint_public_access_cidrs"></a> [cluster\_endpoint\_public\_access\_cidrs](#input\_cluster\_endpoint\_public\_access\_cidrs) | List of CIDR blocks which can access the Amazon EKS public API server endpoint | `list(string)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_cluster_service_ipv4_cidr"></a> [cluster\_service\_ipv4\_cidr](#input\_cluster\_service\_ipv4\_cidr) | The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks | `string` | `"192.168.0.0/16"` | no |
| <a name="input_eks_addon_name"></a> [eks\_addon\_name](#input\_eks\_addon\_name) | Name of EKS Cluster Add ON. | `list(string)` | <pre>[<br/>  "vpc-cni",<br/>  "coredns",<br/>  "kube-proxy"<br/>]</pre> | no |
| <a name="input_eks_addon_version"></a> [eks\_addon\_version](#input\_eks\_addon\_version) | Versions of EKS Cluster Add ON. | `list(string)` | `null` | no |
| <a name="input_eks_cluster_name"></a> [eks\_cluster\_name](#input\_eks\_cluster\_name) | Name of the EKS cluster | `string` | `"eks-cluster"` | no |
| <a name="input_eks_cluster_role"></a> [eks\_cluster\_role](#input\_eks\_cluster\_role) | Existing IAM role ARN for the cluster. | `string` | `null` | no |
| <a name="input_eks_cluster_tag_name"></a> [eks\_cluster\_tag\_name](#input\_eks\_cluster\_tag\_name) | Tag of EKS Cluster. | `string` | `"eks-cluster-west1"` | no |
| <a name="input_eks_cluster_version"></a> [eks\_cluster\_version](#input\_eks\_cluster\_version) | Kubernetes version to use for the EKS cluster (i.e.: `1.24`) | `string` | `"1.30"` | no |
| <a name="input_eks_egress_cidr_blocks"></a> [eks\_egress\_cidr\_blocks](#input\_eks\_egress\_cidr\_blocks) | Egress CIDR Blocks of security group for EKS. | `list(any)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_eks_egress_rules"></a> [eks\_egress\_rules](#input\_eks\_egress\_rules) | Egress rules of security group for EKS. | `list(any)` | <pre>[<br/>  443<br/>]</pre> | no |
| <a name="input_eks_egress_rules_from_port"></a> [eks\_egress\_rules\_from\_port](#input\_eks\_egress\_rules\_from\_port) | Egress rules from port of security group for EKS. | `list(any)` | <pre>[<br/>  443<br/>]</pre> | no |
| <a name="input_eks_egress_rules_protocols"></a> [eks\_egress\_rules\_protocols](#input\_eks\_egress\_rules\_protocols) | Egress rules protocols of security group for EKS. | `list(any)` | <pre>[<br/>  "tcp"<br/>]</pre> | no |
| <a name="input_eks_egress_rules_to_port"></a> [eks\_egress\_rules\_to\_port](#input\_eks\_egress\_rules\_to\_port) | Egress rules to port of security group for EKS. | `list(any)` | <pre>[<br/>  443<br/>]</pre> | no |
| <a name="input_eks_ingress_cidr_blocks"></a> [eks\_ingress\_cidr\_blocks](#input\_eks\_ingress\_cidr\_blocks) | Ingress CIDR Blocks of security group for EKS. | `list(any)` | <pre>[<br/>  "0.0.0.0/0"<br/>]</pre> | no |
| <a name="input_eks_ingress_rules"></a> [eks\_ingress\_rules](#input\_eks\_ingress\_rules) | Ingress rules of security group for EKS. | `list(any)` | <pre>[<br/>  22,<br/>  80,<br/>  443,<br/>  6443<br/>]</pre> | no |
| <a name="input_eks_ingress_rules_from_port"></a> [eks\_ingress\_rules\_from\_port](#input\_eks\_ingress\_rules\_from\_port) | Ingress rules from port of security group for EKS. | `list(any)` | <pre>[<br/>  22,<br/>  80,<br/>  443<br/>]</pre> | no |
| <a name="input_eks_ingress_rules_protocols"></a> [eks\_ingress\_rules\_protocols](#input\_eks\_ingress\_rules\_protocols) | Ingress rules protocols of security group for EKS. | `list(any)` | <pre>[<br/>  "tcp",<br/>  "tcp",<br/>  "tcp"<br/>]</pre> | no |
| <a name="input_eks_ingress_rules_to_port"></a> [eks\_ingress\_rules\_to\_port](#input\_eks\_ingress\_rules\_to\_port) | Ingress rules to port of security group for EKS. | `list(any)` | <pre>[<br/>  22,<br/>  80,<br/>  443<br/>]</pre> | no |
| <a name="input_eks_node_group_ami_type"></a> [eks\_node\_group\_ami\_type](#input\_eks\_node\_group\_ami\_type) | Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values are `AL2_x86_64`, `AL2_x86_64_GPU`, `AL2_ARM_64`, `CUSTOM`, `BOTTLEROCKET_ARM_64`, `BOTTLEROCKET_x86_64` | `string` | `"AL2_x86_64"` | no |
| <a name="input_eks_node_group_desired_size"></a> [eks\_node\_group\_desired\_size](#input\_eks\_node\_group\_desired\_size) | Desired number of instances/nodes | `number` | `2` | no |
| <a name="input_eks_node_group_disk_size"></a> [eks\_node\_group\_disk\_size](#input\_eks\_node\_group\_disk\_size) | Disk size in GiB for nodes. Defaults to `20`. Only valid when `use_custom_launch_template` = `false` | `number` | `30` | no |
| <a name="input_eks_node_group_instance_types"></a> [eks\_node\_group\_instance\_types](#input\_eks\_node\_group\_instance\_types) | Set of instance types associated with the EKS Node Group. Defaults to `["t3.medium"]` | `list(string)` | <pre>[<br/>  "t3.medium"<br/>]</pre> | no |
| <a name="input_eks_node_group_max_size"></a> [eks\_node\_group\_max\_size](#input\_eks\_node\_group\_max\_size) | Maximum number of instances/nodes | `number` | `3` | no |
| <a name="input_eks_node_group_min_size"></a> [eks\_node\_group\_min\_size](#input\_eks\_node\_group\_min\_size) | Minimum number of instances/nodes | `number` | `2` | no |
| <a name="input_eks_node_group_tag_name"></a> [eks\_node\_group\_tag\_name](#input\_eks\_node\_group\_tag\_name) | Tag of EKS Cluster Node Group. | `string` | `"node-group-west1"` | no |
| <a name="input_eks_node_role"></a> [eks\_node\_role](#input\_eks\_node\_role) | Existing IAM role ARN for the node group. | `string` | `null` | no |
| <a name="input_eks_security_group_name"></a> [eks\_security\_group\_name](#input\_eks\_security\_group\_name) | Name to use on cluster security group created | `string` | `"eks security group west1"` | no |
| <a name="input_eks_security_group_tag_name"></a> [eks\_security\_group\_tag\_name](#input\_eks\_security\_group\_tag\_name) | Tag of EKS Cluster Security group. | `string` | `"eks test security group"` | no |
| <a name="input_node_group_label"></a> [node\_group\_label](#input\_node\_group\_label) | Label for the node group | `string` | `"image-processing-node"` | no |
| <a name="input_node_group_name"></a> [node\_group\_name](#input\_node\_group\_name) | Name of the EKS managed node group | `string` | `"node-group-west1"` | no |
| <a name="input_region"></a> [region](#input\_region) | Name of the Region. | `string` | `"us-west-1"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | A list of subnet IDs where the nodes/node groups will be provisioned. If `control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets | `list(string)` | `[]` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | ID of the VPC where the cluster security group will be provisioned | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_aws_eks_cluster_name"></a> [aws\_eks\_cluster\_name](#output\_aws\_eks\_cluster\_name) | n/a |
| <a name="output_eks_cluster_role"></a> [eks\_cluster\_role](#output\_eks\_cluster\_role) | n/a |
| <a name="output_eks_node_role"></a> [eks\_node\_role](#output\_eks\_node\_role) | n/a |
| <a name="output_load_balancer_controller_role_arn"></a> [load\_balancer\_controller\_role\_arn](#output\_load\_balancer\_controller\_role\_arn) | n/a |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
