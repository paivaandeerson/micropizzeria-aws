module "logistic_order_consumer" {
  source  = "terraform-aws-modules/lambda/aws"
  version = "~> 6.0"

  function_name = "logistic-order-consumer"
  description   = "Consumes order-finished events to update logistic status"
  handler       = "index.handler"
  runtime       = "nodejs20.x"

  # Points to the directory where your index.js and package.json are
  source_path = "./src/logistic-consumer"

  # Essential for MSK (Private): Lambda must be in the same VPC as the cluster, to access it
  vpc_subnet_ids         = ["subnet-123", "subnet-456"]
  vpc_security_group_ids = [aws_security_group.lambda_msk_access.id]

  # IAM Permissions to read from MSK
  attach_policy_statements = true
  policy_statements = {
    msk_read = { #IAM Policy
      effect    = "Allow"
      actions   = ["kafka-cluster:Connect", "kafka-cluster:DescribeTopic", "kafka-cluster:ReadData"]
      resources = [module.msk_cluster.arn]
    }
  }

  # The Trigger (Event Source Mapping)
  event_source_mapping = {
    msk = {
      event_source_arn  = module.msk_cluster.arn
      topics            = ["order-finished-topic"]
      starting_position = "TRIM_HORIZON" #Start from the very beginning of the Kafka log
      batch_size        = 100 # AWS waits until it has 100 messages to deliver in one big array
    }
  }
}