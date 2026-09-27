# Acme Retail — Internal Developer Platform

## Overview

This capstone implements a reusable Internal Developer Platform (IDP) for Acme Retail.

The platform standardizes:

- Repository structure
- CI/CD
- Security
- Terraform infrastructure
- Governance
- Developer experience

## Platform Architecture

```text
Application Teams
       ↓
Repository Template
       ↓
Reusable GitHub Actions
       ↓
Security Controls
       ↓
Reusable Terraform Modules
       ↓
AWS Infrastructure
````

## Repository Structure

```text
.
├── app/
├── infrastructure/
├── .github/workflows/
├── docs/
├── architecture/
├── ai-specifications/
├── engineering-decisions/
├── governance/
├── developer-experience/
├── repo-template/
└── tests/
```

## Platform Capabilities

### CI/CD

Reusable GitHub Actions provide:

* Build and test
* Security scanning
* Terraform validation
* Deployment workflows

### Security

* Gitleaks — secret scanning
* Trivy — vulnerability scanning
* Checkov — Terraform security

### Terraform

Reusable AWS modules:

```text
network
iam
container
observability
```

### Governance

Includes:

* Branch protection
* Pull Request standards
* CODEOWNERS
* Security gates
* Exception management
* Production approval

### Developer Experience

Provides:

* Standard repository template
* Developer onboarding
* Self-service capabilities
* Troubleshooting
* Support model

## AI Engineering Specifications

```text
ai-specifications/
├── platform-spec.md
├── terraform-modules-spec.md
├── workflow-spec.md
├── repo-template-spec.md
├── governance-spec.md
└── developer-experience-spec.md
```

## Validation

The platform has automated validation for:

* Terraform modules
* Terraform consumers
* CI/CD workflows
* Security scanning
* Repository template
* Application tests
* Docker build

See:

`docs/validation-evidence.md`

## Application Consumers

The reusable platform capabilities are demonstrated with:

* Orders API
* Payments API

Both consume the same reusable Terraform modules.

## Documentation

| Area                 | Location                      |
| -------------------- | ----------------------------- |
| Architecture         | `architecture/`               |
| AI Specifications    | `ai-specifications/`          |
| Governance           | `governance/`                 |
| Developer Experience | `developer-experience/`       |
| ADRs                 | `engineering-decisions/`      |
| Validation           | `docs/validation-evidence.md` |
| Repository Template  | `repo-template/`              |

## Status

**Capstone implementation validated with documented environment-level configuration requirements.**
