output "nginx_endpoint" {
  description = "ECS Load balancer nginx endpoint"
  value       = aws_alb.this.dns_name
}

output "subnet" {
  description = "sg"
  value = var.subnets
}