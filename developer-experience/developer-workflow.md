# Standard Developer Workflow

## Purpose

This document defines the standard development workflow for application teams using the Acme Retail Internal Developer Platform.

The workflow provides a consistent path from development through testing, security validation, review, and deployment.

## Workflow Overview

```text
Developer
   ↓
Create Branch
   ↓
Develop
   ↓
Run Local Tests
   ↓
Create Pull Request
   ↓
CI Validation
   ↓
Security Validation
   ↓
Code Review
   ↓
Merge
   ↓
Build
   ↓
Deploy
   ↓
Monitor


## 1. Create a Branch

Developers should create a short-lived branch from the protected `main` branch.

Recommended naming:


feature/<short-description>
bugfix/<short-description>
security/<short-description>
infra/<short-description>
docs/<short-description>


Example:

feature/order-api


## 2. Development

Developers should:

* Follow repository standards.
* Keep changes focused.
* Avoid unnecessary modifications.
* Follow secure coding practices.
* Update documentation when required.
* Add or update tests.

## 3. Local Validation

Before creating a Pull Request, developers should run applicable local checks.

For Python applications:


pytest tests -v


For Terraform:


terraform fmt
terraform validate


Security tools should also be used locally where practical.

## 4. Commit Changes

Commits should clearly describe the change.

Examples:


Add order health endpoint
Fix authentication configuration
Update Terraform IAM module
Improve application logging


Developers should not commit:

* Passwords
* API keys
* Cloud credentials
* Private keys
* Tokens
* Local environment secrets

## 5. Pull Request

Create a Pull Request against the protected `main` branch.

The Pull Request should contain:

* Summary
* Technical changes
* Testing performed
* Security impact
* Infrastructure impact
* Related task or issue

## 6. Automated CI

The platform reusable CI workflow performs standardized validation.

Typical checks include:


Checkout
   ↓
Runtime Setup
   ↓
Dependency Installation
   ↓
Build
   ↓
Unit Tests


## 7. Security Validation

Applicable repositories consume the reusable security workflow.

Security checks include:


Gitleaks
   ↓
Trivy Filesystem
   ↓
Trivy Container Image


Terraform repositories also use:


Checkov


Security checks should fail the Pull Request when configured as required status checks.

## 8. Infrastructure Validation

Terraform changes should follow:

Terraform Format
       ↓
Terraform Init
       ↓
Terraform Validate
       ↓
Checkov
       ↓
Terraform Plan


Production infrastructure changes require the appropriate review and approval process.

## 9. Code Review

Reviewers should evaluate:

* Correctness
* Maintainability
* Security
* Testing
* Performance where applicable
* Infrastructure impact
* Operational impact
* Documentation

CODEOWNERS should be used for ownership-sensitive areas.

## 10. Merge

A Pull Request can be merged only when applicable requirements are satisfied:

* Required approvals received
* Required CI checks passed
* Security checks passed
* Required conversations resolved
* CODEOWNERS approvals received where applicable

Protected branch controls must not be bypassed except through an approved emergency process.

## 11. Build

After merge, the CI/CD pipeline builds the application artifact or container image.

For containerized applications:


Source
  ↓
Docker Build
  ↓
Image Scan
  ↓
Container Registry


Images should use immutable version tags.

## 12. Deployment

The standard deployment progression is:


Development
     ↓
Test
     ↓
Production


Production deployments should require the organization's approved authorization.

## 13. Deployment Validation

After deployment, validate:

* Application availability
* Health checks
* Logs
* Error rates
* Resource utilization
* Security alerts
* Application-specific metrics

## 14. Monitoring

Applications should integrate with approved monitoring and observability capabilities.

Monitoring should provide visibility into:

* Availability
* Performance
* Errors
* Resource utilization
* Application health
* Security events

## 15. Rollback

Every production application should have a documented rollback strategy.

Possible rollback mechanisms include:

* Previous container image
* Previous application release
* Terraform rollback where safe and appropriate
* Configuration rollback

Rollback procedures must be tested where practical.

## 16. Documentation

Developers should update documentation when changes affect:

* Architecture
* Deployment
* Configuration
* Monitoring
* Security
* Operational procedures

Significant architectural decisions should be documented as ADRs.

## Platform Reuse

Application teams should prefer platform-provided reusable capabilities over implementing duplicate solutions.

Examples:


Application Team
      │
      ├── Reusable CI
      ├── Reusable Security
      ├── Reusable Terraform
      ├── Network Module
      ├── IAM Module
      ├── Container Module
      └── Observability Module


## Developer Experience Goals

The standard workflow should provide:

* Consistent development practices
* Fast feedback
* Automated validation
* Early security detection
* Reduced pipeline duplication
* Reusable infrastructure
* Clear ownership
* Easy onboarding
* Traceable deployments

## Definition of Done

A development change is complete when:

* Code is implemented.
* Tests are added or updated.
* Security checks pass.
* Required reviews are complete.
* Documentation is updated where applicable.
* Change is merged through the approved workflow.
* Deployment validation succeeds where applicable.
* Monitoring is available for production workloads.
