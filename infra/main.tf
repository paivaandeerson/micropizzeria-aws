locals {
    aws_provider = var.aws_provider[terraform.workspace]
    aws_region = "us-east-1"
    aws_account = terraform.workspace == "prd" ? "123456789" : "987654321"
}