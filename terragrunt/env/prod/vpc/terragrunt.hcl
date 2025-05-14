include "remote_state" {
  path = find_in_parent_folders("backend.hcl")
}

include "provider" {
  path = find_in_parent_folders("provider.hcl")
}

terraform {
  source = "../../../modules//vpc"
}

locals {
  common_vars = yamldecode(file("${find_in_parent_folders("common-vars.yml")}"))
}

inputs = {
  # Common Variables
  region      = local.common_vars.region
  project     = local.common_vars.project
  environment = local.common_vars.environment

  # VPC Configuration
  vpc_cidr = "10.2.0.0/16" # Production VPC CIDR
  vpc_name = "image-processing-${local.common_vars.environment}-vpc"

  # Subnet Configuration
  public_subnet_name = "image-processing-${local.common_vars.environment}-public"
  public_subnet_cidr = ["10.2.0.0/20", "10.2.16.0/20"]

  private_subnet_name = "image-processing-${local.common_vars.environment}-private"
  private_subnet_cidr = ["10.2.32.0/20", "10.2.48.0/20"]

  availability_zones = ["us-west-2a", "us-west-2b"]

  # Gateway Configuration
  elasticip_name        = "image-processing-${local.common_vars.environment}-eip"
  internet_gateway_name = "image-processing-${local.common_vars.environment}-igw"
  nat_gateway_name      = "image-processing-${local.common_vars.environment}-nat"

  # Route Table Configuration
  public_route_table_name  = "image-processing-${local.common_vars.environment}-public-rt"
  private_route_table_name = "image-processing-${local.common_vars.environment}-private-rt"

  # Tags
  tags = {
    Environment = local.common_vars.environment
    Project     = "image-processing-app"
    ManagedBy   = "terragrunt"
  }
}
