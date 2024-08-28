vpc_cidr             = "10.1.0.0/16"
public_subnet_cidrs  = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet_cidrs = ["10.1.3.0/24", "10.1.4.0/24"]
instance_type        = "t3.micro"
db_username          = "pbproduser"
db_password          = "prod-1234"
s3_bucket_name       = "pb-becket-s3-prod"
