output "role_id" {
  description = "ID of the application IAM role."
  value       = aws_iam_role.application.id
}

output "role_name" {
  description = "Name of the application IAM role."
  value       = aws_iam_role.application.name
}

output "role_arn" {
  description = "ARN of the application IAM role."
  value       = aws_iam_role.application.arn
}

output "instance_profile_id" {
  description = "ID of the EC2 instance profile, if created."
  value       = var.create_instance_profile ? aws_iam_instance_profile.application[0].id : null
}

output "instance_profile_name" {
  description = "Name of the EC2 instance profile, if created."
  value       = var.create_instance_profile ? aws_iam_instance_profile.application[0].name : null
}

output "instance_profile_arn" {
  description = "ARN of the EC2 instance profile, if created."
  value       = var.create_instance_profile ? aws_iam_instance_profile.application[0].arn : null
}
