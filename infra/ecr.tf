resource "aws_ecr_repository" "api_repo" {
  name                 = "micropizzeria-app"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  tags = var.common_tags
}

output "ecr_repository_url" {
  value = aws_ecr_repository.api_repo.repository_url
}