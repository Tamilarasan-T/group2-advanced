# IAM Module Tests

## Purpose

This directory contains validation guidance for the reusable IAM Terraform module.

## Validation

The IAM module is validated using:

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
- Support multiple trusted AWS compute services.
- Support configurable IAM policy statements.
- Avoid hard-coded credentials.
- Follow least-privilege principles.

## Security Expectations

The module must maintain:

- Restricted trusted services
- Configurable session duration
- No hard-coded credentials
- Least-privilege IAM policies
- Optional instance profile creation
- Standard resource tagging
