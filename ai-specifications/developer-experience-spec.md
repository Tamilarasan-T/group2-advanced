# AI Engineering Specification — Developer Experience

## 1. Purpose

Provide a simple, consistent and reusable developer experience for application teams using the Acme Retail Internal Developer Platform.

## 2. Business Problem

Teams currently build repositories, CI/CD, Terraform, security, Docker and documentation independently, causing:

- Duplicate effort
- Inconsistent standards
- Longer onboarding
- Higher maintenance
- Troubleshooting difficulty

## 3. Goals

- Standardize application onboarding.
- Provide reusable CI/CD and Terraform.
- Integrate security by default.
- Provide clear documentation.
- Enable self-service.
- Provide clear validation feedback.
- Support multiple application teams.

## 4. Developer Journey

```text
Create Repository
       ↓
Configure Application
       ↓
Use CI/CD
       ↓
Security Validation
       ↓
Terraform
       ↓
Test
       ↓
Approval
       ↓
Deployment
````

## 5. Application Onboarding

The standard onboarding process should provide:

* Repository template
* README
* Application structure
* Tests
* Terraform structure
* CI/CD
* Security scanning
* Docker configuration where required
* CODEOWNERS
* Documentation

## 6. Self-Service

Developers should be able to:

* Create repositories from templates.
* Configure application metadata.
* Consume Terraform modules.
* Consume reusable workflows.
* Run validation.
* View CI/security results.
* Access platform documentation.

Self-service must follow security and governance controls.

## 7. Repository Experience

Standard structure:

```text
application/
├── app/
├── tests/
├── infrastructure/
├── docs/
├── architecture/
├── ai-specifications/
├── engineering-decisions/
└── .github/
```

Developers should not need to understand the entire platform to start development.

## 8. Documentation

README documentation should cover:

* Application purpose
* Local setup
* Testing
* Build
* Deployment
* Infrastructure
* Security
* Troubleshooting
* Support

## 9. Local Development

Developers should be able to validate locally:

```text
Application Tests
Terraform Format
Terraform Validate
Docker Build
```

## 10. CI/CD Experience

Standard flow:

```text
PR → Build → Test → Security → Infrastructure Validation → Review → Deploy
```

Failures must clearly show:

* Failed stage
* Reason
* Relevant logs
* Corrective action

## 11. Security Experience

Security must be part of normal development.

```text
Gitleaks → Secret Scanning
Trivy    → Vulnerability Scanning
Checkov  → Terraform Security
```

Security controls must not be silently bypassed.

## 12. Infrastructure Experience

Developers should consume reusable Terraform modules.

```text
Application
     ↓
Environment
     ↓
Reusable Terraform Module
     ↓
AWS
```

Available modules:

```text
network
iam
container
observability
```

## 13. Environments

Standard environments:

```text
dev
test
prod
```

Environment-specific configuration must remain separate from reusable modules.

Production changes require appropriate approval.

## 14. Feedback and Observability

Developers should see:

* CI/CD status
* Test results
* Security results
* Terraform validation
* Deployment status
* Application/infrastructure health

Errors should provide actionable information.

## 15. Support Model

**Application Team**

* Application code
* Tests
* Configuration
* Application infrastructure

**Platform Team**

* Repository templates
* Reusable workflows
* Terraform modules
* Platform documentation
* Platform tooling

**Security Team**

* Security standards
* Security policies
* Security exceptions
* Vulnerability governance

## 16. Versioning

Platform capabilities must be versioned:

```text
Workflows
Terraform Modules
Repository Templates
```

Breaking changes must be documented and provide an upgrade path.

## 17. Developer Experience Metrics

Track:

* Onboarding time
* CI/CD setup time
* Infrastructure setup time
* Pipeline failure rate
* Security remediation time
* Platform adoption
* Module/workflow reuse
* Support requests

## 18. Acceptance Criteria / Definition of Done

* [ ] Standard repository can be created.
* [ ] Onboarding process is documented.
* [ ] CI/CD is reusable.
* [ ] Terraform modules are reusable.
* [ ] Security scanning is integrated.
* [ ] Local validation is supported.
* [ ] Environments are separated.
* [ ] Production approval is enforced.
* [ ] Platform versions are identifiable.
* [ ] Troubleshooting guidance exists.
* [ ] Multiple applications can reuse platform capabilities.
