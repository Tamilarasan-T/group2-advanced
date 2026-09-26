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

variable "log_group_name" {
  description = "Name of the CloudWatch Log Group."
  type        = string

  validation {
    condition     = length(var.log_group_name) >= 1 && length(var.log_group_name) <= 512
    error_message = "log_group_name must contain between 1 and 512 characters."
  }
}

variable "retention_in_days" {
  description = "Number of days to retain CloudWatch logs."
  type        = number
  default     = 365

  validation {
    condition = contains(
      [
        1,
        3,
        5,
        7,
        14,
        30,
        60,
        90,
        120,
        150,
        180,
        365,
        400,
        545,
        731,
        1827,
        3653,
        0
      ],
      var.retention_in_days
    )

    error_message = "retention_in_days must be a valid CloudWatch Logs retention value."
  }
}

variable "tags" {
  description = "Additional tags to apply to all resources."
  type        = map(string)
  default     = {}
}
