variable "name" {
  description = "Application or platform name used for resource naming."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9-]+$", var.name))
    error_message = "Name must contain only lowercase letters, numbers, and hyphens."
  }
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, prod."
  }
}

variable "trusted_service" {
  description = "AWS service principal allowed to assume the IAM role."
  type        = string

  validation {
    condition     = contains(["ec2.amazonaws.com", "ecs-tasks.amazonaws.com", "eks.amazonaws.com"], var.trusted_service)
    error_message = "trusted_service must be an approved AWS compute service principal."
  }
}

variable "policy_statements" {
  description = "IAM policy statements to attach to the application role."
  type        = list(any)
  default     = []
}

variable "max_session_duration" {
  description = "Maximum duration of an IAM role session in seconds."
  type        = number
  default     = 3600

  validation {
    condition     = var.max_session_duration >= 3600 && var.max_session_duration <= 43200
    error_message = "max_session_duration must be between 3600 and 43200 seconds."
  }
}

variable "create_instance_profile" {
  description = "Whether to create an EC2 instance profile for the IAM role."
  type        = bool
  default     = false
}

variable "tags" {
  description = "Additional tags to apply to IAM resources."
  type        = map(string)
  default     = {}
}
