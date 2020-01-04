### output definition - ALB domain name
output "alb_dns_name" {
  value       = aws_lb.ubuntu1804.dns_name
  description = "The domain name of the load balancer"
}
