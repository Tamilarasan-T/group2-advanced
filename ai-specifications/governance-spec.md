# AI Engineering Specification — Governance

## 1. Purpose

This specification defines the governance controls required for the Acme Retail Ltd. Internal Developer Platform.

The governance model establishes consistent rules for source control, pull requests, security, infrastructure changes, approvals, exceptions, and auditability.

The objective is to provide appropriate controls without preventing application teams from developing independently.

---

## 2. Business Problem

Application teams currently have different development and infrastructure practices.

Without common governance:

- Branch protection may differ between repositories.
- Pull request reviews may be inconsistent.
- Security checks may be skipped.
- Terraform changes may not receive appropriate review.
- Emergency changes may not be documented consistently.
- Ownership may be unclear.
- Exceptions may remain indefinitely.
- Audit evidence may be incomplete.

The platform must establish a consistent governance baseline.

---

## 3. Goals

The governance model must:

1. Protect important branches.
2. Require appropriate pull request reviews.
3. Define repository ownership.
4. Require automated quality and security checks.
5. Establish Terraform governance.
6. Protect secrets and sensitive configuration.
7. Define an exception-management process.
8. Provide production-change controls.
9. Maintain auditability.
10. Clearly define platform and application ownership.

---

## 4. Non-Goals

Governance will not:

- Own application business logic.
- Replace the organization's security policies.
- Prevent legitimate emergency changes.
- Require every application to use identical application-specific testing.
- Centralize all application-team decisions.
- Grant unnecessary platform permissions.

---

## 5. Branch Protection

The `main` branch must be protected.

The following controls should be configured:

- Direct pushes restricted.
- Pull requests required for normal changes.
- Required status checks enabled.
- Required approvals configured.
- CODEOWNERS review required where applicable.
- Force pushes disabled.
- Branch deletion disabled.
- Stale approvals invalidated when configured changes require renewed review.

Production-related repositories may require additional approval controls.

---

## 6. Pull Request Policy

All normal changes should be submitted through pull requests.

A pull request should contain:

- Summary of changes
- Reason for the change
- Testing performed
- Security impact
- Infrastructure impact, if applicable
- Documentation impact
- Required reviewers

Pull requests should be:

- Small enough to review effectively.
- Linked to the relevant work item where applicable.
- Tested before merge.
- Reviewed by appropriate owners.

---

## 7. CODEOWNERS

Repositories should define ownership using CODEOWNERS.

CODEOWNERS should identify:

- Platform owners
- Application owners
- Security owners where required
- Infrastructure owners where required

Changes to platform-owned components should require review from the appropriate platform owners.

---

## 8. Required Quality Gates

The following automated checks should be used where applicable:

### Application

- Automated tests
- Build validation

### Security

- Gitleaks
- Trivy
- Checkov

### Terraform

- `terraform fmt`
- `terraform init`
- `terraform validate`
- Checkov

Required checks must pass before protected changes are merged.

---

## 9. Security Governance

Repositories must follow security-by-default principles.

The platform must:

- Prevent committed credentials.
- Scan source files for secrets.
- Scan dependencies and files for vulnerabilities.
- Scan container images where applicable.
- Scan Terraform infrastructure.
- Use least-privilege permissions.
- Use encryption where supported.
- Avoid unnecessary public access.

Security findings must be reviewed according to their severity and organizational security requirements.

---

## 10. Secret Management

Secrets must never be committed to Git.

Examples include:

- Passwords
- API keys
- Access tokens
- Private keys
- Cloud credentials
- Database credentials

Approved secret-management mechanisms should be used.

GitHub Actions secrets or an approved external secret-management system should be used for CI/CD secrets.

Secrets should have appropriate access restrictions and rotation procedures.

---

## 11. Terraform Governance

Terraform must be managed through source control and pull requests.

Terraform changes must:

- Follow module standards.
- Pass formatting validation.
- Pass initialization.
- Pass validation.
- Pass Checkov.
- Follow tagging standards.
- Avoid hard-coded credentials.
- Follow least-privilege principles.
- Avoid unnecessary public exposure.

Terraform state files must not be committed.

