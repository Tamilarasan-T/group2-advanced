output "repository_name" {
  description = "Name of the ECR repository."
  value       = aws_ecr_repository.this.name
}

output "repository_arn" {
  description = "ARN of the ECR repository."
  value       = aws_ecr_repository.this.arn
}

output "repository_url" {
  description = "URL of the ECR repository."
  value       = aws_ecr_repository.this.repository_url
}

output "registry_id" {
  description = "AWS account registry ID."
  value       = aws_ecr_repository.this.registry_id
}

output "kms_key_arn" {
  description = "ARN of the KMS key used to encrypt the ECR repository."
  value       = aws_kms_key.ecr.arn
}
