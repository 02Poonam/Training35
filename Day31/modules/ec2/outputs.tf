output "instance_ids" {
  value = aws_instance.pb_web[*].id
}