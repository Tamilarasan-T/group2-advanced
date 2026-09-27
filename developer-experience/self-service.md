# Self-Service Platform Guide

## Purpose

Enable application teams to consume standardized platform capabilities without requiring manual Platform Engineering implementation.

## Platform Capabilities

```text
Repository Template
       ↓
Reusable CI/CD
       ↓
Security
       ↓
Terraform Modules
       ↓
Governance
       ↓
Application Delivery
````

Available capabilities:

* Repository template
* Reusable CI workflow
* Reusable security workflow
* Reusable Terraform workflow
* Network module
* IAM module
* Container module
* Observability module

## Self-Service Lifecycle

```text
Select Template
      ↓
Create Repository
      ↓
Configure Application
      ↓
Consume Platform Capabilities
      ↓
Validate
      ↓
Pull Request
      ↓
Review / Approval
      ↓
Deploy
      ↓
Monitor
```

## Reusable Workflows

Applications should consume:

```text
reusable-ci.yml
reusable-security.yml
reusable-terraform.yml
```

Common CI/CD logic should not be duplicated in application repositories.

## Terraform Modules

Applications should consume approved modules instead of recreating common infrastructure:

```text
network
iam
container
observability
```

## Versioning

Teams should use approved versions of:

* Terraform modules
* Reusable workflows
* Repository templates

Breaking changes require an upgrade path.

## Ownership

**Platform Team**

* Terraform modules
* Reusable workflows
* Repository templates
* Platform standards
* Security defaults

**Application Teams**

* Application code
* Application configuration
* Tests
* Application-specific infrastructure

## Guardrails

Self-service must still follow:

* Security scanning
* CI validation
* Terraform validation
* Branch protection
* PR review
* CODEOWNERS
* Secret protection
* Production approval

## Exceptions

Teams unable to use a standard capability must follow the documented exception process.

## Definition of Done

Application teams can:

* Start from the repository template.
* Consume Terraform modules.
* Consume reusable workflows.
* Pass quality and security gates.
* Follow governance.
* Deploy through the approved process.
* Access operational documentation.
