terraform {
  backend "s3" {
    bucket = "terraform-state-467406547633"
    key    = "terraform-state-467406547633/terraform-demo/"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = "${var.region}"
}
