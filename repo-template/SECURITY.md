# Security Policy

## Purpose

This repository follows the Acme Retail Ltd. platform security standards.

Security controls are integrated into the development and CI/CD lifecycle to identify secrets, vulnerabilities, and insecure infrastructure configurations early.

## Security Controls

The repository supports the following security controls:

- Gitleaks for secret detection
- Trivy for vulnerability scanning
- Checkov for Terraform security validation
- Protected branches and pull requests
- CODEOWNERS-based review
- Least-privilege access
- Secure Terraform defaults

## Reporting a Security Issue

Do not create a public GitHub issue for suspected security vulnerabilities.

Security issues should be reported through the organization's approved security reporting process.

Include:

- Description of the issue
- Affected component
- Steps to reproduce, where appropriate
- Potential impact
- Relevant logs or evidence without exposing sensitive credentials

## Secrets

Never commit:

- Passwords
- API keys
- Access tokens
- Cloud credentials
- Private keys
- Connection strings containing credentials

Use approved secret-management mechanisms and GitHub Actions secrets where appropriate.

## Vulnerability Handling

Security findings should be reviewed and remediated according to their severity and the organization's security policies.

False positives or temporary exceptions must be documented and handled through the approved exception process.

## Infrastructure Security

Terraform code must:

- Follow secure defaults
- Avoid unnecessary public access
- Use encryption where supported
- Follow least-privilege IAM principles
- Avoid hard-coded credentials
- Pass Checkov validation

## Security Ownership

Application teams own application-specific security.

The platform team owns shared platform controls, reusable workflows, Terraform modules, and security baselines.

## Review

This policy should be reviewed when platform security standards or organizational requirements change.
