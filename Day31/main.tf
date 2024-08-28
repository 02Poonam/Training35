provider "aws" {
  region = "us-east-2"
  profile = var.aws_profile
}

terraform {
  backend "s3" {
    bucket         = "pb-bucket-s3-dev"
    key            = "terraform/state.tfstate"
    region         = "us-east-2"
    dynamodb_table = "pb-terraform-lock-table"
    encrypt        = true
  }
}

module "vpc" {
  source               = "./modules/vpc"
  cidr_block           = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
}

module "rds" {
  source      = "./modules/rds"
  db_username = var.db_username
  db_password = var.db_password
  vpc_id      = module.vpc.vpc_id
  db_subnet_ids  = module.vpc.private_subnets
}

module "s3" {
  source      = "./modules/s3"
  bucket_name = var.s3_bucket_name
}

module "iam" {
  source = "./modules/iam"
}

module "ec2" {
  source = "./modules/ec2"
  instance_type = var.instance_type
  subnet_ids = module.vpc.public_subnets
  iam_instance_profile_id = module.iam.iam_instance_profile_id
  iam_role_arn  = module.iam.iam_role_arn
}