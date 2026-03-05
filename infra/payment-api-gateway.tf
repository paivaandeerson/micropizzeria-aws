module "http_api" {
  source  = "terraform-aws-modules/apigateway-v2/aws"
  version = "~> 2.0"

  name          = "payment-api-${var.environment}"
  protocol_type = "HTTP"

  create_default_stage = true 
  create_api_domain_name = false

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