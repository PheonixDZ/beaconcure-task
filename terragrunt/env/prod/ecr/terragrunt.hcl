include "remote_state" {
  path = find_in_parent_folders("backend.hcl")
}

include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

terraform {
  source = "../../../modules//ecr"
}




locals {
  common_vars = yamldecode(file("${find_in_parent_folders("common-vars.yml")}"))
}

inputs = {
  # Common Variables
  project     = local.common_vars.project
  environment = local.common_vars.environment

  # ECR Configuration
  name                 = "${local.common_vars.project}-${local.common_vars.environment}"
  image_tag_mutability = "IMMUTABLE" # For production, use IMMUTABLE for better control
  scan_on_push         = true

  # Tags
  tags = {
    Environment = local.common_vars.environment
    Project     = local.common_vars.project
    ManagedBy   = "terragrunt"
  }
}
