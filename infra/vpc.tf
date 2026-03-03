module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 6.0"

  name = "main-vpc"
  cidr = "10.0.0.0/16"

  azs = ["us-east-1a", "us-east-1b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = false
  
  enable_dns_hostnames = true
  enable_dns_support   = true

  enable_vpc_endpoints = true

  vpc_endpoints = {
    ecr_api = {
      service             = "ecr.api"
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
    }

    ecr_dkr = {
      service             = "ecr.dkr"
      subnet_ids          = module.vpc.private_subnets
      private_dns_enabled = true
    }

    s3 = {
      service = "s3"
    }
  }

  tags = var.common_tags
}
