variable "aws_region" {
  description = "default AWS region"
  type        = string
  default     = "eu-central-1"

}

variable "aws_ec2_instance" {
  description = "default AWS EC2 instance type"
  type        = string
  default     = "t2.micro"

}

#variable "vpc_cidr_block" {
#  description = "CIDR block for VPC"
#  type        = string
#  default     = "172.16.10.0/24"
#
#}

variable "aws_availability_zone" {
  description = "default AWS availability zone"
  type        = string
  default     = "eu-central-1b"

}

variable "aws_subnet_id" {
  description = "default AWS subnet"
  type        = string
  default     = "subnet-24cb6558"

}

variable "aws_private_key" {
  description = "name of the private key"
  type        = string
  default     = "FinalTaskEPAM"

}

variable "aws_ami_id" {
  description = "default Amazon Linux 2 ami id for eu-central-1"
  type        = string
  default     = "ami-043097594a7df80ec"

}

