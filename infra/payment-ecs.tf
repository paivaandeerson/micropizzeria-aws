module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.0"

  cluster_name = "payment-cluster"

  services = {
    payment = {
      cpu    = 256
      memory = 512

      desired_count = var.desired_count
      launch_type   = "FARGATE"

      subnet_ids       = module.vpc.private_subnets
      assign_public_ip = false
      security_group_ids = [aws_security_group.ecs_tasks.id]
      load_balancers = [
        {
          target_group_arn = module.alb.target_groups["payment"].arn
          container_name   = "payment-api"
          container_port   = var.container_port
        }
      ]

      container_definitions = {
        payment-api = {
          image     = var.container_image
          readonly_root_filesystem = false
          port_mappings = [
            {
              containerPort = var.container_port
              hostPort      = var.container_port
              protocol      = "tcp"
            }
          ]
        }
      }
    }
  }

  tags = var.common_tags
}

resource "aws_security_group" "ecs_tasks" {
  name   = "ecs-tasks-sg"
  vpc_id = module.vpc.vpc_id

  ingress {
    from_port       = var.container_port
    to_port         = var.container_port
    protocol        = "tcp"
    security_groups = [module.alb.security_group_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}