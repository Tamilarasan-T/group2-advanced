# AI Engineering Specification — Standard Application Repository Template

## 1. Document Information

| Field          | Value                                    |
| -------------- | ---------------------------------------- |
| Specification  | Standard Application Repository Template |
| Version        | 1.0                                      |
| Status         | Draft                                    |
| Platform       | Acme Retail Internal Developer Platform  |
| Source Control | GitHub                                   |
| CI/CD          | GitHub Actions                           |
| IaC            | Terraform                                |
| Container      | Docker                                   |

---

# 2. Purpose

This specification defines the standard repository structure that application teams must use when onboarding applications to the Acme Retail Internal Developer Platform.

The objective is to eliminate inconsistent repository structures, reduce onboarding effort, and provide every application team with a standardized engineering baseline.

---

# 3. Business Problem

Application teams currently use different repository structures and engineering practices.

This creates:

* Inconsistent project organization
* Difficult onboarding
* Duplicate configuration
* Difficult automation
* Inconsistent documentation
* Inconsistent CI/CD configuration
* Inconsistent security configuration
* Increased platform maintenance

The repository template provides a common baseline for all applications.

---

# 4. Goals

The repository template must:

1. Provide a standard repository structure.
2. Reduce application onboarding effort.
3. Provide standardized documentation.
4. Provide CI/CD integration.
5. Provide security integration.
6. Provide infrastructure structure.
7. Provide testing structure.
8. Support multiple application technologies.
9. Minimize application-specific configuration.
10. Enable developers to start development quickly.

---

# 5. Non-Goals

The repository template will not:

* Contain application-specific business logic.
* Force every application to use the same programming language.
* Contain production credentials.
* Contain environment-specific secrets.
* Replace application-team ownership.
* Duplicate reusable platform workflow implementations.

---

# 6. Standard Repository Structure

Every onboarded application should follow:

```text
application-repository/
│
├── README.md
│
├── app/
│   └── src/
│
├── tests/
│
├── infrastructure/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── environments/
│       ├── dev/
│       ├── test/
│       └── prod/
│
├── docs/
│
├── architecture/
│
├── ai-specifications/
│
├── engineering-decisions/
│
├── .github/
│   └── workflows/
│
├── Dockerfile
│
├── .dockerignore
│
├── .gitignore
│
└── LICENSE
```

The exact application source structure may vary according to the programming language.

---

# 7. Repository Responsibilities

## Application Code

Application code must be located under:

```text
app/
```

The application team owns this code.

---

## Tests

Tests must be located under:

```text
tests/
```

The repository should support unit tests and, where applicable, integration tests.

---

## Infrastructure

Application-specific infrastructure configuration belongs under:

```text
infrastructure/
```

Reusable platform Terraform modules must not be copied into this directory.

Applications should consume the centralized platform modules.

---

## Documentation

Application documentation belongs under:

```text
docs/
```

Documentation should include:

* Setup
* Development
* Testing
* Deployment
* Troubleshooting
* Operational information

---

## Architecture

Architecture diagrams and architecture documentation belong under:

```text
architecture/
```

Mermaid diagrams are recommended for version-controlled diagrams.

---

## AI Specifications

AI Engineering Specifications relevant to the application belong under:

```text
ai-specifications/
```

Specifications should define expected behavior before AI-assisted implementation.

---

## Engineering Decisions

Architecture Decision Records belong under:

```text
engineering-decisions/
```

---

# 8. README Requirements

Every application repository must contain a README with:

1. Application name
2. Application purpose
3. Architecture overview
4. Technology stack
5. Local development instructions
6. Testing instructions
7. Docker instructions
8. Infrastructure instructions
9. CI/CD information
10. Security information
11. Deployment information
12. Troubleshooting
13. Ownership information

Example:

```markdown
# Inventory Management System

## Overview

<application description>

## Technology Stack

<technology>

## Local Development

<instructions>

## Testing

<instructions>

## Docker

<instructions>

## Infrastructure

<instructions>

## CI/CD

<instructions>

## Security

<instructions>

## Deployment

<instructions>

## Ownership

<team information>
```

---

# 9. GitHub Workflow Integration

Application repositories should consume reusable platform workflows.

The repository should avoid duplicating complete workflow implementations.

Example:

```yaml
name: CI

on:
  pull_request:

jobs:
  ci:
    uses: organization/platform-workflows/.github/workflows/ci.yml@v1
    with:
      application_name: ims
      language: python
```

The exact organization and workflow repository will be configured during implementation.

---

# 10. Branching Strategy

The standard repository should support:

```text
main
```

and short-lived feature branches.

Example:

```text
main
 │
 ├── feature/inventory-api
 ├── feature/product-search
 └── bugfix/inventory-validation
```

Long-lived feature branches should be avoided unless there is a documented reason.

---

# 11. Pull Request Requirements

Changes should normally be introduced through pull requests.

Pull requests should require:

* Code review
* Successful CI
* Security checks
* Required tests
* Terraform validation when infrastructure changes
* Documentation updates when applicable

Direct pushes to protected branches should be restricted according to governance requirements.

---

# 12. CODEOWNERS

Repositories should use:

```text
.github/CODEOWNERS
```

where appropriate.

Example:

```text
/app/ @application-team
/infrastructure/ @platform-team
/.github/ @platform-team
```

