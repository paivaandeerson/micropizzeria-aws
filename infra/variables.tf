#declaration for terraform.tfvars file
variable "environment" {}
variable "artifact_bucket" {}
variable "container_image" {}

variable "app_version" {
  description = "Application version"
  type        = string
}

variable "aws_region" {
  default = "us-east-1"
}

variable "lambda_s3_key" {
  description = "S3 key for the Lambda deployment package"
  type        = string
}

variable "ecr_registry" {
  description = "ECR registry URL"
  type        = string
}

variable "container_port" {
  default = 3000
}

variable "desired_count" {
  default = 1
}

variable "common_tags" {
  type    = map(string)
  default = {
    # Environment = "dev"
    Project     = "micropizzeria-app"
  }
}

variable "image_tag" {
  type = string
}
