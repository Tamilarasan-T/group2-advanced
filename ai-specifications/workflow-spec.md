# AI Engineering Specification — Reusable GitHub Actions Workflows

## 1. Document Information

| Field | Value |
|---|---|
| Specification | Reusable CI/CD and DevSecOps Workflows |
| Version | 1.0 |
| Status | Approved |
| Platform | Acme Retail Internal Developer Platform |
| CI/CD | GitHub Actions |
| Security | Gitleaks, Trivy, Checkov |
| Container | Docker |
| IaC | Terraform |

---

## 2. Purpose

Define reusable GitHub Actions workflows that standardize CI/CD, security validation and Terraform validation across application repositories.

Application teams should consume reusable workflows instead of duplicating complete pipeline implementations.

---

## 3. Business Problem

Independent application pipelines can create:

- Duplicate workflow code
- Inconsistent build and testing processes
- Inconsistent security scanning
- Different infrastructure validation
- Higher maintenance effort
- Longer onboarding

The platform provides centrally maintained reusable workflow capabilities.

---

## 4. Goals

The workflow platform must:

- Standardize CI/CD.
- Provide reusable GitHub Actions workflows.
- Integrate security scanning.
- Validate Terraform infrastructure.
- Support Docker image workflows.
- Provide clear pipeline failures.
- Minimize application-specific workflow code.
- Support multiple application teams.
- Follow least-privilege security practices.
- Protect secrets.
- Support controlled workflow versioning.

---

## 5. Non-Goals

The platform does not:

- Replace GitHub Actions.
- Store credentials in workflow source.
- Automatically deploy all applications to production.
- Allow arbitrary privileged workflow execution.
- Implement every programming language or framework.

---

## 6. Implemented Workflows

The repository currently provides:

```text
.github/workflows/
├── reusable-ci.yml
├── reusable-security.yml
├── reusable-terraform.yml
├── platform-ci.yml
├── terraform-validate.yml
├── terraform-consumer-validation.yml
└── template-validation.yml
````

### Reusable CI

`reusable-ci.yml`

Provides:

* Runtime setup
* Dependency installation
* Application tests
* Standard CI execution

### Reusable Security

`reusable-security.yml`

Provides:

* Gitleaks secret scanning
* Trivy filesystem scanning
* Conditional Trivy container image scanning

### Reusable Terraform

`reusable-terraform.yml`

Provides:

* Terraform format validation
* Terraform initialization
* Terraform validation
* Checkov scanning

### Platform CI

`platform-ci.yml`

Composes reusable CI, security and Terraform validation for the platform repository.

---

## 7. Standard Pipeline

The standard delivery flow is:

```text
Pull Request
     |
     v
Build & Test
     |
     v
Gitleaks
     |
     v
Trivy
     |
     v
Terraform Validation
     |
     v
Checkov
     |
     v
Docker Build
     |
     v
Image Scan
     |
     v
Approval
     |
     v
Deployment
```

Not every repository requires every stage.

Docker build and container image scanning are conditional capabilities and should run only for repositories that build container images.

---

## 8. CI Requirements

The CI workflow should:

1. Checkout source code.
2. Set up the required runtime.
3. Install dependencies.
4. Run application tests.
5. Fail when required tests fail.

Application-specific workflow logic should remain minimal.

---

## 9. Security Requirements

The security workflow must support:

* Gitleaks
* Trivy
* Checkov

Security failures must not be hidden.

### Gitleaks

Gitleaks must detect accidentally committed secrets.

The workflow must:

* Scan repository content.
* Fail when a confirmed secret is detected.
* Avoid exposing secrets in logs.
* Use reviewed allowlists for approved false positives.

### Trivy

Trivy should support:

* Filesystem scanning
* Container image scanning
* Configuration scanning where applicable

High/Critical vulnerabilities should be handled according to platform security policy.

### Checkov

Checkov must scan Terraform infrastructure for security and compliance issues.

Approved exceptions must be documented and reviewed.

---

## 10. Docker Requirements

Container builds must:

* Use a defined Dockerfile.
* Avoid embedded secrets.
* Prefer minimal base images.
* Use deterministic dependencies where practical.
* Run as a non-root user where practical.
* Be scanned before deployment.

Production images should use immutable identifiers such as the Git commit SHA.

Mutable tags such as `latest` should not be relied upon for production deployment.

---

## 11. Terraform Requirements

Terraform validation must include:

```text
terraform fmt -check
        |
        v
terraform init
        |
        v
terraform validate
        |
        v
Checkov
```

Production Terraform changes must require appropriate authorization.

Terraform plan output must not expose secrets.

---

## 12. Pull Request Requirements

Pull requests must execute required validation before merging.

Required checks should include, where applicable:

* Build
* Unit Tests
* Gitleaks
* Trivy
* Terraform validation
* Checkov

Branch protection must require relevant checks to pass before merging.

---

## 13. Deployment Requirements

Production deployment should follow:

```text
Build
  |
