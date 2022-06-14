module "ec2" {
  source = "./modules/ec2"

  region        = var.region
  instance_name = var.instance_name
}

module "s3" {
  source = "./modules/s3"
  
}