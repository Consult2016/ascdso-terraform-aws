output "public_ip" {
  value       = aws_instance.ubuntu1804.public_ip
  description = "The public IP address of the web server"
}
