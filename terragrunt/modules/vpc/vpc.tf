###########################################################
## DEFAULT VPC
###########################################################
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.58" # Adjust as per your Terraform version
    }
  }
}

resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true
  provider             = aws

  tags = {
    Name = "${var.project}-vpc-${var.environment}"
  }
}
