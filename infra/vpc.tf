module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs            = ["us-east-1a"]
  public_subnets = ["10.0.1.0/24"]

  enable_nat_gateway = false

  tags = var.common_tags
}
