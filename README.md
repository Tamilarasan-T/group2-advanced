# group2-advanced

## AI-Driven Cloud & DevSecOps Capstone

**Reusable Platform Engineering Solution for Acme Retail Ltd.**

## Overview

This project implements a reusable Internal Developer Platform (IDP) to standardize:

- CI/CD
- Terraform infrastructure
- Security
- Repository structure
- Governance
- Developer experience

It addresses duplicate pipelines, duplicate infrastructure, inconsistent security and longer onboarding across application teams. :contentReference[oaicite:2]{index=2}

## Platform Capabilities

```text
Repository Template
        ↓
Reusable GitHub Actions
        ↓
Security Controls
        ↓
Reusable Terraform Modules
        ↓
Governance
        ↓
Developer Experience
````

### Reusable Terraform Modules

* Network
* IAM
* Container
* Observability

### Reusable CI/CD

* Application CI
* Gitleaks
* Trivy
* Terraform validation
* Checkov

### Governance

* Branch protection
* PR reviews
* CODEOWNERS
* Security gates
* Terraform governance
* Exception management

### Developer Experience

* Standard repository template
* Self-service platform capabilities
* Standard onboarding
* Documentation
* Troubleshooting guidance

## Repository Structure

```text
group2-advanced/
├── .github/workflows/
├── ai-specifications/
├── architecture/
├── infrastructure/
├── repo-template/
├── governance/
├── developer-experience/
├── engineering-decisions/
├── docs/
└── presentation/
```

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

These specifications define the platform requirements, architecture, security, governance, validation and Definition of Done.

## Validation

GitHub Actions validates:

* Application CI
* Gitleaks
* Trivy
* Terraform
* Checkov
* Repository template
* Orders API consumer
* Payments API consumer

Current validation includes successful platform CI, template validation and Terraform consumer validation. 

## Security

Security is integrated by default using:

* Gitleaks
* Trivy
* Checkov
* Least-privilege IAM
* Encryption
* Restricted network access
* Protected production changes

## Technology Stack

| Area           | Technology                 |
| -------------- | -------------------------- |
| Source Control | GitHub                     |
| CI/CD          | GitHub Actions             |
| IaC            | Terraform                  |
| Cloud          | AWS                        |
| Container      | Docker / Amazon ECR        |
| Security       | Gitleaks / Trivy / Checkov |
| Application    | Python                     |
| Documentation  | Markdown                   |

## Application Consumers

The reusable platform capabilities are validated by:

* Orders API
* Payments API

Both consume the same Terraform modules and platform CI/CD capabilities. 

## Architecture & Decisions

Architecture:

`architecture/`

Engineering decisions:

`engineering-decisions/`

ADRs cover platform architecture, Terraform modules, reusable GitHub Actions, security-by-default and repository templates.

## Definition of Done

* AI Engineering Specifications completed
* Platform architecture documented
* Reusable Terraform modules implemented
* Reusable GitHub Actions implemented
* Security integrated
* Repository template implemented
* Governance documented
* Developer experience documented
* Orders and Payments consumers validated
* GitHub Actions validation passing
* ADRs completed
* Final presentation prepared
