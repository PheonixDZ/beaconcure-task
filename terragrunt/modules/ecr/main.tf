##########################################################################
# ECR, Required for pushing docker image, and get it into cluster
##########################################################################

resource "aws_ecr_repository" "terrascope_app_ecr" {
  name                 = var.name
  image_tag_mutability = var.image_tag_mutability
  tags                 = var.tags

  image_scanning_configuration {
    scan_on_push = var.scan_on_push
  }
}
