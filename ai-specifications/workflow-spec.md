# AI Engineering Specification — Reusable GitHub Actions Workflows

## 1. Document Information

| Field         | Value                                   |
| ------------- | --------------------------------------- |
| Specification | Reusable CI/CD and DevSecOps Workflows  |
| Version       | 1.0                                     |
| Status        | Draft                                   |
| Platform      | Acme Retail Internal Developer Platform |
| CI/CD         | GitHub Actions                          |
| Security      | Gitleaks, Trivy, Checkov                |
| Container     | Docker                                  |
| IaC           | Terraform                               |

---

# 2. Purpose

This specification defines reusable GitHub Actions workflows for the Acme Retail Internal Developer Platform.

The objective is to eliminate duplicated CI/CD pipeline implementations across application repositories and establish a standardized, secure, maintainable software delivery process.

Application teams must consume reusable workflows rather than independently copying and maintaining complete CI/CD pipeline implementations.

---

# 3. Business Problem

Acme Retail application teams currently maintain separate CI/CD pipelines.

This creates:

* Duplicate workflow code
* Different build processes
* Inconsistent security scanning
* Different testing approaches
* Difficult pipeline maintenance
* Inconsistent deployment processes
* Increased onboarding time
* Security and compliance gaps

The platform will provide centrally maintained reusable workflows.

---

# 4. Goals

The workflow platform must:

1. Provide reusable GitHub Actions workflows.
2. Standardize CI/CD across applications.
3. Integrate security scanning.
4. Integrate Terraform validation.
5. Support Docker image building.
6. Provide clear pipeline failures.
7. Minimize application-specific workflow code.
8. Support multiple application teams.
9. Use secure GitHub Actions practices.
10. Support local/static workflow validation.
11. Support versioning.
12. Prevent secrets from being exposed in logs.

---

# 5. Non-Goals

The initial implementation will not:

* Build a custom CI/CD platform.
* Replace GitHub Actions.
* Allow arbitrary privileged workflow execution.
* Store credentials directly in workflow files.
* Automatically deploy every application to production without approval.
* Implement every programming language or framework.

---

# 6. Workflow Architecture

The platform should provide reusable workflows for major delivery stages.

```text id="a7v2jw"
.github/
└── workflows/
    ├── ci.yml
    ├── security.yml
    ├── terraform.yml
    └── release.yml
```

Where practical, reusable workflows should be implemented using GitHub Actions reusable workflow functionality.

---

# 7. Standard Pipeline

The standard application pipeline should follow:

```text
Pull Request
     │
     ▼
Checkout
     │
     ▼
Build
     │
     ▼
Unit Tests
     │
     ▼
Gitleaks
     │
     ▼
Trivy
     │
     ▼
Checkov
     │
     ▼
Terraform Validate
     │
     ▼
Docker Build
     │
     ▼
Image Scan
     │
     ▼
Review / Approval
     │
     ▼
Deployment
```

Not every stage must execute for every repository type.

Workflow inputs should determine which capabilities are required.

---

# 8. CI Workflow

## Purpose

Provide standardized application build and test execution.

The CI workflow should:

1. Checkout source code.
2. Set up the required runtime.
3. Install dependencies.
4. Build the application.
5. Execute unit tests.
6. Publish test results where appropriate.

Example interface:

```yaml
jobs:
  ci:
    uses: organization/platform-workflows/.github/workflows/ci.yml@v1
    with:
      language: python
      run_tests: true
```

The actual implementation must be adapted to the selected repository architecture.

---

# 9. Security Workflow

The security workflow must provide standardized security checks.

Required tools:

```text
Gitleaks
Trivy
Checkov
```

The workflow should perform:

```text
Source
  │
  ├── Gitleaks
  │
  ├── Trivy filesystem scan
  │
  └── Checkov
```

Container scanning should occur after the Docker image has been built.

---

# 10. Gitleaks Requirements

