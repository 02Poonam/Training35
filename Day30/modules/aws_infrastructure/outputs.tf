output "instance_public_ip" {
  value = aws_instance.pb_instance.public_ip
}

output "bucket_arn" {
  value = aws_s3_bucket.pb_bucket.arn
}