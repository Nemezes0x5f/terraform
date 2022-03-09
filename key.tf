resource "aws_key_pair" "dev-us-west-2" {
  key_name   = var.ssh_key
  public_key = file("${var.ssh_key}.pub")
}

resource "aws_key_pair" "dev-us-west-1" {
  provider   = aws.us-west-1
  key_name   = var.ssh_key
  public_key = file("${var.ssh_key}.pub")
}
