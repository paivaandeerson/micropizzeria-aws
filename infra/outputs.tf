output "alb_dns" {
  value = module.alb.dns_name
}

output "api_gateway_url" {
  value = module.http_api.apigatewayv2_api_api_endpoint
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}

output "payment_api_url" {  
  value = "http://${module.alb.dns_name}"
}
output "debug_private_subnets" {
  value = module.vpc.private_subnets
}