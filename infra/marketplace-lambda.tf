module "marketplace-app-bff" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "marketplace-app-bff"
  description   = "Marketplace BFF Lambda"

  handler = "src.adapter.inbound.lambda_function.lambda_handler"
  runtime = "python3.11"

  memory_size = 512
  timeout     = 10

  publish = true
  create_package = true

  source_path = [
    {
      path             = "../marketplace/marketplace-app-bff"
      pip_requirements = "../marketplace/marketplace-app-bff/requirements.txt"
    }
  ]

  create_role = true
  attach_cloudwatch_logs_policy = true
  attach_policies = true
  number_of_policies = 1

  policies = [
    "arn:aws:iam::aws:policy/service-role/AWSLambdaVPCAccessExecutionRole"
  ]

  vpc_subnet_ids         = module.vpc.private_subnets
  vpc_security_group_ids = [aws_security_group.lambda_sg.id]

  tags = var.common_tags
}

resource "aws_security_group" "lambda_sg" {
  name   = "lambda-sg"
  vpc_id = module.vpc.vpc_id
  timeouts {
    delete = "15m"
  }

  egress {
    from_port   = 0 #"allow all outbound" rule for the Lambda function, enabling it to access external services if needed.
    to_port     = 0 
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # cidr_blocks: ["0.0.0.0/0"] — allows outbound to any IPv4 address (internet-wide).
  }
}
