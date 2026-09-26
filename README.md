# group2-advanced

## AI-Driven Cloud & DevSecOps Capstone

**Reusable Platform Engineering Solution for Acme Retail Ltd. — Inventory Management System**

---

## 1. Project Overview

Acme Retail Ltd. has multiple application teams developing and deploying cloud-based applications.

The existing engineering approach contains duplicated CI/CD pipelines, Terraform configurations, repository structures, security configurations, and documentation.

This project implements a reusable Internal Developer Platform (IDP) approach to standardize common engineering capabilities while allowing application teams to retain ownership of their application-specific code.

The platform focuses on:

- Standardization
- Reusability
- Automation
- Security by default
- Developer experience
- Governance
- Self-service platform capabilities

---

## 2. Business Problem

The existing engineering model creates several challenges:

- Duplicate CI/CD pipelines
- Duplicate Terraform infrastructure code
- Inconsistent repository structures
- Different security practices
- Longer developer onboarding
- Higher maintenance effort
- Inconsistent engineering documentation
- Limited reuse across application teams

The platform addresses these problems by providing reusable engineering building blocks.

---

## 3. Platform Solution

The proposed platform provides reusable capabilities for application teams.

```text
Application Teams
       |
       v
Repository Template
       |
       +--------------------+
       |                    |
       v                    v
Reusable CI/CD        Terraform Modules
       |                    |
       v                    v
Security Controls      AWS Infrastructure
       |                    |
       +---------+----------+
                 |
                 v
        Governance & Operations
````

---

## 4. Key Platform Capabilities

### Repository Template

Provides a standardized application repository structure containing:

* Application code
* Automated tests
* Infrastructure
* Documentation
* Architecture
* AI Engineering Specifications
* Engineering Decisions
* Docker configuration
* CODEOWNERS
* Pull request template
* Security policy

Location:

```text
repo-template/
```

### Reusable GitHub Actions

Reusable workflows provide common CI/CD capabilities:

* Application CI
* Security scanning
* Terraform validation

Location:

```text
.github/workflows/
```

### Reusable Terraform Modules

The platform provides reusable AWS modules for:

* Network
* IAM
* Container
* Observability

Location:

```text
infrastructure/modules/
```

### Security

Security is integrated into the standard engineering workflow using:

* Gitleaks
* Trivy
* Checkov
* Terraform secure defaults
* Least-privilege IAM
* Encryption
* Restricted network access
* Governance controls

### Governance

The platform defines standards for:

* Branch protection
* Pull requests
* CODEOWNERS
* Security gates
* Terraform governance
* Exception management
* Production changes
* Auditability

### Developer Experience

The platform provides:

* Standard onboarding
* Standard development workflow
* Self-service platform consumption
* Troubleshooting guidance
* Platform support model
* Consistent documentation

---

## 5. Repository Structure

```text
group2-advanced/
│
├── .github/
│   └── workflows/
│       ├── platform-ci.yml
│       ├── reusable-ci.yml
│       ├── reusable-security.yml
│       ├── reusable-terraform.yml
│       ├── terraform-validate.yml
│       ├── terraform-consumer-validation.yml
│       └── template-validation.yml
│
├── ai-specifications/
│   ├── platform-spec.md
│   ├── terraform-modules-spec.md
│   ├── workflow-spec.md
│   ├── repo-template-spec.md
│   ├── governance-spec.md
│   └── developer-experience-spec.md
│
├── architecture/
│   ├── platform-architecture.md
│   └── platform-architecture.mmd
│
├── infrastructure/
│   ├── modules/
│   │   ├── network/
│   │   ├── iam/
│   │   ├── container/
│   │   └── observability/
│   │
│   └── examples/
│       ├── orders-api/
│       └── payments-api/
│
├── repo-template/
│   ├── .github/
│   │   ├── CODEOWNERS
│   │   ├── pull_request_template.md
│   │   └── workflows/
│   ├── app/
│   ├── tests/
│   ├── infrastructure/
│   ├── docs/
│   ├── architecture/
│   ├── ai-specifications/
│   ├── engineering-decisions/
│   ├── Dockerfile
│   ├── SECURITY.md
│   └── README.md
│
├── governance/
│   ├── branch-protection.md
│   ├── pull-request-policy.md
│   ├── security-policy.md
│   └── exception-process.md
│
├── developer-experience/
│   ├── onboarding.md
│   ├── developer-workflow.md
│   ├── self-service.md
│   └── support-model.md
│
├── engineering-decisions/
│   ├── adr-001-platform-architecture.md
│   ├── adr-002-terraform-modules.md
│   ├── adr-003-reusable-github-actions.md
│   ├── adr-004-security-by-default.md
│   └── adr-005-repository-template.md
│
├── docs/
├── presentation/
└── README.md
```

---

## 6. AI Engineering Specifications

The AI Engineering Specifications are the primary design artifacts used to guide implementation.

```text
ai-specifications/
├── platform-spec.md
├── terraform-modules-spec.md
├── workflow-spec.md
├── repo-template-spec.md
├── governance-spec.md
└── developer-experience-spec.md
```

These specifications define the intended architecture, requirements, security controls, reusable components, governance model, and acceptance criteria.

AI-generated implementation artifacts are validated against these specifications.

---

## 7. Terraform Platform Modules

### Network

Provides standardized AWS networking capabilities including:

* VPC
* Public subnets
* Private subnets
* Route tables
* Internet Gateway
* VPC Flow Logs
* KMS encryption
* CloudWatch logging
* Restricted default security group

### IAM

Provides:

* Application IAM role
* Trusted service configuration
* Optional instance profile
* Configurable IAM policies
* Session duration controls

### Container

Provides:

* Amazon ECR repository
* Immutable image tags
* Scan-on-push
* KMS encryption
* ECR lifecycle policy

### Observability

Provides:

* CloudWatch Log Group
* KMS encryption
* Configurable log retention

All modules use consistent tagging and secure defaults.

---

## 8. Terraform Reusability

The platform modules are consumed by multiple application examples:

```text
                    Reusable Terraform Modules
                              |
              +---------------+---------------+
              |                               |
              v                               v
         orders-api                      payments-api
              |                               |
              v                               v
       Network / IAM /                  Network / IAM /
       Container / Obs.                 Container / Obs.
              |                               |
              +---------------+---------------+
                              |
                              v
                    Automated Validation