Validation
  |
Security
  |
Artifact
  |
Approval
  |
Deployment
```

Production deployments must use an explicit approval mechanism.

Unvalidated code must not be automatically deployed to production.

---

## 14. Permissions

Workflows must follow least privilege.

Default example:

```yaml
permissions:
  contents: read
```

Additional permissions should only be granted when required.

Avoid:

```yaml
permissions: write-all
```

unless there is a documented requirement.

---

## 15. Secret Management

Secrets must not be stored in:

* Workflow source
* Application source
* Dockerfiles
* Terraform files
* Logs

Approved mechanisms include:

* GitHub Actions secrets
* GitHub Environments
* AWS Secrets Manager
* AWS Systems Manager Parameter Store

Secrets must not be passed to steps unnecessarily.

---

## 16. Action Pinning

GitHub Actions should use trusted, controlled versions.

Where stronger supply-chain controls are required, actions should be pinned to immutable commit SHAs.

The platform should maintain an approved action list where practical.

---

## 17. Concurrency

Reusable workflows should use concurrency controls where appropriate.

Example:

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

Production deployment workflows should use additional safeguards where cancellation could cause an inconsistent deployment.

---

## 18. Workflow Inputs

Reusable workflows should expose only required inputs.

Example:

```yaml
workflow_call:
  inputs:
    application_name:
      required: true
      type: string

    run_tests:
      required: false
      type: boolean
      default: true
```

Inputs must have documented defaults and expected values.

---

## 19. Failure Handling

Pipeline failures must provide actionable information.

Failures should identify:

* Failed stage
* Failed tool
* Relevant error
* Recommended remediation where practical

Security failures must not be hidden.

---

## 20. Security Failure Policy

Default security handling:

```text
Critical → Fail
High     → Fail according to policy
Medium   → Report / policy dependent
Low      → Report
```

Approved exceptions must include:

* Finding
* Reason
* Owner
* Expiration date
* Approval

Permanent unexplained security exceptions are not permitted.

---

## 21. Reusability

Application repositories should contain minimal workflow implementation.

Reusable workflows should provide common:

* CI
* Security
* Terraform
* Container
* Deployment

capabilities.

Application repositories should consume platform workflows rather than copy their complete implementation.

---

## 22. Versioning

Reusable workflows must be version controlled.

For centrally hosted reusable workflows:

```text
v1
v1.1
v1.2
v2
```

Breaking changes require a new major version.

For workflows maintained in the same repository, changes are controlled through:

* Git history
* Pull requests
* Code review
* Protected branches

Applications should consume approved workflow versions or references.

---

## 23. Workflow Security

Workflows must protect against:

* Secret exposure
* Excessive permissions
* Untrusted pull-request code
* Dependency compromise
* Malicious action changes
* Artifact tampering

Fork-based pull requests must not receive access to sensitive repository secrets.

---

## 24. Validation

Workflow configuration should be validated through:

* YAML validation
* GitHub Actions workflow validation
* Terraform validation
* Security scanning
* Docker validation where applicable

GitHub Actions execution provides final integration validation.

---

## 25. Observability

Workflow execution should provide:

* Clear job names
* Clear step names
* Useful logs
* Security results
* Test results
* Deployment status

Sensitive values must be masked.

---

## 26. Acceptance Criteria

The workflow platform is accepted when:

* [ ] Application repositories can consume reusable workflows.
* [ ] Complete CI/CD implementation is not duplicated.
* [ ] Gitleaks is integrated.
* [ ] Trivy is integrated.
* [ ] Checkov is integrated for Terraform.
* [ ] Terraform formatting and validation are automated.
* [ ] Container images can be scanned where applicable.
* [ ] Production deployment has appropriate approval.
* [ ] Workflow permissions follow least privilege.
* [ ] Secrets are not stored in workflow source.
* [ ] Workflows are version controlled.
* [ ] Security failures can block pipelines.
* [ ] Pipeline failures provide useful information.
* [ ] Multiple applications can consume the same workflow capabilities.

---

## 27. Definition of Done

The workflow platform is complete when:

* Reusable CI workflow is implemented.
* Reusable security workflow is implemented.
* Reusable Terraform workflow is implemented.
* Platform CI consumes the reusable workflows.
* Gitleaks is operational.
* Trivy is operational.
* Checkov is operational.
* Terraform validation is automated.
* Workflow permissions are minimized.
* Workflow versioning is defined.
* Orders API can consume the reusable capabilities.
* Payments API can consume the same capabilities.
* Documentation is complete.
* Validation evidence is available.
