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
