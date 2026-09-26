# Observability Terraform Module

## Overview

This module provides a reusable AWS CloudWatch logging capability for application and platform workloads.

The module is designed for platform-level reuse across multiple application teams and environments.

## Capabilities

The module provides:

- CloudWatch Log Group
- KMS encryption
- Automatic KMS key rotation
- Configurable log retention
- Standardized resource tagging
- Secure-by-default configuration

## Security Standards

The module follows these security principles:

- CloudWatch logs are encrypted using AWS KMS.
- KMS key rotation is enabled.
- Log retention is configurable and defaults to 365 days.
- The KMS policy restricts CloudWatch Logs access to the configured log group.
- No credentials or secrets are stored in Terraform.
- Resources use standardized tags.

## Usage

Example:

module "observability" {
  source = "../../modules/observability"

  name            = "orders-api"
  environment     = "dev"
  log_group_name  = "/applications/orders-api/dev"
  retention_in_days = 365

  tags = {
    Owner      = "Platform"
    CostCenter = "Engineering"
  }
}

## Inputs

| Name              | Description                  | Type        | Default  |
| ----------------- | ---------------------------- | ----------- | -------- |
| name              | Application or platform name | string      | Required |
| environment       | Deployment environment       | string      | Required |
| log_group_name    | CloudWatch Log Group name    | string      | Required |
| retention_in_days | Log retention period         | number      | 365      |
| tags              | Additional resource tags     | map(string) | {}       |

## Outputs

| Output         | Description               |
| -------------- | ------------------------- |
| log_group_name | CloudWatch Log Group name |
| log_group_arn  | CloudWatch Log Group ARN  |
| kms_key_arn    | KMS key ARN               |
| kms_key_id     | KMS key ID                |

## Validation

The module must pass:

1. Terraform formatting
2. Terraform initialization
3. Terraform validation
4. Checkov security scanning

## Reusability

The module can be consumed by multiple application teams.

Example consumers:

* orders-api
* payments-api
* customer-api

Each application can create its own isolated CloudWatch Log Group using the same module.

## Security and Compliance

The module supports centralized platform standards for:

* Log encryption
* Log retention
* Resource tagging
* Auditability
* Environment separation

## Definition of Done

* CloudWatch Log Group created
* KMS encryption enabled
* KMS key rotation enabled
* Configurable retention implemented
* Standard tags implemented
* Terraform validation passes
* Checkov validation passes
* Documentation completed
