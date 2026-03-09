module "http_api" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 2.0"

  name          = "payment-api-${var.environment}"
  protocol_type = "HTTP"

  create_default_stage = true 
  create_api_domain_name = false

  default_stage_access_log_destination_arn = aws_cloudwatch_log_group.api_gateway.arn

  default_route_settings = {
    detailed_metrics_enabled = true
    throttling_burst_limit   = 100
    throttling_rate_limit    = 50
  }

  #to define a contract for the API, we use an OpenAPI specification file.
  # body = file("${path.module}/openapi.yaml")
  integrations = {
    "POST /v1/payment" = {
      lambda_arn             = module.marketplace-app-bff.lambda_function_arn
      payload_format_version = "2.0"
    }
  }

  tags = var.common_tags
}

resource "aws_lambda_permission" "allow_apigw_lambda" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = module.marketplace-app-bff.lambda_function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${module.http_api.apigatewayv2_api_execution_arn}/*/*"
}

resource "aws_cloudwatch_log_group" "api_gateway" {
  name              = "/aws/apigateway/payment-api-${var.environment}"
  retention_in_days = 7
  tags              = var.common_tags
}