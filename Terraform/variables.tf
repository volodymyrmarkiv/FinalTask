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

variable "local_private_key" {
  description = "AWS local private key"
  type        = string
  default     = "/Users/caroot/.aws/FinalTaskEPAM.pem"
}

variable "aws_private_key" {
  description = "AWS private key name"
  type        = string
  default     = "FinalTaskEPAM"
}

variable "availability_zone" {
  description = "AWS private key name"
  type        = string
  default     = "eu-central-1c"
}

variable "username" {
  description = "AWS private key name"
  type        = string
  default     = "ec2-user"
}

