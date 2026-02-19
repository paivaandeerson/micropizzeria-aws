terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = local.aws_provider["region"]

  assume_role {
        role_arn = "arn:aws:iam:123456789012:role/ROLE_NAME" //TODO: to finish
        session_name = local.aws_provider["workspace_iam_roles"] 
        external_id = local.aws_provider["workspace_iam_id_roles"]
  }
}