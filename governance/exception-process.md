# Security and Governance Exception Process

## Purpose

This process defines how teams request, review, approve, track, and close exceptions to platform engineering, security, governance, or compliance requirements.

Exceptions are intended for temporary situations where the standard platform requirement cannot reasonably be met.

## Exception Principles

Exceptions must be:

- Justified
- Risk-assessed
- Approved by the appropriate owner
- Time-bound
- Documented
- Traceable
- Reviewed periodically
- Remediated where possible

An exception must not be used to permanently avoid a required security or governance control.

## When an Exception May Be Required

An exception may be required when a team cannot temporarily meet a mandatory requirement such as:

- Security scanning
- Terraform security controls
- Branch protection
- Required Pull Request approvals
- Dependency remediation
- Container security requirements
- Infrastructure standards
- Logging requirements
- Encryption requirements
- Production approval requirements

## Exception Request

The request should contain:

| Field | Description |
|---|---|
| Exception ID | Unique identifier |
| Repository/System | Affected repository or system |
| Environment | dev, test, or prod |
| Requirement | Control being requested for exception |
| Reason | Why the requirement cannot currently be met |
| Risk | Identified security or operational risk |
| Impact | Potential business or technical impact |
| Compensating Controls | Controls reducing the risk |
| Owner | Person/team responsible |
| Remediation Plan | Planned corrective action |
| Requested Expiry | Date when exception expires |
| Approver | Required approving authority |

## Risk Assessment

The requester should assess:

- Likelihood of the risk
- Potential impact
- Affected systems
- Data sensitivity
- Production exposure
- Security implications
- Operational implications
- Availability of compensating controls

The assessment should be based on documented evidence rather than assumptions.

## Approval

Exceptions must be approved by the appropriate owner based on the affected control.

Examples:


Application standard
        ↓
Application Owner

Platform standard
        ↓
Platform Engineering

Security control
        ↓
Security Owner / Security Team

Production infrastructure
        ↓
Required Infrastructure / Application Owner

Compliance requirement
        ↓
Required Compliance / Security Owner


Higher-risk exceptions may require additional approval.

## Compensating Controls

When the standard control cannot be implemented, the requester should identify alternative controls.

Examples:

* Additional monitoring
* Restricted network access
* Temporary manual review
* Reduced access permissions
* Increased logging
* Additional approval
* Temporary isolation
* Increased vulnerability monitoring

Compensating controls must be practical and verifiable.

## Exception Duration

Exceptions must have an explicit expiration date.

The default principle is:

> The exception remains valid only for the minimum period required to resolve the underlying issue.

Expired exceptions must not automatically become permanent.

## Remediation Plan

Every exception should have a remediation plan when remediation is technically possible.

The plan should identify:

* Required change
* Responsible owner
* Target completion date
* Dependencies
* Validation method

## Tracking

Approved exceptions should be tracked in an approved system such as:

* Governance repository
* Issue tracker
* Risk register
* Security management platform

The tracking record should contain the approval and expiration information.

## Review

Exceptions should be reviewed before expiration.

The review should determine whether:

1. The exception can be closed.
2. The requirement can now be satisfied.
3. Additional remediation is required.
4. A new exception request is genuinely necessary.

Extensions require renewed justification and approval.

## Emergency Exceptions

Emergency exceptions may be used when immediate action is required to protect:

* Availability
* Security
* Customer impact
* Critical production services

Emergency exceptions must still be documented.

After the emergency:

1. Document the reason.
2. Record the affected control.
3. Identify the risk.
4. Document compensating controls.
5. Obtain retrospective review.
6. Create remediation actions if required.

## Exception Closure

An exception is closed when:

* The required control has been implemented.
* Validation has passed.
* Compensating controls are no longer required.
* The exception record is updated.
* Supporting evidence is available.

Example:

Exception Created
       ↓
Risk Assessed
       ↓
Compensating Controls
       ↓
Approval
       ↓
Temporary Exception
       ↓
Remediation
       ↓
Validation
       ↓
Exception Closed


## Auditability

Exception records should provide evidence of:

* Request
* Risk assessment
* Approval
* Compensating controls
* Expiration date
* Remediation
* Closure

This ensures that governance decisions remain traceable.

## Responsibilities

### Requester

Responsible for:

* Providing accurate information.
* Assessing the risk.
* Identifying compensating controls.
* Completing remediation.

### Platform Engineering

Responsible for:

* Reviewing platform-related exceptions.
* Maintaining platform standards.
* Supporting remediation.
* Tracking platform exceptions.

### Security Team

Responsible for:

* Reviewing security-related exceptions.
* Providing risk guidance.
* Defining required security controls.
* Reviewing high-risk exceptions.

### Application or Infrastructure Owner

Responsible for:

* Accepting appropriate operational risk.
* Ensuring remediation occurs.
* Confirming exception closure.

## Definition of Done

An exception process is considered complete when:

* Exception is documented.
* Affected control is identified.
* Risk is assessed.
* Compensating controls are documented.
* Appropriate approval is obtained.
* Expiration date is defined.
* Remediation owner is assigned.
* Exception is tracked.
* Closure is validated and documented.



