variable "name" {
  type        = string
  description = "The name of the ECR repository."
}

variable "project" {
  type        = string
  description = "Name of the project"
  default     = "image-processing-app"
}

variable "environment" {
  type        = string
  description = "Environment name (e.g., staging, production)"
  default     = "staging"
}

variable "image_tag_mutability" {
  type        = string
  default     = "MUTABLE"
  description = "Specifies whether image tags can be overwritten. Options: MUTABLE or IMMUTABLE."
}

variable "scan_on_push" {
  type        = bool
  default     = true
  description = "Determines if images should be scanned on push."
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "A map of tags to assign to the repository."
}
