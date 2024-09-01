provider "aws" {
  region = var.region
}

resource "aws_instance" "pb_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = var.key_pair_name
  associate_public_ip_address = true  

  tags = {
    Name = "pb-instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update -y",
      "sudo apt-get install -y apache2",
      "sudo systemctl start apache2",
      "sudo systemctl enable apache2"
    ]
    connection {
      type        = "ssh"
      user        = "ubuntu"
      private_key = file(var.private_key)
      host        = self.public_ip
    }
  }

  provisioner "local-exec" {
    command = "echo 'EC2 instance successfully provisioned with Apache' > provision_status.txt"
  }
}

resource "aws_s3_bucket" "pb_bucket" {
  bucket = var.bucket_name

  tags = {
    Name = "${var.name}-bucketd30"
  }
}