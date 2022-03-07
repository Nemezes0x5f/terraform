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
  region = "us-west-2"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = "ami-0892d3c7ee96c0bf7"
  instance_type = "t2.micro"
  key_name      = "dev"
  tags = {
    Name = "Dev Server ${count.index}"
  }
}

resource "aws_key_pair" "dev" {
  key_name   = "dev"
  public_key = file("dev.pub")
}

resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "ssh-access"
  ingress {
    description = "ssh-access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "ssh-access"
  }
}
