terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = var.aws_region
}

# Jenkins Controller
resource "aws_instance" "Jenkins_Controller" {
  ami               = var.aws_ami_id
  instance_type     = var.aws_ec2_instance
  availability_zone = var.aws_availability_zone
  subnet_id         = var.aws_subnet_id
  key_name          = var.aws_private_key
  tags = {
    Name    = "Jenkins Controller"
    OS      = "Amazon Linux"
    Purpose = "Controller"
  }
}

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  cidr   = var.vpc_cidr_block
}
