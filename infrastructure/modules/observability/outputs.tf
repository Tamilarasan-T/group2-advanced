output "log_group_name" {
  description = "Name of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.this.name
}

output "log_group_arn" {
  description = "ARN of the CloudWatch Log Group."
  value       = aws_cloudwatch_log_group.this.arn
}

output "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the log group."
  value       = aws_kms_key.logs.arn
}

output "kms_key_id" {
  description = "ID of the KMS key used to encrypt the log group."
  value       = aws_kms_key.logs.key_id
}
