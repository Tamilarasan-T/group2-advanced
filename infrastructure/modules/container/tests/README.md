# Container Module Tests

## Purpose

This directory contains validation guidance for the reusable Container Terraform module.

## Validation

The Container module is validated using:

- Terraform formatting
- Terraform initialization
- Terraform validation
- Checkov security scanning
- Consumer integration validation

## Validation Command

The module is validated through the platform Terraform validation workflow:

`.github/workflows/terraform-validate.yml`

The module is also consumed by application examples under:

`infrastructure/examples/`

## Expected Result

The module must:

- Pass Terraform formatting checks.
- Pass Terraform validation.
- Pass Checkov security scanning.
- Create a reusable Amazon ECR repository.
- Support immutable container image tags.
- Enable image scanning on push.
- Apply a lifecycle policy for image cleanup.
- Avoid application-specific configuration.

## Security Expectations

The module must maintain:

- KMS encryption
- KMS key rotation
- ECR image scanning
- Immutable image tags
- Controlled repository deletion
- Standard resource tagging
- No hard-coded credentials
