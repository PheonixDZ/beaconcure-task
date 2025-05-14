# ecr

<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.terrascope_app_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | Specifies whether image tags can be overwritten. Options: MUTABLE or IMMUTABLE. | `string` | `"MUTABLE"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the ECR repository. | `string` | n/a | yes |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Determines if images should be scanned on push. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the repository. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The URL of the created ECR repository. |
<!-- END_TF_DOCS -->
<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_ecr_repository.terrascope_app_ecr](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_image_tag_mutability"></a> [image\_tag\_mutability](#input\_image\_tag\_mutability) | Specifies whether image tags can be overwritten. Options: MUTABLE or IMMUTABLE. | `string` | `"MUTABLE"` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the ECR repository. | `string` | n/a | yes |
| <a name="input_scan_on_push"></a> [scan\_on\_push](#input\_scan\_on\_push) | Determines if images should be scanned on push. | `bool` | `true` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to assign to the repository. | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_repository_url"></a> [repository\_url](#output\_repository\_url) | The URL of the created ECR repository. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
