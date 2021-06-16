output "jen-ans_controller_ip" {
  description = "Public IP addresses of Jenkins/Ansible Controller EC2 instance"
  value       = aws_instance.jen_controller.public_ip
}

output "web-server_ip" {
  description = "Public IP addresses of Web-server EC2 instance"
  value       = aws_instance.web_server.public_ip
}

output "build_ip" {
  description = "Public IP addresses of Jenkins Agent (build) EC2 instance"
  value       = aws_instance.build.public_ip
}

output "sonarqube_ip" {
  description = "Public IP addresses of Sonarqube EC2 instance"
  value       = aws_instance.test.ip_address
}