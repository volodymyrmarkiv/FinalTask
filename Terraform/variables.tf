# Input variable definitions

variable "vpc_name" {
  description = "Name of VPC"
  type        = string
  default     = "main-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "172.31.0.0/16"
}

variable "ec2_instance_type" {
  description = "Default EC2 instance"
  type        = string
  default     = "t2.micro"
}
