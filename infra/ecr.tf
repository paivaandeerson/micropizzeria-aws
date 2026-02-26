# The repository resource will be created only if it doesn't exist already. 
data "aws_ecr_repository" "existing" {
  name = "micropizzeria-app"
}

resource "aws_ecr_repository" "api_repo" {
  count = length(try(data.aws_ecr_repository.existing.repository_url, "")) == 0 ? 1 : 0
  name = "micropizzeria-app"
  image_tag_mutability = "MUTABLE" # allows to overwrite an image using the same tag
  force_delete = true
}

output "ecr_repository_url" {
  value = aws_ecr_repository.api_repo.repository_url
}