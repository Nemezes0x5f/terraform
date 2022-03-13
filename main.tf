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

provider "aws" {
  alias  = "us-west-1"
  region = "us-west-1"
}

resource "aws_instance" "dev" {
  count         = 3
  ami           = var.amis.us-west-2
  instance_type = var.instance
  key_name      = "dev"
  tags = {
    Name = "Dev Server ${count.index}"
  }
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

# resource "aws_instance" "dev4" {
#   ami           = var.amis.us-west-2
#   instance_type = var.instance
#   key_name      = "dev"
#   tags = {
#     Name = "Dev Server 4"
#   }
#   vpc_security_group_ids = [aws_security_group.ssh-access.id]
#   depends_on = [
#     aws_s3_bucket.dev-4-bucket
#   ]
# }

resource "aws_instance" "dev5" {
  ami           = var.amis.us-west-2
  instance_type = var.instance
  key_name      = "dev"
  tags = {
    Name = "Dev Server 5"
  }
  vpc_security_group_ids = [aws_security_group.ssh-access.id]
}

resource "aws_instance" "dev6" {
  provider      = aws.us-west-1
  ami           = var.amis.us-west-1
  instance_type = var.instance
  key_name      = "dev"
  tags = {
    Name = "Dev Server 6"
  }
  vpc_security_group_ids = [aws_security_group.ssh-access-us-west-2.id]
  depends_on = [
    aws_dynamodb_table.dynamodb-homologacao
  ]
}


resource "aws_instance" "dev7" {
  provider      = aws.us-west-1
  ami           = var.amis.us-west-1
  instance_type = var.instance
  key_name      = "dev"
  tags = {
    Name = "Dev Server 7"
  }
}
# resource "aws_s3_bucket" "dev-4-bucket" {
#   bucket = "dev-4-bucket"
#   acl    = "private"
#   tags = {
#     Name        = "Dev 4 Bucket"
#     Environment = "Dev"
#   }
# }

resource "aws_dynamodb_table" "dynamodb-homologacao" {
  provider     = aws.us-west-1
  name         = "GameScores"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "UserId"
  range_key    = "GameTitle"

  attribute {
    name = "UserId"
    type = "S"
  }

  attribute {
    name = "GameTitle"
    type = "S"
  }
}

resource "aws_s3_bucket" "terraform-cloud-test" {
  bucket = "terraform-cloud-test"
  acl    = "private"
  tags = {
    Name        = "Terraform Cloud Test"
    Environment = "Dev"
  }
}
