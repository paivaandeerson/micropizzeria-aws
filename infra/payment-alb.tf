module "alb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "~> 9.0"

  name               = "payment-alb"
  load_balancer_type = "application"
  vpc_id             = module.vpc.vpc_id
  subnets            = module.vpc.private_subnets
  internal = true
  enable_deletion_protection = false

  security_group_ingress_rules = {
    http = {
      from_port   = 80
      to_port     = 80
      ip_protocol = "tcp"
      referenced_security_group_id = aws_security_group.lambda_sg.id
    }
  }

  target_groups = {
    payment = {
      backend_protocol = "HTTP"
      backend_port     = var.container_port
      target_type      = "ip"
      create_attachment = false
      health_check = {
        path                = "/health"
        protocol            = "HTTP"
        matcher             = "200"
        interval            = 30
        timeout             = 5
        healthy_threshold   = 2
        unhealthy_threshold = 2
      }
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

# resource "aws_apigatewayv2_stage" "default" {
#   api_id = aws_apigatewayv2_api.this.id
#   name   = "$default"

#   default_route_settings {
#     data_trace_enabled = true
#     detailed_metrics_enabled = true
#   }
# }