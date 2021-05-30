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
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = "final-task-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-central-1a", "eu-central-1b", "eu-central-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true
  # Skip creation of EIPs for the NAT Gateways
  reuse_nat_ips = true
  # IPs specified here as input to the module
  external_nat_ip_ids = aws_eip.nat.*.id
  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

resource "aws_eip" "nat" {
  count = 3

  vpc = true
}
