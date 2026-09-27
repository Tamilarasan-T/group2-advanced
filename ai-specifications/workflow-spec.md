# AI Engineering Specification — Reusable GitHub Actions Workflows

## 1. Document Information

| Field         | Value                                   |
| ------------- | --------------------------------------- |
| Specification | Reusable CI/CD and DevSecOps Workflows  |
| Version       | 1.0                                     |
| Status        | Approved                                |
| Platform      | Acme Retail Internal Developer Platform |
| CI/CD         | GitHub Actions                          |
| Security      | Gitleaks, Trivy, Checkov                |
| IaC           | Terraform                               |

## 2. Purpose

Provide reusable GitHub Actions workflows for standardized CI/CD, security and Terraform validation.

Application teams should consume reusable workflows instead of duplicating pipelines.

## 3. Business Problem

Duplicate pipelines cause:

* Inconsistent CI/CD
* Inconsistent security
* Duplicate maintenance
* Longer onboarding
* Higher operational effort

## 4. Goals

* Standardize CI/CD.
* Provide reusable workflows.
* Integrate Gitleaks, Trivy and Checkov.
* Validate Terraform.
* Support Docker workflows.
* Follow least privilege.
* Protect secrets.
* Support multiple applications.

## 5. Implemented Workflows

```text
.github/workflows/
├── reusable-ci.yml
├── reusable-security.yml
├── reusable-terraform.yml
├── platform-ci.yml
├── terraform-validate.yml
├── terraform-consumer-validation.yml
└── template-validation.yml
```

## 6. Standard Pipeline

```text
PR → Build/Test → Security → Terraform → Docker → Approval → Deploy
```

Docker build and image scanning are conditional.

## 7. CI Requirements

CI must:

* Checkout code.
* Setup runtime.
* Install dependencies.
* Run tests.
* Fail on required test failures.

## 8. Security Requirements

Use:

* **Gitleaks** — secret detection
* **Trivy** — filesystem/image scanning
* **Checkov** — Terraform security

High/Critical security findings should fail pipelines according to policy.

## 9. Terraform Requirements

```text
terraform fmt
      ↓
terraform init
      ↓
terraform validate
      ↓
Checkov
```

Production changes require appropriate authorization.

## 10. Docker Requirements

Containers must:

* Avoid embedded secrets.
* Prefer minimal images.
* Run as non-root where practical.
* Be scanned before deployment.
* Prefer immutable image identifiers.

## 11. Permissions & Secrets

Use least privilege:

```yaml
permissions:
  contents: read
```

Do not store secrets in source, Dockerfiles, Terraform or logs.

Use approved secret stores such as GitHub Secrets or AWS Secrets Manager.

## 12. Workflow Security

Protect against:

* Secret exposure
* Excessive permissions
* Untrusted code
* Dependency compromise
* Malicious actions
* Artifact tampering

Fork-based PRs must not receive sensitive secrets.

## 13. Reusability

Application repositories must contain minimal workflow code.

Common CI, security, Terraform and deployment logic should be provided through reusable workflows.

## 14. Versioning

Reusable workflows must be version controlled.

```text
v1 → v1.1 → v2
```

Breaking changes require a new major version.

Same-repository workflows are controlled through PRs, reviews and protected branches.

## 15. Validation

Validate through:

* YAML/workflow validation
* Terraform validation
* Security scanning
* Docker validation where applicable
* GitHub Actions execution

## 16. Acceptance Criteria

* [ ] Reusable CI implemented.
* [ ] Reusable security implemented.
* [ ] Reusable Terraform implemented.
* [ ] Gitleaks integrated.
* [ ] Trivy integrated.
* [ ] Checkov integrated.
* [ ] Terraform validation automated.
* [ ] Least-privilege permissions used.
* [ ] Secrets protected.
* [ ] Workflows version controlled.
* [ ] Orders API consumes reusable capabilities.
* [ ] Payments API consumes the same capabilities.
* [ ] CI/CD validation passes.

## 17. Definition of Done

The workflow platform is complete when reusable CI, security and Terraform workflows are implemented, validated, documented and consumed by multiple applications without duplicated pipeline implementations.
