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

      subnet_ids       = module.vpc.public_subnets
      assign_public_ip = false

      load_balancer = {
        target_group_arn = module.alb.target_groups["payment"].arn
        container_name   = "payment-api"
        container_port   = var.container_port
      }

      container_definitions = {
        payment-api = {
          image     = "${aws_ecr_repository.api_repo.repository_url}:latest"
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

resource "aws_ecr_repository" "app" {
  name = "micropizzeria-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}