Gitleaks must detect accidentally committed secrets.

It should scan:

* Source code
* Configuration files
* Git history where appropriate

The workflow must fail when a confirmed secret is detected according to the platform security policy.

Secrets must never be printed in workflow logs.

False positives must be handled through an explicit reviewed allowlist mechanism rather than disabling the scanner.

---

# 11. Trivy Requirements

Trivy must be used for vulnerability scanning.

The platform should support:

* Filesystem scanning
* Container image scanning
* Configuration scanning where appropriate

Example:

```text
Docker Build
     ↓
Trivy Image Scan
     ↓
Security Policy
     ↓
Pass / Fail
```

Severity thresholds must be configurable by platform governance.

Critical vulnerabilities should fail the pipeline unless an approved exception exists.

---

# 12. Checkov Requirements

Checkov must scan Terraform infrastructure.

Example:

```text
Terraform
    ↓
Checkov
    ↓
Security Findings
    ↓
Policy Evaluation
```

Checkov must execute before infrastructure changes are approved for deployment.

Security exceptions must be documented and reviewed.

---

# 13. Docker Build Requirements

Container builds must:

* Use a defined Dockerfile.
* Avoid embedding secrets.
* Prefer minimal base images.
* Use deterministic dependencies where practical.
* Run as a non-root user where practical.
* Be scanned before deployment.

The workflow should tag images using immutable identifiers such as the Git commit SHA.

Example:

```text
ims:<commit-sha>
```

The use of only mutable tags such as `latest` should not be relied upon for production deployment.

---

# 14. Terraform Workflow

The Terraform workflow must perform:

```text
terraform fmt -check
        ↓
terraform init
        ↓
terraform validate
        ↓
Checkov
        ↓
terraform plan
```

Terraform plan output must not expose secrets.

Production apply must require appropriate authorization.

---

# 15. Pull Request Workflow

Pull requests must execute required validation before merging.

Minimum checks:

```text
Build
Unit Tests
Gitleaks
Trivy
Checkov
Terraform Validation
```

Branch protection should require relevant checks to pass before merging.

---

# 16. Deployment Workflow

The deployment workflow must separate:

```text
Build
  ↓
Validation
  ↓
Security
  ↓
Artifact
  ↓
Approval
  ↓
Deployment
```

Production deployments must require an explicit approval mechanism.

The workflow must not automatically deploy unvalidated code.

---

# 17. Permissions

GitHub Actions workflows must follow least privilege.

Workflows should explicitly define permissions.

Example:

```yaml
permissions:
  contents: read
```

Additional permissions must only be granted when required.

Avoid:

```yaml
permissions: write-all
```

unless there is a documented requirement.

---

# 18. Secret Management

Secrets must not be stored in:

* Workflow source
* Repository source code
* Dockerfiles
* Terraform files
* Logs

GitHub Actions secrets or an appropriate external secret-management mechanism must be used.

Secrets must not be passed to steps unnecessarily.

---

# 19. Action Pinning

Third-party GitHub Actions should be pinned to trusted versions.

Where organizational policy requires stronger supply-chain controls, actions should be pinned to immutable commit SHAs.

Example:

```yaml
uses: actions/checkout@<trusted-version-or-commit>
```

The platform should maintain an approved action list where practical.

---

# 20. Concurrency

Workflows should use concurrency controls where appropriate to prevent unnecessary duplicate executions.

Example:

```yaml
concurrency:
  group: ${{ github.workflow }}-${{ github.ref }}
  cancel-in-progress: true
```

Production deployment workflows must use additional safeguards where cancellation could create inconsistent deployment states.

---

# 21. Dependency Management

Application dependencies should be managed using the native package manager of the application language.

Where supported, dependency vulnerability scanning should be included in CI.

Dependencies should use lock files where the ecosystem supports them.

---

# 22. Artifact Management

Build artifacts should be:

