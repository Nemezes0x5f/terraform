variable "amis" {
  type = map(any)

  default = {
    "us-west-1" = "ami-01f87c43e618bf8f0"
    "us-west-2" = "ami-0892d3c7ee96c0bf7"
  }
}

variable "instance" {
  default = "t2.micro"
}

variable "cidr_remote_access" {
  type    = list(any)
  default = ["0.0.0.0/0"]
}

variable "ssh_key" {
  default = "dev"
}
