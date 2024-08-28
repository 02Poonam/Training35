variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for EC2 instances"
  type        = list(string)
}

variable "iam_role_arn" {
  description = "IAM role ARN to attach to EC2 instances"
  type        = string
}

variable "iam_instance_profile_id" {
  description = "IAM instance profile ID to attach to EC2 instances"
  type        = string
}