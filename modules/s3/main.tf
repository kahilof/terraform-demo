data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "s3_location" {
  bucket = "driftctl-my-tf-test-bucket"

  tags = {
    Name        = "driftctl test bucket"
    Environment = "Dev"
  }
}