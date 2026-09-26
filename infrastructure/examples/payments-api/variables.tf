variable "aws_region" {
  description = "AWS region for the application infrastructure."
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Application environment."
  type        = string
  default     = "dev"
}
