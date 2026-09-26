# Branch Protection Policy

## Purpose

This policy defines the minimum branch protection controls required for repositories onboarded to the Acme Retail Internal Developer Platform.

The objective is to prevent unauthorized or unreviewed changes from being merged into protected branches.

## Protected Branches

The following branches require protection:

- `main`
- Production release branches, if used

Application teams may use additional development branches according to their team's workflow.

## Pull Request Requirement

Direct pushes to `main` are prohibited.

All changes must be submitted through a Pull Request.

A Pull Request must:

1. Contain a clear description of the change.
2. Reference the related issue, task, or requirement when applicable.
3. Pass all required automated checks.
4. Receive the required approvals.
5. Have no unresolved required review comments.
6. Meet the repository's CODEOWNERS requirements.

## Required Approvals

The default minimum requirement is:

- At least 1 approving review for normal changes.
- Additional approval may be required for production, security-sensitive, or infrastructure changes.

Required reviewers should be defined through `CODEOWNERS` where appropriate.

## Required Status Checks

The following checks should be required before merging where applicable:

### Application repositories

- Reusable CI
- Gitleaks Secret Scan
- Trivy Filesystem Scan
- Container Image Scan when an image is produced

### Infrastructure repositories

- Terraform Format Check
- Terraform Validate
- Checkov

### Repository templates

- Python Tests
- Docker Build
- Template Structure Validation

## Branch Protection Controls

Protected branches should enforce:

- Pull Request before merging
- Required approving reviews
- Required status checks
- CODEOWNERS review where applicable
- Conversation resolution before merge
- No force pushes
- No branch deletion
- Linear history where organizationally required

Repository administrators should not bypass protection except through an approved emergency process.

## Security-Sensitive Changes

Changes involving the following areas require appropriate owner review:

- IAM policies
- Authentication and authorization
- Secrets management
- Network security
- Terraform infrastructure
- Container security
- Production deployment configuration
- Security scanning configuration

## Emergency Changes

Emergency changes may use an approved emergency procedure when delaying the change would create significant operational or security risk.

Emergency changes must:

1. Be documented.
2. Identify the reason for bypassing the normal process.
3. Receive appropriate owner approval.
4. Be reviewed retrospectively.
5. Have follow-up actions documented when required.

Emergency access must not become a permanent alternative to normal governance.

## Auditability

The platform should retain evidence of:

- Pull Request reviews
- Approvals
- Status check results
- Merge events
- CODEOWNERS reviews
- Emergency exceptions

Repository and organization audit logs should be used where available.

## Responsibilities

### Application Teams

Application teams are responsible for:

- Following the branch protection policy.
- Creating Pull Requests.
- Responding to review feedback.
- Maintaining application tests.
- Resolving security findings.

### Platform Engineering

Platform Engineering is responsible for:

- Maintaining reusable workflows.
- Maintaining repository standards.
- Maintaining Terraform modules.
- Defining platform-wide governance requirements.
- Reviewing governance exceptions.

### Security Team

The Security team provides guidance for:

- Security-sensitive changes.
- Security exceptions.
- Vulnerability management.
- Compliance requirements.

## Policy Review

This policy should be reviewed periodically and updated when:

- Platform capabilities change.
- Security requirements change.
- GitHub governance capabilities change.
- Audit findings identify gaps.
- Organizational engineering standards change.

## Definition of Done

A repository is considered compliant when:

- `main` is protected.
- Direct pushes are restricted.
- Pull Requests are required.
- Required reviews are configured.
- Required CI/security checks are configured.
- CODEOWNERS is configured where required.
- Force pushes are disabled.
- Emergency exceptions are documented.
- Repository changes are auditable.
