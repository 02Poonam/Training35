provider "aws" {
  region = var.region
}

# VPC
resource "aws_vpc" "pb_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "pb-vpc"
  }
}

# Subnet
resource "aws_subnet" "pb_subnet" {
  vpc_id            = aws_vpc.pb_vpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = var.availability_zone  # Specify an availability zone within your region

  tags = {
    Name = "pb-subnet"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.pb_vpc.id
  tags = {
    Name = "pb-igw"
  }
}

# Create a Route Table and associate it with the public subnet
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.pb_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "pb-public-route-table"
  }
}

resource "aws_route_table_association" "pb_subnet" {
  subnet_id      = aws_subnet.pb_subnet.id
  route_table_id = aws_route_table.public.id
}

#Security group
resource "aws_security_group" "pb_sg" {
  vpc_id = aws_vpc.pb_vpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# EC2 Instance
resource "aws_instance" "pb_infra_instance" {
  ami                  = var.ami_id
  instance_type        = var.instance_type
  vpc_security_group_ids = [aws_security_group.pb_sg.id]
  subnet_id            = aws_subnet.pb_subnet.id
  associate_public_ip_address = true
  tags = {
    Name = "pb-instance"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "pb_bucket1" {
  bucket = var.bucket_name
  tags = {
    Name = "pb-bucket1"
  }
}

# DynamoDB Table for state locking
resource "aws_dynamodb_table" "pb_terraform_lock" {
  name           = var.dynamodb_table_name
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "pb-terraform-lock-table1"
  }
}
