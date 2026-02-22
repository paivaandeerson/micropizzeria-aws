terraform {
  backend "s3" {
    bucket = "micropizzeria-infra-state"
    key    = "terraform/state.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
  region = var.aws_region
}

