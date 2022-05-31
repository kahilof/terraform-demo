terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

terraform {
  backend "s3" {
    bucket = "this-is-terraform-state"
    key    = "terraform-demo/terraform.tfstate"
    region = "eu-west-1"
  }
}

provider "aws" {
  region = var.region
}
