output "alb_dns" {
  value = module.alb.dns_name
}

output "api_gateway_url" {
  value = module.http_api.api_endpoint
}

output "ecs_cluster_name" {
  value = module.ecs.cluster_name
}
