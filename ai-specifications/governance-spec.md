# AI Engineering Specification — Governance

## 1. Purpose

Define governance standards for source control, security, infrastructure, approvals, ownership and auditability across the Acme Retail Internal Developer Platform.

## 2. Business Problem

Inconsistent governance can cause:

- Weak branch protection
- Inconsistent reviews
- Skipped security checks
- Uncontrolled Terraform changes
- Unclear ownership
- Poor auditability

## 3. Goals

- Protect important branches.
- Require appropriate PR reviews.
- Define ownership.
- Enforce quality and security gates.
- Govern Terraform changes.
- Protect secrets.
- Manage exceptions.
- Control production changes.
- Maintain auditability.

## 4. Branch Protection

`main` must be protected.

Required controls:

- PR required for normal changes.
- Required status checks.
- Required approvals.
- CODEOWNERS review where applicable.
- Force pushes disabled.
- Branch deletion disabled.

## 5. Pull Requests

Normal changes must use PRs.

PRs should include:

- Change summary
- Testing
- Security impact
- Infrastructure impact
- Documentation impact
- Required reviewers

Changes must pass required checks before merge.

## 6. CODEOWNERS

Repositories should define owners for:

- Platform
- Application
- Security
- Infrastructure

Platform-owned components require appropriate owner review.

## 7. Quality and Security Gates

Required checks where applicable:

```text
Application → Build + Tests
Security    → Gitleaks + Trivy
Terraform   → fmt + init + validate + Checkov
````

Required checks must pass before protected changes are merged.

## 8. Security Governance

Repositories must:

* Prevent committed credentials.
* Scan secrets and vulnerabilities.
* Scan container images where applicable.
* Scan Terraform.
* Use least privilege.
* Encrypt supported resources.
* Avoid unnecessary public access.

## 9. Secret Management

Secrets must never be committed to Git.

Use approved mechanisms such as:

* GitHub Secrets
* GitHub Environments
* AWS Secrets Manager
* AWS Systems Manager Parameter Store

## 10. Terraform Governance

Terraform changes must:

* Use source control and PRs.
* Pass formatting and validation.
* Pass Checkov.
* Follow tagging standards.
* Use least privilege.
* Avoid hard-coded credentials.
* Avoid unnecessary public exposure.

Terraform state must not be committed.

Terraform lock files should remain version controlled.

## 11. Ownership

**Platform Team**

* Reusable workflows
* Terraform modules
* Repository templates
* Platform security
* Governance documentation

**Application Teams**

* Application code
* Tests
* Application configuration
* Application security remediation

**Security Team**

* Security standards
* Security reviews
* Security exceptions

## 12. Dependencies and Vulnerabilities

Dependencies, container images and infrastructure must be regularly scanned.

Critical findings must be handled according to organizational security policy.

Dependency updates must be tested before merging.

## 13. Exception Process

Exceptions must include:

* Requirement being bypassed
* Reason
* Risk
* Compensating controls
* Duration
* Remediation plan
* Approval

Exceptions must be approved, documented, time-limited and reviewed.

## 14. Emergency Changes

Emergency changes may bypass normal procedures when required for service recovery or critical security issues.

They must still be:

* Authorized
* Minimized
* Documented
* Retrospectively reviewed
* Validated afterward

## 15. Production Changes

Production changes should have appropriate approval based on:

* Change scope
* Security impact
* Infrastructure impact
* Testing results
* Rollback strategy

Deployments must be traceable to an approved change.

## 16. Auditability

Maintain evidence of:

* Commits
* PRs
* Approvals
* CI/CD results
* Security scans
* Terraform validation
* Deployments
* Exceptions

## 17. Access and Versioning

Access must follow least privilege.

Governed components should be versioned:

```text
Terraform Modules
Reusable Workflows
Repository Templates
Governance Standards
```

Breaking changes must be documented with an upgrade path.

## 18. Acceptance Criteria / Definition of Done

* [ ] Branch protection is defined.
* [ ] PR policy is defined.
* [ ] CODEOWNERS requirements are defined.
* [ ] Security gates are implemented.
* [ ] Terraform governance is implemented.
* [ ] Secret management is defined.
* [ ] Exception process is defined.
* [ ] Emergency change process is defined.
* [ ] Production approvals are defined.
* [ ] Auditability is maintained.
* [ ] Responsibilities are assigned.
* [ ] Governance documentation is available.
