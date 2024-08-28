resource "aws_instance" "pb_web" {
  count = 2
  ami           = "ami-085f9c64a9b75eed5"  
  instance_type = var.instance_type
  subnet_id     = element(var.subnet_ids, count.index)
  associate_public_ip_address = true
  iam_instance_profile = var.iam_instance_profile_id

  tags = {
    Name = "pb-web-server-${count.index}"
  }
}