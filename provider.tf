terraform {
  backend "s3" {
    bucket = "this-is-terraform-state"
    key    = "this-is-terraform-state/terraform-demo/"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = var.region
}
