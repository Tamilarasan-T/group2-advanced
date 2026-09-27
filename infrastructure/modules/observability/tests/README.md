# Observability Module Tests

## Purpose

This directory contains validation guidance for the reusable Observability Terraform module.

## Validation

The Observability module is validated using:

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
- Create a reusable CloudWatch Log Group.
- Support configurable log retention.
- Encrypt logs using AWS KMS.
- Avoid application-specific configuration.

## Security Expectations

The module must maintain:

- KMS encryption
- KMS key rotation
- Restricted KMS policy conditions
- Configurable CloudWatch retention
- Standard resource tagging
- No hard-coded credentials
