########################################################
# Terraform Variables - Helm Deployment
########################################################

variable "project" {
  description = "Name of the project"
  type        = string
  default     = "image-processing-app"
}

variable "environment" {
  description = "Environment name (e.g., staging, production)"
  type        = string
  default     = "staging"
}

# # The name of the EKS cluster where the Helm chart will be deployed
# variable "eks_cluster_name" {
#   description = "The name of the EKS cluster."
#   type        = string
# }

########################################################
# Helm Chart Configuration
########################################################

# Name of the Helm release
variable "release_name" {
  description = "The Helm release name."
  type        = string
  default     = "aws-load-balancer-controller-new"
}

# Helm chart name
variable "chart" {
  description = "The Helm chart name."
  type        = string
  default     = "aws-load-balancer-controller"
}

# Helm chart version
variable "chart_version" {
  description = "The version of the Helm chart."
  type        = string
  default     = "1.4.3"
}

# Repository URL for the Helm chart
variable "repository" {
  description = "The Helm repository URL."
  type        = string
  default     = "https://aws.github.io/eks-charts"
}

########################################################
# Kubernetes Namespace Configuration
########################################################

# Whether to create the namespace if it does not exist
variable "create_namespace" {
  description = "Whether to create the namespace if it does not exist."
  type        = bool
  default     = true
}

# The Kubernetes namespace where the release will be installed
variable "namespace" {
  description = "The Kubernetes namespace to install the release into."
  type        = string
  default     = "kube-system"
}

########################################################
# Kubernetes Service Account Configuration
########################################################

# Set whether to create the service account
variable "service_account_create" {
  description = "Set whether to create the service account."
  type        = bool
  default     = true
}

# Name of the service account to use
variable "service_account_name" {
  description = "The name of the service account to use."
  type        = string
  default     = "aws-load-balancer-controller"
}

########################################################
# IAM Role for AWS Load Balancer Controller
########################################################

# ARN of the IAM role associated with the AWS Load Balancer Controller service account
# variable "load_balancer_controller_role_arn" {
#   description = "The ARN of the IAM role associated with the AWS Load Balancer Controller."
#   type        = string
# }

variable "list_set" {
  type = list(object({
    name  = string
    value = string
  }))
}

variable "eks_cluster_name" {
  type = string
}
