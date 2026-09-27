# Platform Support Model

## Purpose

Define ownership, troubleshooting and escalation for teams using the Acme Retail Internal Developer Platform.

## Ownership

| Area | Owner |
|---|---|
| Application code/configuration | Application Team |
| Terraform modules | Platform Engineering |
| Reusable workflows | Platform Engineering |
| Repository templates | Platform Engineering |
| Platform security | Platform / Security |
| Security incidents | Security Team |
| Cloud/shared infrastructure | Infrastructure / Cloud Team |

## Support Categories

- **Application issues** → Application Team
- **Workflow/module issues** → Platform Engineering
- **Security issues** → Security Team
- **Cloud infrastructure issues** → Infrastructure / Cloud Team

## Self-Service Troubleshooting

Before escalation, check:

1. Repository documentation
2. Workflow logs
3. Terraform output
4. Security scan results
5. Recent changes
6. Known issues

## Common Failures

**CI:** Check failed job, error logs, dependencies, tests and runtime.

**Gitleaks:** Identify the detected secret and revoke it if genuine.

**Trivy:** Check vulnerability, severity, affected package/image and available fix.

**Checkov:** Check failed control, affected Terraform resource and remediation.

**Terraform:** Check version, formatting, initialization, validation, providers and module inputs.

Security findings must not be suppressed without following the exception process.

## Escalation

```text
Developer
   ↓
Application Team
   ↓
Platform Engineering
   ↓
Security / Cloud / Specialist Team
````

Support requests should include:

* Repository/application
* Environment
* Failed workflow/job
* Error message
* Timestamp
* Recent changes
* Relevant logs
* Impact
* Troubleshooting performed

## Incident Management

Production-impacting issues must follow the organization's incident process.

Record:

* Impact
* Affected application/environment
* Status
* Actions
* Owner
* Escalation
* Resolution
* Follow-up actions

## Platform Incidents

Platform Engineering should investigate failures affecting multiple repositories, such as:

* Reusable workflow failures
* Terraform module regressions
* Repository template defects
* Platform security workflow failures
* Shared infrastructure failures

## Continuous Improvement

Recurring issues should be converted into:

```text
Incident → Root Cause → Resolution → Documentation → Automation
```

Track:

* Onboarding time
* CI success rate
* Security remediation time
* Terraform failure rate
* Support requests
* Platform incidents
* Self-service adoption

## Definition of Done

The support model is complete when ownership, troubleshooting, escalation, incident handling and improvement processes are documented.
