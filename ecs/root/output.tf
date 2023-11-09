output "nginx_endpoint" {
  description = "ECS service nginx enpoint"
  value       = module.kc-ecs-final.nginx_endpoint
}

output "subnet" {
  description = "Subnet"
  value = module.kc-ecs-final.subnet
}