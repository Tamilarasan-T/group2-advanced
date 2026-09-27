# Pull Request Policy

## Purpose

Ensure application and infrastructure changes are reviewed, tested, secure and traceable before merging.

## Requirements

All changes to protected branches must use Pull Requests.

A PR should include:

- Change description
- Reason for change
- Related issue/task where applicable
- Testing performed
- Security/infrastructure impact where applicable

## Review

Default requirement:

- Minimum 1 approval
- CODEOWNERS approval where applicable

Additional review may be required for:

- Production infrastructure
- IAM
- Security controls
- Network changes
- Authentication/authorization
- Secrets
- Major platform changes

## Automated Checks

### Application

- Build and tests
- Gitleaks
- Trivy
- Container scan when applicable

### Terraform

- Terraform Format
- Terraform Validate
- Checkov

### Repository Template

- Tests
- Docker Build
- Template Validation

Required checks must pass before merge.

## Reviewer Checks

Reviewers should verify:

- Code quality and maintainability
- Security and least privilege
- No committed secrets
- Appropriate tests
- Terraform standards and secure defaults
- Infrastructure impact

## Merge Requirements

Before merging:

- Required approvals received
- Required checks passed
- Required conversations resolved
- CODEOWNERS approval received where applicable
- Security requirements satisfied

## Infrastructure Changes

PRs should identify:

- Resources affected
- Environment
- Security impact
- Potential downtime
- Cost impact
- Terraform plan impact where available

## Emergency Changes

Emergency changes must follow the approved emergency process and receive retrospective review.

## Traceability

```text
Requirement
    ↓
Issue / Task
    ↓
Pull Request
    ↓
Validation
    ↓
Review
    ↓
Merge
    ↓
Deployment
