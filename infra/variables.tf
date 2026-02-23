variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {}

variable "app_version" {
  description = "Application version"
  type        = string
}

variable "lambda_s3_key" {
  description = "S3 key for the Lambda deployment package"
  type        = string
}
variable "artifact_bucket" {}

variable "container_image" {}
variable "container_port" {
  default = 3000
}

variable "desired_count" {
  default = 1
}

variable "common_tags" {
  type    = map(string)
  default = {}
}

variable "image_tag" {
  type = string
}

locals {
  container_image = "${aws_ecr_repository.app.repository_url}:${var.image_tag}"
}