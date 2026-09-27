# Standard Developer Workflow

## Purpose

Define the standard development path from coding through validation, review, deployment and monitoring.

## Workflow

```text
Branch
  ↓
Develop + Test
  ↓
Pull Request
  ↓
CI + Security
  ↓
Review
  ↓
Merge
  ↓
Build
  ↓
Deploy
  ↓
Monitor
````

## Development

Use short-lived branches:

```text
feature/<name>
bugfix/<name>
security/<name>
infra/<name>
docs/<name>
```

Developers should follow repository standards, add tests and avoid committing secrets.

## Local Validation

Run applicable checks before creating a PR:

```text
Application → Tests
Terraform   → Format + Validate
Security    → Scans where practical
```

## Pull Request

PRs should include:

* Change summary
* Testing performed
* Security/infrastructure impact
* Related task where applicable

## CI and Security

Reusable platform workflows provide:

* Build and tests
* Gitleaks
* Trivy
* Terraform validation
* Checkov

Required checks must pass before merge.

## Terraform

```text
Format
  ↓
Init
  ↓
Validate
  ↓
Checkov
  ↓
Plan
```

Production infrastructure requires appropriate approval.

## Review and Merge

Merge requires applicable:

* Approvals
* CI/security checks
* CODEOWNERS approval
* Resolved conversations

Protected branches must not be bypassed except through an approved emergency process.

## Deployment

```text
Dev → Test → Production
```

Production deployment requires the approved authorization process.

After deployment, validate application health, logs, errors, resources and relevant security/operational metrics.

## Rollback

Production applications must have a documented rollback strategy, such as reverting to a previous application or container version.

## Monitoring and Documentation

Production workloads should have appropriate monitoring.

Update documentation when changes affect architecture, deployment, configuration, monitoring or security. Significant decisions should use ADRs.

## Platform Reuse

Application teams should consume reusable platform capabilities:

```text
CI/CD
Security
Terraform Modules
Repository Template
```

## Definition of Done

A change is complete when code, tests, security validation, required reviews, documentation and deployment validation are complete where applicable.
