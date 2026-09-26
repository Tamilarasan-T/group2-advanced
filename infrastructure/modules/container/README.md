# Container Terraform Module

## Overview

This module provides a reusable and secure AWS container registry capability using Amazon ECR.

The module is designed for platform-level reuse across multiple application teams and environments.

## Capabilities

The module provides:

- Amazon ECR repository
- Immutable image tags
- Image scanning on push
- KMS encryption
- Automatic KMS key rotation
- ECR lifecycle management
- Secure-by-default configuration
- Standard resource tagging

## Security Standards

The module follows these security principles:

- ECR images are encrypted using AWS KMS.
- KMS key rotation is enabled.
- Image scanning is enabled on push.
- Image tags are immutable.
- Repository deletion is protected by default.
- Untagged images are automatically cleaned up.
- No public ECR repository configuration is created.
- No credentials or secrets are stored in Terraform.
- Resource tags are standardized.

## Usage

Example:

module "container" {
  source = "../../modules/container"

  name        = "orders-api"
  environment = "dev"

  tags = {
    Owner      = "Platform"
    CostCenter = "Engineering"
  }
}

## Lifecycle Policy

The default lifecycle policy:

* Removes untagged images older than 7 days.
* Keeps the latest 30 images using version tags beginning with `v`.

## Inputs

| Name         | Description                              | Type        | Default  |
| ------------ | ---------------------------------------- | ----------- | -------- |
| name         | Application or platform name             | string      | Required |
| environment  | Deployment environment                   | string      | Required |
| force_delete | Delete repository even when images exist | bool        | false    |
| tags         | Additional resource tags                 | map(string) | {}       |

## Outputs

| Output          | Description             |
| --------------- | ----------------------- |
| repository_name | ECR repository name     |
| repository_arn  | ECR repository ARN      |
| repository_url  | ECR repository URL      |
| registry_id     | AWS account registry ID |
| kms_key_arn     | KMS key ARN             |

## Validation

The module must pass:

1. Terraform formatting
2. Terraform initialization
3. Terraform validation
4. Checkov security scanning

## Reusability

The module is designed to support multiple application teams without modifying the module implementation.

Example consumers:

* orders-api
* payments-api
* customer-api

Each application can create an isolated ECR repository using the same module.

## Definition of Done

* ECR repository created
* Immutable image tags enabled
* Image scanning enabled
* KMS encryption enabled
* KMS rotation enabled
* Lifecycle policy configured
* Terraform validation passes
* Checkov validation passes
* Documentation completed
