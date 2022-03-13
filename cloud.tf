terraform {
  cloud {
    organization = "nemezes-labs"
    hostname     = "app.terraform.io" # Optional; defaults to app.terraform.io

    workspaces {
      name = "aws-nemezes-labs"
    }
  }
}
