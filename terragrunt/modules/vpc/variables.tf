########################################################
# Project Configuration
########################################################

variable "project" {
  description = "Name of the project."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., prod, staging)."
  type        = string
}

########################################################
# VPC Configuration
########################################################

# The IPv4 CIDR block for the VPC
variable "vpc_cidr" {
  description = "The IPv4 CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

# Name of the VPC
variable "vpc_name" {
  description = "Name of the VPC."
  type        = string
  default     = "production-vpc"
}

########################################################
# Subnet Configuration
########################################################

# Name of the public subnets
variable "public_subnet_name" {
  description = "Name of the public subnets."
  type        = string
  default     = "production-subnet-public"
}

# CIDR blocks for the public subnets
variable "public_subnet_cidr" {
  description = "CIDR of the public subnets."
  type        = list(string)
  default     = ["10.0.0.0/20", "10.0.16.0/20"]
}

# Name of the private subnets
variable "private_subnet_name" {
  description = "Name of the private subnets."
  type        = string
  default     = "production-subnet-private"
}

# CIDR blocks for the private subnets
variable "private_subnet_cidr" {
  description = "CIDR of the private subnets."
  type        = list(string)
  default     = ["10.0.32.0/20", "10.0.48.0/20"]
}

# Availability zones for subnets
variable "availability_zones" {
  description = "A list of availability zone names in the region."
  type        = list(string)
  default     = ["us-west-1a", "us-west-1c"]
}

########################################################
# Network Components
########################################################

# Name of the Elastic IP
variable "elasticip_name" {
  description = "Name of the Elastic IP."
  type        = string
  default     = "eip-west1"
}

# Name of the Internet Gateway
variable "internet_gateway_name" {
  description = "Name of the Internet Gateway."
  type        = string
  default     = "igw-west1"
}

# Name of the NAT Gateway
variable "nat_gateway_name" {
  description = "Name of the NAT Gateway."
  type        = string
  default     = "nat-west1"
}

########################################################
# Route Table Configuration
########################################################

# Name of the public route table
variable "public_route_table_name" {
  description = "Name of the public route table."
  type        = string
  default     = "route-table-public-west1"
}

# Name of the private route table
variable "private_route_table_name" {
  description = "Name of the private route table."
  type        = string
  default     = "route-table-private-west1"
}

########################################################
# Region Configuration
########################################################

# AWS region for resource deployment
variable "region" {
  description = "AWS region where the resources will be deployed."
  type        = string
  default     = "us-west-1"
}
