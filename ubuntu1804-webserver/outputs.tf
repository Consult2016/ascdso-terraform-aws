### output definition - IP address
output "aws_instance_public_ip" {
  value       = aws_instance.ubuntu1804.public_ip
  description = "The public IP address of the web server"
}

### output definition - DNS address
output "aws_instance_public_dns" {
  value       = aws_instance.ubuntu1804.public_dns
  description = "The public DNS address of the web server"
}
