# Developer Onboarding Guide

## Purpose

Provide a standardized onboarding process for application teams using the Acme Retail Internal Developer Platform.

## Prerequisites

- GitHub access
- Required cloud access
- Application and technical owners
- Environment requirements
- Security and deployment requirements

## Onboarding Flow

```text
Requirements
    ↓
Repository Template
    ↓
Application Configuration
    ↓
CI/CD + Security
    ↓
Terraform Modules
    ↓
Environment Validation
    ↓
Deployment
    ↓
Monitoring
````

## Repository

Create the application repository using the approved template.

Standard structure:

```text
app/
tests/
infrastructure/
docs/
architecture/
ai-specifications/
engineering-decisions/
.github/
Dockerfile
README.md
```

## CI/CD and Security

Applications should consume reusable platform workflows providing:

* Build and tests
* Gitleaks
* Trivy
* Terraform validation
* Checkov

Teams should avoid duplicating platform workflow logic.

## Infrastructure

Use approved reusable modules:

```text
network
iam
container
observability
```

Environment-specific configuration must remain separate from reusable modules.

## Environments

```text
dev → test → prod
```

Production changes require the appropriate approval process.

## Containerization

Containerized applications should provide:

* `Dockerfile`
* `.dockerignore`

Images should use approved bases, avoid credentials, use secure configuration and be vulnerability scanned.

## Documentation and Operations

Repositories should document:

* Application purpose
* Architecture
* Deployment
* Configuration
* Monitoring
* Troubleshooting
* Ownership
* Support

Production readiness should include monitoring, alerts, rollback and escalation information.

## Self-Service

Developers should be able to:

* Create standard repositories
* Consume Terraform modules
* Consume reusable workflows
* Run tests and security scans
* Access platform documentation

## Completion Criteria

An application is onboarded when:

* Standard repository structure is used.
* Tests and CI are configured.
* Security scanning is enabled.
* Approved infrastructure modules are used.
* Terraform validation passes.
* Monitoring and ownership are documented.
* Deployment and rollback procedures exist.
