variable "region" {
  default = "us-west-1"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instance"
  type        = string
  default     = "ami-0d53d72369335a9d6"
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_name" {
  description = "The name of the existing SSH key pair"
  type        = string
  default     = "tfD28"
}

variable "db_instance_class" {
  default = "db.t3.micro"
}

variable "db_name" {
  default = "mydatabase"
}

variable "db_username" {
  default = "admin"
}

variable "db_password" {
  default   = "password"
  sensitive = true
}
