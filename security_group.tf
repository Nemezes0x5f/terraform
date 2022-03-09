resource "aws_security_group" "ssh-access" {
  name        = "ssh-access"
  description = "ssh-access"
  ingress {
    description = "ssh-access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_remote_access
  }
  tags = {
    Name = "ssh-access"
  }
}

resource "aws_security_group" "ssh-access-us-west-2" {
  provider    = aws.us-west-1
  name        = "ssh-access"
  description = "ssh-access"
  ingress {
    description = "ssh-access"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = var.cidr_remote_access
  }
  tags = {
    Name = "ssh-access"
  }
}
