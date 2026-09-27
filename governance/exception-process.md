# Security and Governance Exception Process

## Purpose

Define how temporary exceptions to platform, security, governance or compliance requirements are requested, approved, tracked and closed.

## Principles

Exceptions must be:

- Justified
- Risk-assessed
- Approved
- Documented
- Time-bound
- Traceable
- Remediated where possible

Exceptions must not permanently bypass required controls.

## When Required

Exceptions may apply to:

- Security scanning
- Terraform security
- Branch protection
- PR approvals
- Dependency remediation
- Container security
- Infrastructure standards
- Logging or encryption
- Production approvals

## Request

Each exception should document:

| Field | Required Information |
|---|---|
| ID | Unique identifier |
| Repository/System | Affected resource |
| Environment | dev/test/prod |
| Requirement | Control being bypassed |
| Reason | Justification |
| Risk | Security/operational risk |
| Compensating Controls | Risk reduction |
| Owner | Responsible team/person |
| Remediation | Corrective action |
| Expiry | End date |
| Approver | Required authority |

## Approval

Approval depends on the affected control:

- Application → Application Owner
- Platform → Platform Engineering
- Security → Security Team
- Production → Appropriate Owner
- Compliance → Compliance/Security Owner

Higher-risk exceptions may require additional approval.

## Compensating Controls

Examples:

- Additional monitoring
- Restricted access
- Manual review
- Increased logging
- Temporary isolation
- Additional approval

## Expiration and Remediation

Every exception must have an expiration date and, where possible, a remediation plan with an owner and target date.

Extensions require renewed justification and approval.

## Emergency Exceptions

Emergency exceptions may be used for critical availability or security situations.

They must be documented and retrospectively reviewed.

## Closure

An exception is closed when:

- The required control is implemented.
- Validation passes.
- Remediation is complete.
- The exception record is updated.
- Evidence is retained.

```text
Request → Risk Assessment → Approval
       → Temporary Exception → Remediation
       → Validation → Closure
````

## Auditability

Retain evidence of:

* Request
* Risk assessment
* Approval
* Compensating controls
* Expiration
* Remediation
* Closure

## Responsibilities

**Requester:** Risk assessment, compensating controls and remediation.

**Platform Team:** Platform exceptions and remediation support.

**Security Team:** Security exceptions and risk guidance.

**Application/Infrastructure Owner:** Operational risk acceptance and closure.

## Definition of Done

An exception is complete when it is documented, risk-assessed, approved, time-bound, tracked, remediated and formally closed.
