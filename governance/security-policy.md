# Security Policy

## Purpose

This policy defines the minimum security controls for repositories and platform capabilities onboarded to the Acme Retail Internal Developer Platform.

The objective is to identify security risks early, prevent secrets from entering source control, and establish consistent security controls across application and infrastructure repositories.

## Security Principles

The platform follows these principles:

- Secure by default
- Least privilege
- Defense in depth
- Shift-left security
- No hardcoded credentials
- Automated security validation
- Traceable changes
- Continuous improvement

## Secret Management

Secrets must never be committed to source control.

Examples include:

- Cloud access keys
- Passwords
- API tokens
- Private keys
- Database credentials
- Service credentials
- Authentication tokens

Approved secret-management mechanisms must be used for runtime secrets.

GitHub Actions secrets or approved external secret-management platforms may be used according to organizational standards.

## Secret Scanning

Repositories should use Gitleaks or an approved equivalent to detect accidentally committed secrets.

Secret scanning should run:

- During Pull Requests
- During protected branch changes
- As part of reusable platform workflows

A detected secret should be treated as a security incident until verified otherwise.

## Dependency and Filesystem Scanning

Trivy or an approved equivalent should scan application dependencies and relevant repository content.

High and critical vulnerabilities should fail the applicable security pipeline unless an approved exception exists.

Unfixed vulnerabilities may be handled according to the organization's vulnerability-management process.

## Container Security

Container images should:

- Use trusted base images.
- Avoid unnecessary packages.
- Run as a non-root user where practical.
- Be scanned for vulnerabilities.
- Avoid embedding secrets.
- Use immutable image tags where supported.
- Be rebuilt when critical vulnerabilities require remediation.

The platform container module enables immutable ECR image tags and image scanning.

## Infrastructure Security

Terraform code must pass the required security validation.

Checkov or an approved equivalent should be used to identify infrastructure security issues.

Infrastructure should follow:

- Least privilege
- Encryption at rest
- Encryption in transit where applicable
- Restricted network access
- Secure logging
- Appropriate retention
- Standard tagging
- Environment separation

## IAM Security

IAM policies should follow least privilege.

The following practices are required:

- Avoid unnecessary wildcard permissions.
- Restrict resources where practical.
- Use approved service principals.
- Avoid long-lived access credentials.
- Review privileged permissions.
- Separate application and administrative roles.

## Network Security

Network infrastructure should:

- Avoid unnecessary public exposure.
- Restrict administrative ports.
- Use security groups with minimal access.
- Enable appropriate logging.
- Separate public and private workloads where required.
- Use approved network security controls.

## Logging and Monitoring

Security-relevant events should be logged and monitored.

The platform observability capability provides:

- CloudWatch Log Groups
- KMS encryption
- Configurable retention
- Standardized resource tagging

Production workloads should integrate with the organization's monitoring and alerting standards.

## Security Gates

Applicable repositories should enforce security checks before merge.

Example:

Pull Request
     |
     +--> Gitleaks
     |
     +--> Trivy
     |
     +--> Checkov
     |
     +--> Tests
     |
     +--> Review
     |
     +--> Merge


A failed security gate should prevent merging when the repository's governance configuration requires that check.

## Vulnerability Severity

Security findings should be prioritized based on:

* Severity
* Exploitability
* Exposure
* Business impact
* Environment
* Availability of remediation

High and critical findings should receive priority remediation.

Severity classifications should follow the organization's approved vulnerability-management standard.

## Security Exceptions

A security control may only be bypassed through an approved exception process.

Exceptions must document:

* Repository or system
* Security finding
* Business or technical reason
* Risk assessment
* Compensating controls
* Owner
* Approval
* Expiration date
* Remediation plan

Exceptions must be time-bound.

Permanent security exceptions should not be used as a substitute for remediation.

## Production Security

Production changes should receive the required approvals.

Changes involving:

* IAM
* Network access
* Authentication
* Authorization
* Secrets
* Encryption
* Security controls

should receive appropriate owner or security review.

## Security Incident Response

When a potential security incident is identified:

1. Preserve relevant evidence.
2. Report through the approved incident-management process.
3. Restrict or revoke compromised credentials when appropriate.
4. Assess affected systems.
5. Remediate the issue.
6. Document the incident.
7. Perform follow-up actions when required.

## Developer Responsibilities

Developers and application teams are responsible for:

* Following secure coding practices.
* Protecting credentials.
* Reviewing security findings.
* Updating vulnerable dependencies.
* Maintaining secure container images.
* Following repository governance.
* Reporting suspected security incidents.

## Platform Engineering Responsibilities

Platform Engineering is responsible for:

* Maintaining reusable security workflows.
* Maintaining secure Terraform modules.
* Maintaining repository security standards.
* Updating security tooling.
* Providing secure defaults.
* Monitoring platform security requirements.

## Security Team Responsibilities

The Security team provides:

* Security guidance
* Vulnerability-management standards
* Security exception review
* Incident-response guidance
* Compliance requirements

## Definition of Done

A repository is security-compliant when applicable controls are implemented:

* Secret scanning enabled
* Vulnerability scanning enabled
* Infrastructure security scanning enabled
* Required security checks enforced
* Secrets excluded from source control
* IAM follows least privilege
* Containers follow secure practices
* Infrastructure uses secure defaults
* Security exceptions are documented and time-bound
* Security-sensitive changes receive appropriate review

