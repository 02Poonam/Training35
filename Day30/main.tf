provider "aws" {
  region = var.region
}

module "aws_infrastructure" {
  source        = "./modules/aws_infrastructure/"
  instance_type = var.instance_type
  ami_id        = var.ami_id
  key_pair_name = var.key_pair_name
  bucket_name   = var.bucket_name
  private_key   = var.private_key
  name          = var.name
}

