# Output variable definitions
/*
output "vpc_public_subnets" {
  description = "IDs of the VPC's public subnets"
  value       = aws_vpc.default.id #module.vpc.public_subnets
}
*/

output "jen-ans_controller_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.jen_controller.public_ip
}

output "web-server_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.web_server.public_ip
}

output "build_ip" {
  description = "Public IP addresses of EC2 instances"
  value       = aws_instance.build.public_ip
}
