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
