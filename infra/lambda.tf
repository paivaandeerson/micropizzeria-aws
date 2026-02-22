module "logistic_order_consumer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "marketplace-app-bff"
  description   = "Marketplace BFF Lambda"

  handler = "adapter.inbound.lambda_function.lambda_handler"
  runtime = "python3.11"

  memory_size = 128
  timeout     = 10

  publish = true

  create_role                  = true
  attach_cloudwatch_logs_policy = true

  s3_existing_package = {
    bucket = var.artifact_bucket
    key    = "marketplace-app-bff/${var.version}.zip"
  }

  environment_variables = {
    ENVIRONMENT = var.environment
  }

  vpc_subnet_ids         = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.lambda_sg.id]

  tags = var.common_tags
}

resource "aws_security_group" "lambda_sg" {
  name   = "lambda-sg"
  vpc_id = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
