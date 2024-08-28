data "aws_availability_zones" "available" {}

resource "aws_vpc" "pb_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "pb-vpc"
  }
}

resource "aws_subnet" "public" {
  count = 2
  
  vpc_id     = aws_vpc.pb_vpc.id
  cidr_block = element(["10.0.1.0/24", "10.0.2.0/24"], count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  
  tags = {
    Name = "pb-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = 2

  vpc_id     = aws_vpc.pb_vpc.id
  cidr_block = element(["10.0.3.0/24", "10.0.4.0/24"], count.index)
  availability_zone = element(data.aws_availability_zones.available.names, count.index)
  
  tags = {
    Name = "pb-private-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "pb_igw" {
  vpc_id = aws_vpc.pb_vpc.id
  tags = {
    Name = "pb-internet-gateway"
  }
}

resource "aws_route_table" "pb_public_rtb" {
  vpc_id = aws_vpc.pb_vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.pb_igw.id
  }
  tags = {
    Name = "pb-public-route-table"
  }
}

