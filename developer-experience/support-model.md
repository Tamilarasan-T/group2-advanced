# Platform Support Model

## Purpose

This document defines the support model for application teams consuming the Acme Retail Internal Developer Platform.

The objective is to provide clear ownership, escalation paths, and support expectations while maintaining a self-service platform.

## Support Principles

The platform support model follows these principles:

- Self-service first
- Clear ownership
- Standardized troubleshooting
- Fast incident escalation
- Documented operational procedures
- Reusable solutions
- Continuous improvement

## Ownership Model

### Application Team

The application team owns:

- Application source code
- Application configuration
- Application-specific dependencies
- Application-specific tests
- Application behavior
- Application-specific infrastructure configuration
- Application-level monitoring requirements

### Platform Engineering

Platform Engineering owns:

- Terraform modules
- Reusable GitHub Actions workflows
- Repository templates
- Platform standards
- Developer experience documentation
- Platform security controls
- Platform infrastructure capabilities

### Security Team

Security owns or provides guidance for:

- Security policies
- Vulnerability management
- Security exceptions
- Security incidents
- Security compliance requirements
- Security tooling standards

### Infrastructure / Cloud Team

The Infrastructure or Cloud team supports:

- Cloud account configuration
- Shared networking
- Cloud platform services
- Organization-level infrastructure
- Cloud governance

## Support Categories

### Category 1 — Application Issue

Examples:

- Application error
- Application configuration issue
- Application test failure
- Application dependency problem

**Primary owner:** Application Team

### Category 2 — Platform Workflow Issue

Examples:

- Reusable CI failure
- Reusable security workflow failure
- Reusable Terraform workflow failure

**Primary owner:** Platform Engineering

### Category 3 — Terraform Module Issue

Examples:

- Network module failure
- IAM module failure
- Container module failure
- Observability module failure

**Primary owner:** Platform Engineering

### Category 4 — Security Issue

Examples:

- Secret detected
- Critical vulnerability
- IAM security issue
- Security policy violation

**Primary owner:** Security Team with Application or Platform Engineering support as applicable

### Category 5 — Cloud Infrastructure Issue

Examples:

- AWS service issue
- Network connectivity problem
- Cloud resource availability issue
- Account-level configuration issue

**Primary owner:** Infrastructure / Cloud Team

## Self-Service Troubleshooting

Before raising a support request, application teams should check:

1. Repository documentation.
2. Workflow logs.
3. Terraform validation output.
4. Security scan results.
5. Known issues.
6. Platform documentation.
7. Recent platform changes.

## Common Troubleshooting

### CI Failure

Check:

- Failed workflow job
- Error message
- Dependency installation
- Test output
- Runtime version
- Recent source changes

### Gitleaks Failure

Check:

- Identified file
- Secret type
- Whether the detected value is actually a secret
- Whether the secret must be revoked

A real exposed credential should be treated as a security issue.

### Trivy Failure

Check:

- Vulnerability identifier
- Severity
- Affected package
- Available fixed version
- Base image version

### Checkov Failure

Check:

- Failed check ID
- Affected Terraform resource
- Security recommendation
- Whether remediation is possible

Do not suppress security findings without following the exception process.

### Terraform Failure

Check:

- Terraform version
- Formatting
- Initialization
- Validation output
- Provider version
- Module inputs
- Variable values

## Escalation Flow

The standard escalation flow is:

```text
Developer
    ↓
Application Team
    ↓
Platform Engineering
    ↓
Security / Cloud / Network / Database
    ↓
Specialist Team


Escalation should include relevant evidence rather than only a description of the problem.

## Support Request Information

A support request should include:

* Repository
* Application
* Environment
* Workflow name
* Failed job
* Error message
* Timestamp
* Recent changes
* Relevant logs
* Impact
* Troubleshooting already performed

## Incident Management

Production-impacting issues should follow the organization's incident-management process.

The incident should identify:

* Impact
* Affected application
* Environment
* Start time
* Current status
* Actions taken
* Owner
* Escalation
* Resolution
* Follow-up actions

## Platform Incidents

Platform Engineering should treat widespread failures differently from application-specific failures.

Examples of platform incidents:

* Reusable workflow failure affecting multiple repositories
* Terraform module regression
* Repository template defect
* Platform security workflow failure
* Shared infrastructure failure

Platform incidents should be investigated for broader impact.

## Change Management

Platform changes should follow appropriate review and validation.

Examples include:

* Terraform module changes
* Reusable workflow changes
* Security control changes
* Repository template changes
* Governance changes

Changes should be tested before broad adoption.

## Knowledge Management

Recurring problems should be converted into reusable documentation.

Examples:


Incident
   ↓
Root Cause
   ↓
Resolution
   ↓
Documentation
   ↓
Automation / Platform Improvement


## Service Improvement

Platform Engineering should periodically review:

* Common support requests
* CI failures
* Security findings
* Onboarding issues
* Developer feedback
* Platform reliability
* Documentation gaps

Recurring issues should be considered for automation or platform improvements.

## Developer Experience Metrics

Useful metrics include:

* Repository onboarding time
* CI success rate
* Average CI duration
* Security finding remediation time
* Terraform validation failure rate
* Number of support requests
* Platform incident count
* Self-service adoption
* Developer satisfaction

## Responsibilities

### Application Teams

* Use self-service capabilities.
* Follow platform standards.
* Troubleshoot using documentation.
* Provide complete support information.
* Escalate when required.

### Platform Engineering

* Maintain platform capabilities.
* Provide reusable solutions.
* Maintain documentation.
* Resolve platform defects.
* Monitor developer experience.

### Security Team

* Maintain security standards.
* Review security exceptions.
* Support security incidents.
* Provide security guidance.

## Definition of Done

The support model is complete when:

* Ownership is clearly defined.
* Support categories are documented.
* Troubleshooting guidance exists.
* Escalation paths are defined.
* Incident information requirements are documented.
* Platform improvement feedback is captured.
* Developer experience metrics are defined.
