locals {
  name_prefix = "${var.name}-${var.environment}"

  common_tags = merge(
    {
      Application = var.name
      Environment = var.environment
      ManagedBy   = "Terraform"
    },
    var.tags
  )
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

resource "aws_iam_role" "application" {
  name = "${local.name_prefix}-application-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Sid    = "AllowComputeServiceAssumeRole"
        Effect = "Allow"

        Principal = {
          Service = var.trusted_service
        }

        Action = "sts:AssumeRole"
      }
    ]
  })

  max_session_duration = var.max_session_duration

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-application-role"
    }
  )
}

resource "aws_iam_role_policy" "application" {
  count = length(var.policy_statements) > 0 ? 1 : 0

  name = "${local.name_prefix}-application-policy"
  role = aws_iam_role.application.id

  policy = jsonencode({
    Version   = "2012-10-17"
    Statement = var.policy_statements
  })
}

resource "aws_iam_instance_profile" "application" {
  count = var.create_instance_profile ? 1 : 0

  name = "${local.name_prefix}-application-profile"
  role = aws_iam_role.application.name

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-application-profile"
    }
  
}