Actual ownership must be configured according to the organization's team structure.

---

# 13. Docker Requirements

Applications requiring containers must provide:

```text
Dockerfile
.dockerignore
```

Dockerfiles should:

* Use minimal suitable base images.
* Avoid hard-coded secrets.
* Avoid unnecessary packages.
* Use a non-root user where practical.
* Pin dependencies where appropriate.
* Expose only required ports.
* Be scanned before deployment.

---

# 14. Environment Configuration

Environment-specific configuration must not contain secrets in source control.

Example:

```text
infrastructure/
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Configuration should be separated from reusable platform infrastructure.

---

# 15. Secrets Management

The repository must never contain:

```text
Passwords
API keys
AWS credentials
Private keys
Access tokens
Database credentials
```

These must be provided through approved secret-management mechanisms.

Files containing environment secrets must be excluded using `.gitignore` where appropriate.

---

# 16. Standard `.gitignore`

The template should include common exclusions.

Example:

```gitignore
# Terraform
.terraform/
*.tfstate
*.tfstate.*
.terraform.lock.hcl

# Environment
.env
.env.*

# IDE
.vscode/
.idea/

# OS
.DS_Store
Thumbs.db

# Application
__pycache__/
*.pyc

# Logs
*.log
```

The template must be adapted to the application technology.

---

# 17. Security Baseline

Every repository must integrate with platform security controls.

Required security capabilities:

```text
Gitleaks
Trivy
Checkov
```

Additional dependency scanning should be enabled where supported.

---

# 18. Testing Baseline

Every application must provide automated tests.

Minimum requirement:

```text
Unit Tests
```

Where applicable:

```text
Integration Tests
API Tests
End-to-End Tests
```

Tests must execute automatically through CI.

---

# 19. Infrastructure Baseline

Applications requiring infrastructure must follow:

```text
infrastructure/
├── main.tf
├── variables.tf
├── outputs.tf
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Reusable infrastructure must be consumed from the platform's Terraform modules.

---

# 20. Naming Standards

Repository and application names must follow organizational naming standards.

For this capstone repository:

```text
group2-advanced
```

Application resources should use consistent naming based on:

```text
application
environment
resource
```

Example:

```text
ims-dev-network
ims-test-network
```

---

# 21. Metadata

The repository should maintain application metadata such as:

```text
Application Name
Application Owner
Platform Owner
Environment
Business Criticality
Technology
Repository
```

A simple metadata file may be used:

```yaml
application:
  name: ims
  owner: inventory-team
  criticality: medium
```

The implementation should avoid storing secrets in metadata.

---

# 22. Developer Onboarding

A new developer should be able to onboard using:

```text
Clone Repository
      ↓
Read README
      ↓
Install Dependencies
      ↓
Run Tests
      ↓
Run Application
      ↓
Build Docker Image
      ↓
Run Security Checks
```

The onboarding process should not require undocumented manual platform configuration.

---

# 23. Local Development

The README must document the required tools.

Example:

```text
Git
Docker
Terraform
Application Runtime
Security Tools
```

The exact requirements depend on the application technology.

---

# 24. Local Validation

Developers should be able to run appropriate checks locally before creating a pull request.

Example:

```bash
terraform fmt -check -recursive
terraform validate
checkov -d infrastructure
trivy fs .
gitleaks detect
```

The exact commands may vary according to the application.

---

# 25. Repository Template Parameters

The repository template should support configurable parameters such as:

```text
Application Name
Application Description
Programming Language
Application Team
Application Owner
Environment
Container Required
Terraform Required
Deployment Target
```

The template must use configuration rather than requiring developers to manually modify large numbers of files.

---

# 26. Template Customization

Customization must be limited to defined configuration points.

Examples:

```text
Application Name
Language
Runtime
Port
Team
Deployment Target
```

Platform security and governance controls must not be easily disabled through normal template configuration.

---

# 27. Versioning

The repository template must be versioned.

Example:

```text
template-v1
template-v2
```

Breaking template changes require a new major version.

Existing application repositories should not be unexpectedly modified when a new template version is released.

---

# 28. Acceptance Criteria

### AC-001

A new application can be created using the standard repository template.

### AC-002

The repository contains the required standard directories.

### AC-003

README documentation is present.

### AC-004

Automated testing is available.

### AC-005

CI/CD integration is configured.

### AC-006

Gitleaks is integrated.

### AC-007

Trivy is integrated.

### AC-008

Checkov is integrated when Terraform is used.

### AC-009

No secrets are stored in the repository.

### AC-010

Docker configuration is available for containerized applications.

### AC-011

Applications consume reusable Terraform modules.

### AC-012

Applications consume reusable GitHub Actions workflows.

### AC-013

Developer onboarding instructions are documented.

### AC-014

The template can support multiple application teams.

---

# 29. Definition of Done

The repository template is complete when:

* Standard repository structure is implemented.
* Required documentation is available.
* CI/CD integration is implemented.
* Security scanning is integrated.
* Testing structure is provided.
* Docker support is available where required.
* Terraform structure is available where required.
* Reusable platform components are consumed rather than copied.
* Developer onboarding is documented.
* Template versioning is defined.
* IMS can be created/onboarded using the standard structure.
* A second sample application can use the same template.
