# Developer Experience Specification

## 1. Purpose

This specification defines the developer experience standards for the Acme Retail Internal Developer Platform (IDP).

The goal is to make application onboarding, development, infrastructure provisioning, CI/CD, security validation, and deployment simple, consistent, and reusable for application teams.

The platform should reduce developer effort while maintaining security, governance, and operational standards.

---

## 2. Business Problem

Application teams currently spend significant time setting up and maintaining:

* Repository structures
* CI/CD pipelines
* Terraform configurations
* Security scanning
* Docker configuration
* Environment configuration
* Documentation
* Deployment processes

Different teams may implement these capabilities differently, resulting in:

* Duplicate engineering effort
* Inconsistent standards
* Longer onboarding time
* Higher maintenance effort
* Security and compliance gaps
* Difficult troubleshooting

The IDP should provide a standardized developer experience that allows teams to focus primarily on application development.

---

## 3. Goals

The developer experience must:

1. Provide a standard application repository.
2. Reduce application onboarding effort.
3. Provide reusable CI/CD workflows.
4. Provide reusable Terraform modules.
5. Integrate security checks by default.
6. Provide clear documentation.
7. Provide self-service capabilities where possible.
8. Provide consistent development and deployment processes.
9. Make platform standards easy to understand and follow.
10. Provide clear feedback when validation fails.

---

## 4. Non-Goals

The platform will not:

* Replace application-specific development practices.
* Force every application to use the same programming language.
* Hide infrastructure behavior from developers.
* Automatically deploy production applications without required approvals.
* Store application secrets inside repositories.
* Allow developers to bypass mandatory security controls.

---

## 5. Target Developer Journey

The standard developer journey should be:

```text
Developer
    |
    v
Create Application Repository
    |
    v
Repository Template
    |
    v
Configure Application
    |
    v
Use Reusable CI/CD
    |
    v
Security Validation
    |
    v
Terraform Infrastructure
    |
    v
Development Environment
    |
    v
Testing
    |
    v
Production Approval
    |
    v
Production Deployment
```

---

## 6. Application Onboarding

The platform should provide a standardized onboarding process.

### Required onboarding inputs

The developer should provide:

* Application name
* Application description
* Programming language
* Team name
* Application owner
* Environment requirements
* Container requirement
* Infrastructure requirement
* Deployment target

### Expected output

The onboarding process should create or provide:

* Standard repository structure
* README
* Application directory
* Test directory
* Terraform structure
* CI/CD workflows
* Security scanning
* Docker configuration where required
* Documentation structure
* CODEOWNERS
* Engineering decision structure

---

## 7. Developer Self-Service

The platform should support self-service operations wherever practical.

Examples:

* Create a new application repository.
* Select a repository template.
* Configure application metadata.
* Select deployment environment.
* Consume Terraform modules.
* Consume reusable workflows.
* Run validation pipelines.
* View build and security results.
* Access platform documentation.

Self-service actions must still follow platform governance and security requirements.

---

## 8. Standard Repository Experience

Every application repository should provide a predictable structure.

Example:

```text
application-repository/
├── app/
├── tests/
├── infrastructure/
├── docs/
├── architecture/
├── ai-specifications/
├── engineering-decisions/
├── .github/
├── Dockerfile
├── README.md
├── .gitignore
└── LICENSE
```

Developers should not need to understand the entire platform architecture before starting application development.

---

## 9. Developer Documentation

Every application must provide a README containing:

* Application overview
* Prerequisites
* Local setup
* Development instructions
* Testing instructions
* Build instructions
* Deployment process
* Environment information
* Infrastructure information
* Security requirements
* Troubleshooting guidance
* Platform support information

Documentation should be written for developers who are unfamiliar with the platform.

---

## 10. Local Development

Developers should be able to perform basic validation before creating a pull request.

Recommended commands:

```bash
terraform fmt -check -recursive
terraform validate
docker build .
```

Application-specific tests should also be executable locally.

Example:

```bash
pytest
```

or the equivalent command for the selected programming language.

---

## 11. CI/CD Developer Experience

The CI/CD process should provide fast and understandable feedback.

Expected flow:

```text
Pull Request
     |
     v
Build
     |
     v
Unit Tests
     |
     v
Security Scans
     |
     v
Infrastructure Validation
     |
     v
Review
     |
     v
Merge
     |
     v
Deployment
```

Pipeline failures should clearly identify:

* Failed stage
* Reason for failure
* Relevant logs
* Recommended corrective action

