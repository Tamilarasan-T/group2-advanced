# Network Module Tests

## Purpose

This directory contains validation guidance for the reusable Network Terraform module.

## Validation

The Network module is validated using:

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
- Support consumption by multiple application teams.
- Avoid application-specific configuration.

## Security Expectations

The module must maintain:

- VPC Flow Logs
- KMS encryption
- Restricted default security group
- Explicit Availability Zones
- Secure routing configuration
- Configurable log retention
