terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region = "eu-central-1"
}

data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}
/*
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.0.0"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  private_subnets = var.vpc_private_subnets
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = var.vpc_tags
} */
#################################################################

resource "aws_vpc" "default" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.default.id
}

resource "aws_subnet" "eu_central_subnet" {
  vpc_id                  = aws_vpc.default.id
  cidr_block              = "172.31.0.0/24"
  map_public_ip_on_launch = true

  depends_on = [aws_internet_gateway.gw]
}

# Copy bash script with instructions to create ansible environment
resource "aws_instance" "jen_controller" {
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = var.ec2_instance_type
  availability_zone = "eu-central-1c"
  key_name          = "FinalTaskEPAM"
  private_ip        = "172.31.0.10"

  provisioner "file" {
    source      = "jen_controller/provisioner.sh"
    destination = "/home/ec2-user/provisioner.sh"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/Users/caroot/.aws/FinalTaskEPAM.pem")
      host        = aws_instance.jen_controller.public_ip
    }
  }

  # Enable epel-release and install ansible
  provisioner "remote-exec" {
    inline = [
      "chmod +x /home/ec2-user/provisioner.sh",
      "bash /home/ec2-user/provisioner.sh"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("/Users/caroot/.aws/FinalTaskEPAM.pem")
      host        = aws_instance.jen_controller.public_ip
    }
  }

  # Add instance to security group
  vpc_security_group_ids = ["sg-fea3788e",
    aws_security_group.ssh_sg.id,
    aws_security_group.jenkins_sg.id
  ]

  tags = {
    Name = "Jen/Ans Controller"
  }
}

resource "aws_instance" "web_server" {
  ami               = data.aws_ami.amazon_linux.id
  instance_type     = var.ec2_instance_type
  availability_zone = "eu-central-1c"
  key_name          = "FinalTaskEPAM"
  private_ip        = "172.31.0.11"
  #subnet_id         = aws_subnet.eu_central_subnet.id

  # Add instance to security group
  vpc_security_group_ids = ["sg-fea3788e",
    aws_security_group.ssh_sg.id,
    aws_security_group.jenkins_sg.id
  ]

  tags = {
    Name = "Web-server"
  }
}

resource "aws_eip" "eip_jen_controller" {
  instance = aws_instance.jen_controller.id
  vpc      = true
}

resource "aws_eip" "eip_web_server" {
  instance = aws_instance.web_server.id
  vpc      = true
}
# Static ip for Jenkins/Ansible Controller
/*
resource "aws_eip" "static_ip" {
  vpc = true

  instance = aws_instance.jen_controller.id
  associate_with_private_ip = "172.31.0.10"
  depends_on = [aws_internet_gateway.gw]
}
*/
/*
module "ec2_instances" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "2.19.0"

  name           = "my-cluster"
  instance_count = 2

  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
*/
