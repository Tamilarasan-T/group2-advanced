# Security Policy

## Purpose

Define minimum security controls for repositories and platform capabilities on the Acme Retail Internal Developer Platform.

## Principles

- Secure by default
- Least privilege
- Defense in depth
- Shift-left security
- No hard-coded credentials
- Automated validation
- Traceable changes

## Secret Management

Secrets must never be committed to source control.

Use approved mechanisms such as:

- GitHub Secrets
- GitHub Environments
- AWS Secrets Manager

## Security Scanning

Required controls where applicable:

| Tool | Purpose |
|---|---|
| Gitleaks | Secret scanning |
| Trivy | Vulnerability scanning |
| Checkov | Terraform security |

High/Critical findings should block merging unless an approved exception exists.

## Container Security

Containers should:

- Use trusted/minimal images.
- Avoid embedded secrets.
- Run as non-root where practical.
- Use immutable image tags.
- Be vulnerability scanned.

## Infrastructure Security

Terraform must follow:

- Least-privilege IAM
- Encryption
- Restricted network access
- Secure logging
- Standard tagging
- Environment separation
- Checkov validation

## IAM and Network

IAM must avoid unnecessary wildcard permissions and use restricted service principals.

Network infrastructure should minimize public exposure, restrict administrative access and separate public/private workloads where required.

## Logging

Security-relevant logs should use approved monitoring standards.

The platform supports:

- CloudWatch Logs
- KMS encryption
- Configurable retention
- Standard tagging

## Security Gates

```text
Pull Request
     ↓
Gitleaks
     ↓
Trivy
     ↓
Checkov
     ↓
Tests
     ↓
Review
     ↓
Merge
````

Required security checks must pass before merge.

## Exceptions

Security exceptions must be:

* Documented
* Risk-assessed
* Approved
* Time-bound
* Assigned an owner
* Supported by a remediation plan

## Production Security

IAM, network, authentication, authorization, secrets, encryption and security-control changes require appropriate owner/security review.

## Incident Response

Potential security incidents must be reported through the approved incident-management process, investigated, remediated and documented.

## Responsibilities

**Application Teams:** Secure code, dependencies, containers and application configuration.

**Platform Team:** Secure workflows, Terraform modules, repository standards and tooling.

**Security Team:** Security standards, exceptions, vulnerability governance and incident guidance.

## Definition of Done

A repository is security-compliant when applicable security scanning, secret protection, least privilege, secure infrastructure, appropriate reviews and exception controls are implemented.
