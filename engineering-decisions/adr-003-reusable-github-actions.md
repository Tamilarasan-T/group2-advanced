# ADR-003: Reusable GitHub Actions Workflows

## Context

Application teams currently require common CI/CD activities such as application testing, security scanning, and Terraform validation.

Maintaining separate workflow implementations for every application can result in duplicated YAML, inconsistent security controls, and different pipeline behavior across teams.

The platform should provide reusable CI/CD capabilities that application repositories can consume with minimal configuration.

## Problem

We need a standardized CI/CD approach that:

- Reduces duplicated workflow code
- Provides consistent quality and security checks
- Supports multiple application repositories
- Allows application teams to configure supported inputs
- Provides clear and consistent pipeline feedback
- Can be maintained centrally

## Decision

We will implement reusable GitHub Actions workflows using GitHub Actions `workflow_call`.

The platform will provide reusable workflows for:

- Application CI
- Security scanning
- Terraform validation

Application repositories will consume these workflows instead of duplicating common pipeline logic.

The standard CI/CD flow will include:

```text
Pull Request
     |
     v
Application CI
     |
     +--> Tests
     |
     v
Security
     |
     +--> Gitleaks
     +--> Trivy
     +--> Checkov
     |
     v
Terraform Validation
     |
     +--> Format
     +--> Init
     +--> Validate
     +--> Checkov
````

Reusable workflows will expose controlled inputs such as:

* Python version
* Working directory
* Terraform version
* Scan directory
* Whether specific security checks should run

Workflows will use least-privilege permissions and concurrency controls.

## Alternatives

### Alternative 1: Individual workflows per application

Each application team creates and maintains its own complete GitHub Actions workflows.

### Alternative 2: One centralized workflow with application-specific logic

A single workflow contains conditional logic for different applications.

### Alternative 3: Reusable workflows

Common CI/CD capabilities are implemented once and consumed through standardized reusable workflows.

## Trade-offs

### Benefits

* Reduces duplicated workflow code
* Provides consistent CI/CD behavior
* Centralizes common security controls
* Simplifies application repository setup
* Makes improvements available to multiple teams
* Improves platform maintainability

### Costs

* Reusable workflows require interface and version management
* Changes can affect multiple consuming repositories
* Application-specific requirements may require additional inputs
* Workflow failures may require platform-team support

## Consequences

Application repositories can invoke platform workflows using a small configuration.

For example:

```yaml
jobs:
  ci:
    uses: ./.github/workflows/reusable-ci.yml
    with:
      python-version: "3.12"
      working-directory: "app"
```

Security and Terraform workflows can similarly be reused without copying their implementation into every application repository.

The platform team owns the reusable workflow implementation and its documentation.

Application teams remain responsible for application-specific tests, configuration, and deployment requirements.

## Rationale

Reusable GitHub Actions workflows provide a practical mechanism for standardizing CI/CD while keeping application repositories lightweight.

The approach directly addresses duplicated pipeline implementations and enables centralized security and quality controls.

It also supports the platform's goals of reusability, automation, standardization, and improved developer experience.

## Status

Accepted

After that, we'll create **ADR-004 — Security by Default**, covering **Gitleaks + Trivy + Checkov + Terraform secure defaults**.
```
