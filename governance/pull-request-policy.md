# Pull Request Policy

## Purpose

This policy defines the standard Pull Request process for application and infrastructure repositories onboarded to the Acme Retail Internal Developer Platform.

The goal is to ensure that changes are reviewed, tested, secure, and traceable before being merged.

## Pull Request Creation

All changes to protected branches must be submitted through a Pull Request.

Each Pull Request should contain:

- Clear title
- Description of the change
- Reason for the change
- Related issue, task, or requirement when applicable
- Testing performed
- Security impact, when applicable
- Infrastructure impact, when applicable

## Pull Request Types

Common Pull Request types include:

- Feature
- Bug fix
- Infrastructure change
- Security change
- Documentation
- Dependency update
- Configuration change
- Refactoring

## Review Requirements

A Pull Request must receive the required approval before merging.

The default requirement is:

- Minimum 1 approving reviewer
- CODEOWNERS approval for owned areas where configured

Additional approvals may be required for:

- Production infrastructure
- IAM changes
- Security controls
- Network changes
- Authentication or authorization
- Secrets management
- Major platform changes

## Automated Validation

Pull Requests must pass applicable automated checks.

### Application Changes

Expected checks include:

- Build
- Unit tests
- Gitleaks
- Trivy filesystem scan
- Container image scan when applicable

### Terraform Changes

Expected checks include:

- Terraform formatting
- Terraform initialization
- Terraform validation
- Checkov security scanning

### Repository Template Changes

Expected checks include:

- Python tests
- Docker build
- Template structure validation

## Review Responsibilities

Reviewers should verify:

### Code Quality

- Implementation follows repository standards.
- Code is maintainable.
- No unnecessary duplication is introduced.
- Error handling is appropriate.

### Security

- No secrets are committed.
- IAM permissions follow least privilege.
- Sensitive data is protected.
- Dependencies do not introduce unacceptable vulnerabilities.
- Infrastructure follows security standards.

### Infrastructure

For Terraform changes:

- Resources are reusable.
- Secure defaults are maintained.
- Naming and tagging standards are followed.
- No credentials are hardcoded.
- Destructive changes are understood.

## Testing

The Pull Request author is responsible for ensuring that appropriate tests are added or updated.

Tests should cover the behavior affected by the change.

A Pull Request should not be merged when required tests are failing.

## Review Comments

Required review comments must be resolved before merging.

Authors should respond to reviewer feedback with:

- Code changes
- Explanation
- Additional documentation
- Or an agreed technical decision

## Merge Requirements

Before merging, the Pull Request must satisfy all applicable requirements:

- Required approvals received
- Required status checks passed
- Required conversations resolved
- Required CODEOWNERS approvals received
- No unresolved blocking issues
- Security requirements satisfied

## Merge Strategy

The repository should use the organization's approved merge strategy.

Where appropriate, squash merging is preferred for application Pull Requests to maintain a clean main branch history.

The selected strategy should be applied consistently across repositories.

## Dependency Changes

Dependency updates must:

- Use approved package sources.
- Pass security scanning.
- Pass automated tests.
- Avoid unnecessary version changes.
- Be reviewed when security or production impact exists.

## Infrastructure Changes

Infrastructure Pull Requests must clearly identify:

- Resources affected
- Environment affected
- Security impact
- Potential downtime
- Potential cost impact
- Terraform plan impact when available

Production infrastructure changes require the appropriate approval process.

## Emergency Pull Requests

Emergency changes may follow the approved emergency change process when immediate action is required.

The Pull Request must still be documented and reviewed retrospectively.

## Traceability

Pull Requests should provide traceability between:


Requirement
    ↓
Issue / Task
    ↓
Pull Request
    ↓
Automated Validation
    ↓
Review
    ↓
Merge
    ↓
Deployment

This provides an auditable engineering workflow.

Responsibilities
Pull Request Author

Responsible for:

Providing complete context.
Adding appropriate tests.
Responding to reviews.
Fixing security and quality issues.
Ensuring the Pull Request is ready for review.
Reviewer

Responsible for:

Reviewing correctness.
Reviewing security implications.
Checking maintainability.
Verifying tests and validation.
Raising concerns when requirements are not satisfied.
Platform Engineering

Responsible for:

Maintaining reusable workflows.
Maintaining repository standards.
Maintaining platform governance.
Updating validation requirements.
Definition of Done

A Pull Request is ready to merge when:

Required approvals are complete.
Required automated checks pass.
Security scanning passes.
Required conversations are resolved.
Documentation is updated where necessary.
Infrastructure changes have been reviewed where applicable.
The change is traceable to its requirement or task.
