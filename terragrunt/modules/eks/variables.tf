########################################################
# EKS Cluster Variables
########################################################

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "image-processing-app"
}

variable "region" {
  description = "Name of the Region."
  type        = string
  default     = "us-west-1"
}

variable "eks_cluster_name" {
  description = "Name of the EKS cluster"
  type        = string
  default     = "eks-cluster"
}

variable "eks_cluster_version" {
  description = "Kubernetes version to use for the EKS cluster (i.e.: `1.24`)"
  type        = string
  default     = "1.30"
}

variable "eks_cluster_role" {
  description = "Existing IAM role ARN for the cluster."
  type        = string
  default     = null
}

variable "cluster_service_ipv4_cidr" {
  description = "The CIDR block to assign Kubernetes service IP addresses from. If you don't specify a block, Kubernetes assigns addresses from either the 10.100.0.0/16 or 172.20.0.0/16 CIDR blocks"
  type        = string
  default     = "192.168.0.0/16"
}

variable "cluster_endpoint_private_access" {
  description = "Indicates whether or not the Amazon EKS private API server endpoint is enabled"
  type        = bool
  default     = false
}

variable "cluster_endpoint_public_access" {
  description = "Indicates whether or not the Amazon EKS public API server endpoint is enabled"
  type        = bool
  default     = true
}

variable "cluster_endpoint_public_access_cidrs" {
  description = "List of CIDR blocks which can access the Amazon EKS public API server endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "subnet_id" {
  description = "A list of subnet IDs where the nodes/node groups will be provisioned. If `control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets"
  type        = list(string)
  default     = []
}

variable "cluster_enabled_log_types" {
  description = "A list of the desired control plane logs to enable. For more information, see Amazon EKS Control Plane Logging documentation (https://docs.aws.amazon.com/eks/latest/userguide/control-plane-logs.html)"
  type        = list(string)
  default     = ["api", "audit", "authenticator", "controllerManager", "scheduler"]
}

variable "eks_cluster_tag_name" {
  description = "Tag of EKS Cluster."
  type        = string
  default     = "eks-cluster-west1"
}

########################################################
# EKS Cluster Add ON Variables
########################################################

variable "eks_addon_name" {
  description = "Name of EKS Cluster Add ON."
  type        = list(string)
  default     = ["vpc-cni", "coredns", "kube-proxy", "aws-ebs-csi-driver", "aws-efs-csi-driver"]
}

variable "eks_addon_version" {
  description = "Versions of EKS Cluster Add ON."
  type        = list(string)
  default     = ["v1.19.2-eksbuild.5", "v1.11.4-eksbuild.2", "v1.30.9-eksbuild.3", "v1.41.0-eksbuild.1", "v2.1.7-eksbuild.1"]
}

########################################################
# EKS Cluster Node Group Variables
########################################################

variable "node_group_name" {
  description = "Name of the EKS managed node group"
  type        = string
  default     = "node-group-west1"
}

variable "eks_node_role" {
  description = "Existing IAM role ARN for the node group."
  type        = string
  default     = null
}

variable "capacity_type" {
  description = "Type of capacity associated with the EKS Node Group. Valid values: `ON_DEMAND`, `SPOT`"
  type        = string
  default     = "ON_DEMAND"
}

variable "eks_node_group_ami_type" {
  description = "Type of Amazon Machine Image (AMI) associated with the EKS Node Group. Valid values are `AL2_x86_64`, `AL2_x86_64_GPU`, `AL2_ARM_64`, `CUSTOM`, `BOTTLEROCKET_ARM_64`, `BOTTLEROCKET_x86_64`"
  type        = string
  default     = "AL2_x86_64"
}

variable "eks_node_group_disk_size" {
  description = "Disk size in GiB for nodes. Defaults to `20`. Only valid when `use_custom_launch_template` = `false`"
  type        = number
  default     = 30
}

variable "eks_node_group_instance_types" {
  description = "Set of instance types associated with the EKS Node Group. Defaults to `[\"t3.medium\"]`"
  type        = list(string)
  default     = ["t3.medium"]
}

variable "eks_node_group_tag_name" {
  description = "Tag of EKS Cluster Node Group."
  type        = string
  default     = "node-group-west1"
}

variable "eks_node_group_desired_size" {
  description = "Desired number of instances/nodes"
  type        = number
  default     = 2
}

variable "eks_node_group_min_size" {
  description = "Minimum number of instances/nodes"
  type        = number
  default     = 2
}

variable "eks_node_group_max_size" {
  description = "Maximum number of instances/nodes"
  type        = number
  default     = 3
}

variable "node_group_label" {
  description = "Label for the node group"
  type        = string
  default     = "image-processing-node"
}

########################################################
# EKS Cluster Security Group Variables
########################################################

variable "vpc_id" {
  description = "ID of the VPC where the cluster security group will be provisioned"
  type        = string
  default     = null
}

variable "eks_security_group_name" {
  description = "Name to use on cluster security group created"
  type        = string
  default     = "eks security group west1"
}

variable "eks_security_group_tag_name" {
  description = "Tag of EKS Cluster Security group."
  type        = string
  default     = "eks test security group"
}

variable "eks_ingress_rules" {
  description = "Ingress rules of security group for EKS."
  type        = list(any)
  default     = [22, 80, 443, 6443]
}

variable "eks_ingress_cidr_blocks" {
  description = "Ingress CIDR Blocks of security group for EKS."
  type        = list(any)
  default     = ["106.219.85.123/32"]
}

variable "eks_ingress_rules_from_port" {
  description = "Ingress rules from port of security group for EKS."
  type        = list(any)
  default     = [22, 80, 443, 6443]
}

variable "eks_ingress_rules_to_port" {
  description = "Ingress rules to port of security group for EKS."
  type        = list(any)
  default     = [22, 80, 443, 6443]
}

variable "eks_ingress_rules_protocols" {
  description = "Ingress rules protocols of security group for EKS."
  type        = list(any)
  default     = ["tcp", "tcp", "tcp", "tcp"]
}

variable "eks_egress_rules" {
  description = "Egress rules of security group for EKS."
  type        = list(any)
  default     = [443, 6443]
}

variable "eks_egress_cidr_blocks" {
  description = "Egress CIDR Blocks of security group for EKS."
  type        = list(any)
  default     = ["0.0.0.0/0"]
}

variable "eks_egress_rules_from_port" {
  description = "Egress rules from port of security group for EKS."
  type        = list(any)
  default     = [443, 6443]
}

variable "eks_egress_rules_to_port" {
  description = "Egress rules to port of security group for EKS."
  type        = list(any)
  default     = [443, 6443]
}

variable "eks_egress_rules_protocols" {
  description = "Egress rules protocols of security group for EKS."
  type        = list(any)
  default     = ["tcp", "tcp"]
}

variable "subnet_ids" {
  description = "A list of subnet IDs where the nodes/node groups will be provisioned. If `control_plane_subnet_ids` is not provided, the EKS cluster control plane (ENIs) will be provisioned in these subnets"
  type        = list(string)
  default     = []
}

variable "efs_name" {
  description = "The name of the EFS file system."
  type        = string
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = list(string)
}

variable "efs_security_groups_name" {
  description = "The name of the security group for EFS."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., staging, production)"
  type        = string
  default     = "staging"
}

variable "image_tag_version" {
  type    = string
  default = "v2.4.2"
}

variable "aws_load_balancer_controller_ecr_image" {
  type    = string
  default = "602401143452.dkr.ecr.us-west-2.amazonaws.com/amazon/aws-load-balancer-controller"
}
