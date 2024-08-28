resource "aws_s3_bucket" "bucket_pb_31" {
  bucket = var.bucket_name

  tags = {
    Name = "s3-bucket"
  }
}

resource "aws_s3_bucket_versioning" "bucket_pb_31_versioning" {
  bucket = aws_s3_bucket.bucket_pb_31.id

  versioning_configuration {
    status = "Enabled"
  }
}