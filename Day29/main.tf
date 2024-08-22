provider "aws" {
  region = var.region
}

module "pb-app" {
  source              = "./modules/infrastructure"
  region              = var.region
  availability_zone   = var.availability_zone
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  bucket_name         = var.bucket_name
  dynamodb_table_name = var.dynamodb_table_name
}


output "instance_public_ip" {
  value = module.pb-app.instance_public_ip
}

output "bucket_name" {
  value = module.pb-app.bucket_name
}

output "dynamodb_table_name" {
  value = module.pb-app.dynamodb_table_name
}