```

Both consumers are automatically validated using:

* Terraform format
* Terraform initialization
* Terraform validation
* Checkov

This demonstrates that the same platform modules can be consumed by multiple applications.

---

## 9. CI/CD

The platform provides reusable GitHub Actions workflows.

### Reusable CI

Performs:

* Python setup
* Dependency installation
* Automated tests

### Reusable Security

Performs:

* Gitleaks secret scanning
* Trivy filesystem scanning
* Optional Trivy container scanning

### Reusable Terraform

Performs:

* Terraform formatting
* Terraform initialization
* Terraform validation
* Checkov security scanning

---

## 10. Validation

The implementation is continuously validated using GitHub Actions.

### Platform CI

Validates:

```text
Reusable CI             PASS
Gitleaks                 PASS
Trivy Filesystem         PASS
Reusable Terraform       PASS
```

### Repository Template Validation

Validates:

```text
Python Tests             PASS
Docker Build             PASS
Template Structure       PASS
```

### Terraform Consumer Validation

Validates:

```text
Orders API Consumer      PASS
Payments API Consumer    PASS
```

The validation workflows ensure that platform components and their consumers remain consistent with the defined engineering specifications.

---

## 11. Security Model

Security is implemented as a platform capability rather than an application-team-specific activity.

### Source Code

* Gitleaks secret scanning
* Pull request review
* CODEOWNERS

### Container Security

* Trivy vulnerability scanning
* ECR scan-on-push
* Immutable image tags

### Infrastructure Security

* Checkov
* Encryption
* KMS
* Least-privilege IAM
* Restricted network access
* VPC Flow Logs
* No hard-coded credentials

### Governance

Security exceptions must follow the documented exception process and include appropriate approval and remediation tracking.

---

## 12. Governance

Governance documentation is located under:

```text
governance/
```

It covers:

* Branch protection
* Pull request policy
* Security policy
* Terraform governance
* Exception management
* Production changes
* Auditability

---

## 13. Developer Experience

The platform standardizes the developer journey:

```text
Create Repository
       |
       v
Use Repository Template
       |
       v
Develop Application
       |
       v
Create Pull Request
       |
       v
Automated CI + Security
       |
       v
Terraform Validation
       |
       v
Review & Approval
       |
       v
Deployment
       |
       v
Monitoring & Operations
```

The goal is to reduce repetitive setup while preserving application-team ownership.

---

## 14. Engineering Decisions

Architecture and implementation decisions are documented as ADRs.

```text
engineering-decisions/
├── adr-001-platform-architecture.md
├── adr-002-terraform-modules.md
├── adr-003-reusable-github-actions.md
├── adr-004-security-by-default.md
└── adr-005-repository-template.md
```

Each ADR documents:

* Context
* Problem
* Decision
* Alternatives
* Trade-offs
* Consequences
* Rationale

---

## 15. Technology Stack

| Area                   | Technology        |
| ---------------------- | ----------------- |
| Source Control         | GitHub            |
| CI/CD                  | GitHub Actions    |
| Infrastructure as Code | Terraform         |
| Cloud                  | AWS               |
| Container Registry     | Amazon ECR        |
| Logging                | Amazon CloudWatch |
| Secret Scanning        | Gitleaks          |
| Vulnerability Scanning | Trivy             |
| IaC Security           | Checkov           |
| Application            | Python            |
| Containerization       | Docker            |
| Documentation          | Markdown          |
| Architecture           | Mermaid           |

---

## 16. Definition of Done

The platform implementation is considered complete when:

* AI Engineering Specifications are documented
* Platform architecture is documented
* Reusable Terraform modules are implemented
* Terraform modules pass validation and Checkov
* Multiple application consumers are validated
* Reusable GitHub Actions workflows are implemented
* Repository template is implemented
* Repository template validation passes
* Security controls are integrated
* Governance documentation is available
* Developer experience documentation is available
* ADRs document major engineering decisions
* Implementation is validated through GitHub Actions
* Final architecture and presentation documentation is available

---

## 17. Future Enhancements

Potential future platform capabilities include:

* Automated repository provisioning
* Self-service application onboarding
* Terraform module version registry
* GitHub Actions workflow versioning
* Automated environment provisioning
* Centralized observability dashboards
* Automated policy enforcement
* Developer portal integration
* Platform usage metrics
* Automated dependency updates

---

## 18. Project Outcome

The project establishes a reusable platform engineering foundation for Acme Retail Ltd.

Instead of implementing common engineering capabilities independently for every application, teams can consume standardized:

* Repository structures
* CI/CD workflows
* Security controls
* Terraform modules
* Governance policies
* Developer experience patterns

This provides a foundation for scaling engineering practices across multiple application teams while maintaining clear ownership and automated validation.

```
