module "ecs" {
  source  = "terraform-aws-modules/ecs/aws"
  version = "~> 5.0"
  depends_on =  [
    module.vpc,
    module.alb
  ]
  cluster_name = "payment-cluster"
  task_exec_iam_role_name = "ecsTaskExecutionRole"

  services = {
    payment = {
      cpu    = 256
      memory = 512

      desired_count = var.desired_count
      launch_type   = "FARGATE"

      enable_execute_command = true

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
          image                    = var.container_image
          readonly_root_filesystem = false
          essential                = true

          port_mappings = [
            {
              containerPort = var.container_port
              hostPort      = var.container_port
              protocol      = "tcp"
            }
          ]

          environment = [
            {
              name  = "AWS_XRAY_DAEMON_ADDRESS"
              value = "127.0.0.1:2000"
            }
          ]
        }

        xray-daemon = {
          image     =  "${var.ecr_registry}/aws-xray-daemon:latest"
          essential = false

          cpu    = 32
          memory = 256

          port_mappings = [
            {
              containerPort = 2000
              protocol      = "udp"
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

resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecsTaskExecutionRole"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "ecs_execution" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

resource "aws_iam_role_policy_attachment" "xray" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = "arn:aws:iam::aws:policy/AWSXrayWriteOnlyAccess"
}
