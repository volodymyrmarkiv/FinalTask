provider "aws" {
  region = "eu-central-1"
}

# Fir
resource "aws_instance" "Jenkins_Controller" {
  ami               = "ami-043097594a7df80ec"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1b"
  subnet_id         = "subnet-24cb6558"
  key_name          = "FinalTaskEPAM"
  tags = {
    Name    = "Jenkins Controller"
    OS      = "Amazon Linux"
    Purpose = "Controller"

  }

}

resource "aws_instance" "Jenkins_Build" {
  ami               = "ami-043097594a7df80ec"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1b"
  subnet_id         = "subnet-24cb6558"
  key_name          = "FinalTaskEPAM"
  tags = {
    Name    = "Jenkins Build"
    OS      = "Amazon Linux"
    Purpose = "Build"

  }

}


resource "aws_instance" "Apache" {
  ami               = "ami-043097594a7df80ec"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1b"
  subnet_id         = "subnet-24cb6558"
  key_name          = "FinalTaskEPAM"
  tags = {
    Name    = "Apache"
    OS      = "Amazon Linux"
    Purpose = "Web-server"

  }

}

resource "aws_instance" "Database" {
  ami               = "ami-043097594a7df80ec"
  instance_type     = "t2.micro"
  availability_zone = "eu-central-1b"
  subnet_id         = "subnet-24cb6558"
  key_name          = "FinalTaskEPAM"
  tags = {
    Name    = "DB"
    OS      = "Amazon Linux"
    Purpose = "Database"

  }

}
