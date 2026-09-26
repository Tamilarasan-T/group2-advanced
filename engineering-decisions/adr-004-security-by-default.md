# ADR-004: Security by Default

## Context

Acme Retail Ltd. requires a consistent security baseline across application repositories, CI/CD pipelines, and AWS infrastructure.

Security checks implemented independently by application teams can result in inconsistent coverage and may allow vulnerabilities, exposed secrets, or insecure infrastructure configurations to reach later stages of the delivery process.

Security must therefore be integrated into the platform's standard engineering workflow.

## Problem

The platform needs a security approach that:

- Detects accidentally committed secrets
- Identifies vulnerable dependencies and container images
- Detects insecure Terraform configurations
- Provides consistent security checks across teams
- Fails the pipeline when defined critical security thresholds are exceeded
- Uses secure infrastructure defaults
- Minimizes security configuration required from application teams

## Decision

Security controls will be implemented as standard platform capabilities and integrated into reusable CI/CD workflows.

The initial security controls are:

### Gitleaks

Used to detect secrets and credentials accidentally committed to repositories.

### Trivy

Used for filesystem and container image vulnerability scanning.

### Checkov

Used to analyze Terraform configurations for security and compliance issues.

### Terraform Secure Defaults

Reusable Terraform modules will enforce security-focused defaults, including:

- Encryption where supported
- KMS-backed encryption for supported resources
- Restricted security groups
- No unnecessary public access
- Least-privilege IAM policies
- VPC flow logging
- Resource tagging
- Configurable log retention
- No hard-coded credentials

Security validation will be executed automatically through CI/CD.

## Alternatives

### Alternative 1: Manual security reviews

Security checks are performed manually during application or infrastructure reviews.

### Alternative 2: Security checks only before production

Security scanning is performed only during the production release process.

### Alternative 3: Security integrated into reusable platform workflows

Security checks are automatically executed as part of the standard development and CI/CD workflow.

## Trade-offs

### Benefits

- Earlier detection of security issues
- Consistent security controls across applications
- Reduced dependency on manual security reviews
- Reusable security implementation
- Improved auditability
- Security becomes part of the normal developer workflow

### Costs

- CI/CD execution time increases
- Security tools require ongoing maintenance
- False positives may occasionally require investigation
- Platform changes may affect multiple application teams

## Consequences

Pull requests and platform changes will be automatically evaluated using the defined security controls.

A typical validation flow is:

```text
Pull Request
     |
     v
Gitleaks
     |
     v
Trivy
     |
     v
Terraform Validation
     |
     v
Checkov
     |
     v
Quality / Security Gate
````

Security findings must be reviewed and remediated according to the governance and exception process.

Temporary exceptions must be documented, approved by the appropriate owner, and have an expiry or remediation plan.

## Rationale

Integrating security into reusable platform capabilities provides a consistent security baseline without requiring every application team to independently implement the same controls.

Security-by-default also supports the platform's goals of automation, standardization, compliance, and reduced operational risk.

The approach follows a shift-left security model by identifying issues earlier in the software delivery lifecycle.

## Status

Accepted