Terraform dependency lock files should remain version-controlled for reproducible provider selection.

Production infrastructure changes require appropriate review and approval.

---

## 12. Infrastructure Ownership

The platform team owns reusable infrastructure capabilities including:

- Terraform modules
- Shared infrastructure patterns
- Terraform security standards
- Module documentation

Application teams own application-specific infrastructure configuration and requirements.

Changes to shared modules must consider their impact on existing consumers.

---

## 13. Dependency and Vulnerability Management

Dependencies should be reviewed and updated regularly.

Security scanning should identify:

- Known vulnerabilities
- Vulnerable dependencies
- Vulnerable container images
- Insecure infrastructure configurations

Critical security issues should be prioritized according to organizational security policy.

Dependency updates should be tested before merging.

---

## 14. Exception Process

A security, governance, or platform-standard exception may be requested when a documented requirement cannot reasonably be followed.

An exception request should include:

- Requester
- Repository or system
- Requirement being bypassed
- Business or technical reason
- Risk description
- Compensating controls
- Requested duration
- Remediation plan
- Required approval

Exceptions should be:

- Explicitly approved.
- Time-limited.
- Documented.
- Reviewed before expiration.
- Remediated when the exception is no longer required.

---

## 15. Emergency Changes

Emergency changes may bypass normal procedures when required to restore service or address a critical security issue.

Emergency changes must still:

1. Be authorized by the appropriate owner.
2. Minimize the scope of the change.
3. Be documented.
4. Be reviewed retrospectively.
5. Complete normal validation after the emergency.
6. Record any follow-up remediation.

Emergency procedures must not become the normal development process.

---

## 16. Production Approvals

Production changes should require appropriate approval based on organizational risk.

The approval process should consider:

- Change scope
- Security impact
- Infrastructure impact
- Application impact
- Testing results
- Rollback strategy

Production deployments should be traceable to an approved change.

---

## 17. Auditability

The platform must maintain an auditable history of important changes.

Evidence should include:

- Git commits
- Pull requests
- Review approvals
- CI/CD results
- Security scan results
- Terraform validation
- Deployment records
- Exception approvals

Audit records should be retained according to organizational requirements.

---

## 18. Access Control

Platform access must follow least privilege.

Users and teams should receive only the permissions required for their responsibilities.

Administrative permissions should be limited to authorized platform or organizational administrators.

Access should be reviewed periodically.

---

## 19. Platform Versioning

Governed platform components should be versioned.

Versioning applies to:

- Terraform modules
- Reusable workflows
- Repository templates
- Governance standards where applicable

Breaking changes must be documented.

Consumers should be given an upgrade path.

---

## 20. Responsibilities

### Platform Team

Responsible for:

- Platform governance
- Reusable workflows
- Terraform modules
- Repository templates
- Platform security controls
- Governance documentation

### Application Teams

Responsible for:

- Application code
- Application tests
- Application-specific configuration
- Following platform standards
- Addressing application security findings

### Security Team

Responsible for:

- Security standards
- Security guidance
- Security reviews
- Security exception oversight

### Engineering Management

Responsible for:

- Ensuring teams follow governance requirements.
- Supporting remediation of significant risks.
- Approving organizational exceptions where required.

---

## 21. Acceptance Criteria

The governance implementation is accepted when:

- Main branch protection requirements are documented.
- Pull request standards are documented.
- CODEOWNERS requirements are documented.
- Required quality and security gates are defined.
- Terraform governance is documented.
- Secret-management requirements are defined.
- Dependency and vulnerability management is documented.
- Exception management is documented.
- Emergency change procedures are documented.
- Production approval requirements are documented.
- Auditability requirements are defined.
- Responsibilities are clearly assigned.

---

## 22. Definition of Done

Governance is considered implemented when:

- Governance specifications are documented.
- Branch protection guidance is available.
- Pull request policy is available.
- Security policy is available.
- Exception process is available.
- Repository ownership is defined.
- CI/CD security gates are implemented.
- Terraform governance is implemented.
- Developer-facing governance documentation is available.
- Governance requirements are validated during repository and platform reviews.
