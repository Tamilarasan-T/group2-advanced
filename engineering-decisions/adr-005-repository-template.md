# ADR-005: Standard Repository Template

## Context

Application teams currently use different repository structures, documentation formats, testing approaches, and CI/CD configurations.

This inconsistency increases onboarding time and makes platform automation harder to maintain.

A standard repository structure is required so that application teams begin with a consistent engineering baseline.

## Problem

The platform needs a repository template that:

- Provides a predictable repository structure
- Includes standard development and testing locations
- Integrates with reusable CI/CD workflows
- Includes security and governance standards
- Provides consistent documentation
- Supports Terraform infrastructure
- Reduces application onboarding effort
- Allows application teams to customize application-specific code

## Decision

We will provide a standard repository template for application teams.

The template will contain:

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
.dockerignore
.gitignore
README.md
````

The template will provide baseline examples for:

* Application code
* Automated tests
* Terraform infrastructure
* Docker containerization
* CI/CD integration
* Documentation
* Architecture documentation
* AI Engineering Specifications
* Engineering decisions

The template will also provide standard repository files such as:

* `README.md`
* `Dockerfile`
* `.dockerignore`
* `.gitignore`
* `.github/CODEOWNERS`

## Alternatives

### Alternative 1: No standard repository structure

Each application team creates and maintains its own repository structure.

### Alternative 2: Centralized monolithic application repository

Multiple applications are maintained within one common repository structure.

### Alternative 3: Standard application repository template

Each application starts from a standardized template while retaining ownership of application-specific implementation.

## Trade-offs

### Benefits

* Faster application onboarding
* Consistent repository structure
* Easier automation
* Easier developer navigation
* Consistent security and governance integration
* Reduced setup effort
* Better platform maintainability

### Costs

* Teams must follow the standard baseline
* Template changes require version management
* Some applications may require additional customization
* Template maintenance becomes a platform responsibility

## Consequences

New application repositories will start from the standard template.

Application teams will be responsible for adding:

* Application-specific business logic
* Application-specific tests
* Application configuration
* Application-specific documentation

Platform-owned components such as reusable workflows, security controls, and Terraform modules will remain standardized.

The template will be validated automatically to ensure required files and directories remain available.

## Rationale

A standard repository template provides a consistent starting point for application teams while preserving application-level flexibility.

It directly addresses inconsistent repository structures and reduces the amount of repetitive setup required when onboarding new applications.

The template also provides a foundation for self-service platform capabilities.

## Status

Accepted
