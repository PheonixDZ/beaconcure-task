locals {
  parent = "${get_terragrunt_dir()}/../"
  name   = basename(dirname(local.parent))
}

remote_state {
  backend = "s3"
  config = {
    bucket       = "testbucket2025terraform-v7"
    key          = "${local.name}-${basename(get_terragrunt_dir())}/terraform.tfstate"
    region       = "us-west-1"
    encrypt      = true
    use_lockfile = true
  }
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
}
