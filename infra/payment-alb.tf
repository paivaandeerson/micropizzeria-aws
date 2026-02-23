module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name               = "payment-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.public_subnets

  security_group_ingress_rules = {
    http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      cidr_ipv4 = "0.0.0.0/0"
    }
  }

  target_groups = {
  payment = {
    backend_protocol = "HTTP"
    backend_port     = var.container_port
    target_type      = "ip"

    create_attachment = false
  }
}

  listeners = {
    http = {
      port     = 80
      protocol = "HTTP"
      forward = {
        target_group_key = "payment"
      }
    }
  }

  tags = var.common_tags
}