---

## 12. Security Experience

Security should be integrated into the normal developer workflow rather than treated as a separate manual process.

The platform should provide:

### Secret scanning

Use:

```text
Gitleaks
```

### Container scanning

Use:

```text
Trivy
```

### Infrastructure security

Use:

```text
Checkov
```

Developers should receive actionable feedback when a security check fails.

Security controls must not be silently bypassed.

---

## 13. Infrastructure Experience

Developers should consume standardized Terraform modules instead of creating infrastructure patterns from scratch.

Example:

```text
Application
    |
    v
Terraform Environment
    |
    v
Reusable Platform Module
    |
    v
AWS Resource
```

Example modules:

```text
network
iam
container
observability
```

Developers should primarily configure module inputs rather than modify shared module implementation.

---

## 14. Environment Experience

The platform should support standardized environments:

```text
dev
test
prod
```

Environment-specific configuration must be separated from reusable Terraform modules.

Example:

```text
infrastructure/
├── modules/
│   ├── network/
│   ├── iam/
│   ├── container/
│   └── observability/
│
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Production changes must require appropriate approval according to governance requirements.

---

## 15. Feedback and Observability

Developers should have visibility into:

* CI/CD status
* Test results
* Security scan results
* Terraform validation
* Deployment status
* Application health
* Infrastructure health

Failures should be traceable from the application repository to the relevant platform component.

---

## 16. Error Handling

Platform failures should provide useful messages.

Bad:

```text
Pipeline failed.
```

Good:

```text
Terraform validation failed.

File:
infrastructure/main.tf

Reason:
Invalid resource configuration.

Action:
Review the Terraform configuration and run:

terraform validate
```

Error messages should help developers resolve common issues without requiring immediate platform-team assistance.

---

## 17. Developer Support Model

Support responsibilities should be clearly defined.

### Application Team

Responsible for:

* Application code
* Application tests
* Application configuration
* Application-specific infrastructure configuration

### Platform Team

Responsible for:

* Repository templates
* Reusable workflows
* Terraform modules
* Platform documentation
* Platform tooling
* Platform reliability

### Security Team

Responsible for:

* Security standards
* Security policies
* Security exceptions
* Vulnerability governance

---

## 18. Platform Versioning

Platform capabilities must be versioned.

Examples:

```text
workflow v1
workflow v2

terraform-network v1
terraform-network v2

repository-template v1
repository-template v2
```

Application teams should be able to identify which platform version they are consuming.

Breaking changes must be documented before adoption.

---

## 19. Developer Experience Metrics

The platform should measure:

* Application onboarding time
* Number of manually created repositories
* CI/CD setup time
* Infrastructure setup time
* Pipeline failure rate
* Security finding resolution time
* Platform adoption
* Reuse of Terraform modules
* Reuse of CI/CD workflows
* Developer support requests

Example target:

```text
New application onboarding:
Before platform: several days

Target:
Less than 1 hour for standard application setup
```

The exact target should be validated using project evidence rather than assumed as an achieved result.

---

## 20. Acceptance Criteria

The specification is considered implemented when:

* A developer can create an application using the standard repository structure.
* Required documentation is available.
* CI/CD can be consumed without duplicating pipeline logic.
* Terraform modules can be consumed without duplicating infrastructure implementation.
* Security scanning is integrated.
* Developers can perform basic validation locally.
* Development and production environments are clearly separated.
* Production deployment requires appropriate approval.
* Platform versions are identifiable.
* Troubleshooting guidance is available.
* A second application can consume the same platform capabilities.

---

## 21. Definition of Done

Developer experience is considered complete when:

* [ ] Repository template is documented.
* [ ] Application onboarding process is documented.
* [ ] CI/CD usage is documented.
* [ ] Terraform module usage is documented.
* [ ] Security validation is documented.
* [ ] Local development process is documented.
* [ ] Environment strategy is documented.
* [ ] Support responsibilities are documented.
* [ ] Versioning strategy is documented.
* [ ] Developer experience metrics are defined.
* [ ] Acceptance criteria are validated.
* [ ] At least two applications can demonstrate reuse of platform capabilities.

---

## 22. Future Enhancements

Potential future capabilities include:

* Self-service developer portal
* Backstage integration
* Automated repository provisioning
* Automated environment provisioning
* Platform catalog
* Deployment dashboards
* Cost visibility
* Automated dependency updates
* AI-assisted troubleshooting
* Golden-path application templates
* Automated platform documentation
