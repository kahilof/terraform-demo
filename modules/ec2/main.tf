data "aws_caller_identity" "current" {}

resource "aws_instance" "app_server" {
  ami           = "ami-0e8cb4bdc5bb2e6c0"
  instance_type = "t2.micro"

  tags = {
    Name = var.instance_name
  }
}

