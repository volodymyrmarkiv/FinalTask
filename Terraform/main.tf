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

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
###################################################
# Jenkins Controller EC2 instance
resource "aws_instance" "jenkins_controller" {
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = var.aws_ec2_instance
  availability_zone = var.aws_availability_zone
  subnet_id         = aws_subnet.subnet_ft.id
  #subnet_id         = var.aws_subnet_id
  key_name   = var.aws_private_key
  private_ip = "172.16.0.10"
  #vpc_id   = aws_vpc.vpc_ft.id
  tags = {
    Name    = "Jenkins Controller"
    OS      = "Amazon Linux"
    Purpose = "Controller"
  }
}

# Create Elastic IP for Jenkins Controller
resource "aws_eip" "ip_jenkins_controller" {
  vpc = true
  #enable_dns_hostnames = true
  instance                  = aws_instance.jenkins_controller.id
  associate_with_private_ip = "172.16.0.10"
  depends_on                = [aws_internet_gateway.gw]
}

###################################################
# Web-server (Jenkins Agent) EC2 instance
resource "aws_instance" "web_server" {
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = var.aws_ec2_instance
  availability_zone = var.aws_availability_zone
  subnet_id         = aws_subnet.subnet_ft.id
  key_name          = var.aws_private_key
  private_ip        = "172.16.0.11"
  tags = {
    Name    = "Web-server (Jen agt)"
    OS      = "Amazon Linux"
    Purpose = "Web-server"
  }
}

# Create Elastic IP for Web-server
resource "aws_eip" "ip_web_server" {
  vpc = true
  #enable_dns_hostnames = true
  instance                  = aws_instance.web_server.id
  associate_with_private_ip = "172.16.0.11"
  depends_on                = [aws_internet_gateway.gw]
}

###################################################
# RDS instance
resource "aws_db_instance" "RDS" {
  allocated_storage   = 20
  engine              = "mariadb"
  engine_version      = "10.5.8"
  instance_class      = "db.t2.micro"
  name                = "rds_ft"
  username            = "admin"
  password            = "finaltask"
  skip_final_snapshot = true
  availability_zone   = var.aws_availability_zone
}

###################################################

resource "aws_vpc" "vpc_ft" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "Final task"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.vpc_ft.id
}

resource "aws_subnet" "subnet_ft" {
  vpc_id                  = aws_vpc.vpc_ft.id
  cidr_block              = "172.16.0.0/24"
  availability_zone       = var.aws_availability_zone
  map_public_ip_on_launch = true
  tags = {
    Name = "Final task"
  }
  depends_on = [aws_internet_gateway.gw]
}
