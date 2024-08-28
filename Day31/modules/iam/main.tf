resource "aws_iam_role" "pb_ec2_role" {
  name = "pb-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_policy" "pb_ec2_policy" {
  name        = "pb-policy"
  description = "Policy for EC2 instances"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "s3:*",
        Effect = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "pb_ec2_policy_attachment" {
  role       = aws_iam_role.pb_ec2_role.name
  policy_arn = aws_iam_policy.pb_ec2_policy.arn
}

resource "aws_iam_instance_profile" "pb_ec2_profile" {
  name = "pb-ec2-instance-profile"
  role = aws_iam_role.pb_ec2_role.name
}