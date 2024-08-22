output "instance_public_ip" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.pb_infra_instance.public_ip
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.pb_bucket1.bucket
}

output "dynamodb_table_name" {
  description = "The name of the DynamoDB table"
  value       = aws_dynamodb_table.pb_terraform_lock.name
}