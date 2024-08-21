output "pb_ec2_public_ip" {
  value = aws_instance.appserver.public_ip
}

output "pb_rds_endpoint" {
  value = aws_db_instance.db.endpoint
}

output "pb_s3_bucket_name" {
  value = aws_s3_bucket.bucket.bucket
}
