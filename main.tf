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
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_instance" "dev4" {
  ami           = "ami-0892d3c7ee96c0bf7"
  instance_type = "t2.micro"
  key_name      = "dev"
  tags = {
    Name = "Dev Server 4"
  }
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
  depends_on = [
    aws_s3_bucket.dev-4-bucket
  ]
}

resource "aws_instance" "dev5" {
  ami           = "ami-0892d3c7ee96c0bf7"
  instance_type = "t2.micro"
  key_name      = "dev"
  tags = {
    Name = "Dev Server 5"
  }
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_key_pair" "dev" {
  key_name   = "dev"
  public_key = file("dev.pub")
}

resource "aws_s3_bucket" "dev-4-bucket" {
  bucket = "dev-4-bucket"
  acl    = "private"
  tags = {
    Name        = "Dev 4 Bucket"
    Environment = "Dev"
  }
}

