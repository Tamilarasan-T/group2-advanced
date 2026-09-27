# Branch Protection Policy

## Purpose

Define minimum branch protection requirements for repositories using the Acme Retail Internal Developer Platform.

## Protected Branches

- `main`
- Production release branches, if used

## Requirements

Changes to protected branches must use Pull Requests.

Required controls:

- At least 1 approval
- Required CI/security checks
- CODEOWNERS review where applicable
- Conversation resolution
- Force pushes disabled
- Branch deletion disabled

## Required Checks

### Application

- Reusable CI
- Gitleaks
- Trivy
- Container scan when applicable

### Infrastructure

- Terraform Format
- Terraform Validate
- Checkov

### Repository Template

- Tests
- Docker Build
- Template Validation

## Security-Sensitive Changes

Appropriate owner review is required for:

- IAM
- Authentication/authorization
- Secrets
- Network security
- Terraform
- Container security
- Production configuration
- Security scanning

## Emergency Changes

Emergency changes must:

- Be authorized and documented.
- Record the reason for the exception.
- Receive appropriate owner approval.
- Be reviewed retrospectively.

## Auditability

Retain evidence of:

- PR reviews and approvals
- CI/security results
- CODEOWNERS reviews
- Merge events
- Emergency exceptions

## Responsibilities

**Application Teams:** Application code, tests and security remediation.

**Platform Team:** Workflows, Terraform modules, repository standards and governance.

**Security Team:** Security guidance, exceptions and vulnerability governance.

## Compliance

A repository is compliant when protected branches, PR reviews, required checks, CODEOWNERS, force-push restrictions and auditability are configured.
