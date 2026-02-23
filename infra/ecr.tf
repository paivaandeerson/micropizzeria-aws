resource "aws_ecr_repository" "api_repo" {
  name = "micropizzeria-app"
  image_tag_mutability = "MUTABLE" # allows to overwrite an image using the same tag
  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.api_repo.repository_url
}