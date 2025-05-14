# Terragrunt Configuration

This directory contains the Terragrunt configuration for managing the Image Processing infrastructure across different environments.

## Structure

```
terragrunt/
├── env/                    # Environment configurations
│   ├── staging/           # Staging environment
│   ├── prod/              # Production environment
│   ├── backend.hcl        # Backend configuration
│   ├── provider.hcl       # Provider configuration
│   └── global.hcl         # Global variables
└── modules/               # Reusable Terraform modules
    ├── vpc/              # VPC module
    ├── eks/              # EKS module
    ├── ecr/              # ECR module
    ├── helm/             # Helm module
    └── data-source/      # Data source modules
```

## Prerequisites

- Terraform >= 1.0.0
- Terragrunt >= 0.36.0
- AWS CLI configured with appropriate credentials
- kubectl
- helm

## Environment Setup

### Staging Environment
```bash
# Initialize and plan
cd env/staging
terragrunt run-all init
terragrunt run-all plan

# Apply all modules
terragrunt run-all apply

# Apply specific module
terragrunt apply -target=module.vpc
terragrunt apply -target=module.eks
terragrunt apply -target=module.ecr
terragrunt apply -target=module.helm

# Destroy
terragrunt run-all destroy
```

### Production Environment
```bash
# Initialize and plan
cd env/prod
terragrunt run-all init
terragrunt run-all plan

# Apply all modules
terragrunt run-all apply

# Apply specific module
terragrunt apply -target=module.vpc
terragrunt apply -target=module.eks
terragrunt apply -target=module.ecr
terragrunt apply -target=module.helm

# Destroy
terragrunt run-all destroy
```

## Configuration

### Environment Variables
Set these before running Terragrunt:
```bash
export AWS_PROFILE="your-aws-profile"
export TF_VAR_environment="staging"  # or "prod"
```

### Key Variables
Configure in respective environment's `terragrunt.hcl`:
- `project`: Project name
- `environment`: Environment name
- `region`: AWS region
- `vpc_cidr`: VPC CIDR block
- `eks_cluster_name`: EKS cluster name

## Security

- IAM roles follow least privilege principle
- Network access is restricted via security groups
- EKS cluster endpoints can be private

## Troubleshooting

1. **Permission Errors**
   - Verify AWS credentials
   - Check IAM roles and policies

2. **Resource Conflicts**
   - Check for existing resources
   - Verify naming conventions

3. **Helm Chart Issues**
   - Verify chart versions
   - Check dependencies

## Maintenance

### Adding New Environments
1. Copy an existing environment directory from `env/`
2. Update variables in `terragrunt.hcl`
3. Update backend configuration if needed

### Updating Modules
1. Update module code in `modules/`
2. Run `terragrunt run-all init -upgrade`
3. Apply changes with `terragrunt run-all apply`

### Common Commands

```bash
# Show all modules
terragrunt run-all graph

# Show plan for specific module
terragrunt plan -target=module.vpc

# Show state
terragrunt state list

# Import existing resource
terragrunt import aws_vpc.main vpc-12345678

# Output values
terragrunt output
```
