output "repository_url" {
  value       = aws_ecr_repository.terrascope_app_ecr.repository_url
  description = "The URL of the created ECR repository."
}
