output "iam_instance_profile_id" {
  value = aws_iam_instance_profile.pb_ec2_profile.id
}

output "iam_role_arn" {
  value = aws_iam_role.pb_ec2_role.arn
}