* Clearly named
* Versioned
* Traceable to a Git commit
* Retained according to organizational policy

Container images should use immutable identifiers.

---

# 23. Workflow Inputs

Reusable workflows should expose only required inputs.

Example:

```yaml
workflow_call:
  inputs:
    application_name:
      required: true
      type: string

    language:
      required: true
      type: string

    run_tests:
      required: false
      type: boolean
      default: true
```

Inputs must have documented defaults and expected values.

---

# 24. Workflow Outputs

Reusable workflows should expose useful outputs where required.

Examples:

```text
image_tag
artifact_name
terraform_plan_status
security_scan_status
```

Outputs must not contain secrets.

---

# 25. Failure Handling

Pipeline failures must provide actionable information.

A failure should identify:

* Failed stage
* Failed tool
* Relevant error
* Recommended remediation where practical

The workflow must not hide security failures.

---

# 26. Security Failure Policy

The default security policy should be:

```text
Critical → Fail
High     → Fail where policy requires
Medium   → Report / policy dependent
Low      → Report
```

Exact severity thresholds must be governed centrally.

Approved exceptions must include:

* Finding
* Reason
* Owner
* Expiration date
* Approval

Permanent unexplained security exceptions are not permitted.

---

# 27. Reusability Model

Application repositories should contain minimal workflow logic.

Example:

```yaml
name: Application CI

on:
  pull_request:

jobs:
  ci:
    uses: organization/platform-workflows/.github/workflows/ci.yml@v1
    with:
      application_name: ims
      language: python
```

The application repository should not duplicate the complete CI implementation.

---

# 28. Versioning

Reusable workflows must be versioned.

Example:

```text
v1
v1.1
v1.2
v2
```

Breaking changes require a new major version.

Application repositories should pin to an approved version rather than automatically consuming uncontrolled changes.

---

# 29. Workflow Security

Workflows must protect against:

* Secret exposure
* Excessive permissions
* Untrusted pull-request code
* Dependency compromise
* Malicious action changes
* Artifact tampering

Workflows triggered by forked pull requests must receive particular attention because repository secrets must not be exposed to untrusted code.

---

# 30. Local Validation

Where practical, workflow configuration should be statically validated before pushing.

Recommended validation includes:

* YAML syntax validation
* GitHub Actions workflow linting
* Terraform validation
* Security scanning
* Dockerfile validation

GitHub Actions execution should be used for final integration validation when available.

---

# 31. Observability

Workflow execution should provide:

* Clear job names
* Clear step names
* Useful logs
* Security scan results
* Test results
* Deployment status

Sensitive values must be masked.

---

# 32. Acceptance Criteria

### AC-001

Application repositories can consume reusable workflows.

### AC-002

Application repositories do not duplicate the complete CI/CD implementation.

### AC-003

Gitleaks executes automatically.

### AC-004

Trivy executes automatically.

### AC-005

Checkov executes automatically for Terraform.

### AC-006

Terraform formatting and validation execute automatically.

### AC-007

Docker images are scanned before deployment.

### AC-008

Production deployment requires appropriate approval.

### AC-009

Workflow permissions follow least privilege.

### AC-010

Secrets are not stored in workflow source code.

### AC-011

Reusable workflows are versioned.

### AC-012

Security failures can block the pipeline.

### AC-013

Pipeline failures provide actionable information.

### AC-014

The same workflows can support multiple applications.

---

# 33. Definition of Done

The workflow platform capability is complete when:

* Reusable workflows are implemented.
* Application teams can consume them.
* CI and testing are standardized.
* Gitleaks is integrated.
* Trivy is integrated.
* Checkov is integrated.
* Terraform validation is integrated.
* Docker images are scanned.
* Security policies are enforced.
* Workflow permissions are minimized.
* Workflow versions are defined.
* IMS successfully consumes the workflows.
* A second application successfully consumes the same workflows.
* Documentation is complete.
