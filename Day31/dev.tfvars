vpc_cidr             = "10.0.0.0/16"
public_subnet_cidrs  = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet_cidrs = ["10.0.3.0/24", "10.0.4.0/24"]
instance_type        = "t2.micro"
db_username          = "pbdevuser"
db_password          = "dev-1234"
s3_bucket_name       = "pb-bucket-s3-dev"