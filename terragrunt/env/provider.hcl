locals {
  parent = "${get_terragrunt_dir()}/../"
  name   = basename(dirname(local.parent))
  region = (local.name) == "prod" ? "us-west-2" : "eu-west-2"
}

generate "provider" {
  path      = "provider.tf"
  if_exists = "overwrite_terragrunt"
  contents  = <<EOF
provider "aws" {
  region = "${local.region}"
}
EOF
}
