variable "aws_region" {
  default = "us-east-1"
}

variable "environment" {}
variable "version" {}
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
