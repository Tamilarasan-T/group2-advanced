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

```hcl
module "container" {
  source = "../../modules/container"

  name        = "orders-api"
  environment = "dev"

  tags = {
    Owner      = "Platform"
    CostCenter = "Engineering"
  }
}
