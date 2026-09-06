# AI Engineering Specification — Reusable Terraform Modules

## 1. Document Information

| Field         | Value                                   |
| ------------- | --------------------------------------- |
| Specification | Reusable Terraform Modules              |
| Version       | 1.0                                     |
| Status        | Draft                                   |
| Platform      | Acme Retail Internal Developer Platform |
| IaC           | Terraform                               |
| Cloud         | AWS                                     |
| Security      | Checkov                                 |
| Validation    | Terraform Validate                      |

---

## 2. Purpose

This specification defines the standards for reusable Terraform modules provided by the Internal Developer Platform.

The objective is to eliminate duplicated Terraform implementations across application teams while providing secure, maintainable, configurable, versioned, and well-documented infrastructure components.

Application teams must consume platform-provided Terraform modules instead of copying infrastructure implementation into individual application repositories.

---

## 3. Business Problem

Acme Retail application teams currently create infrastructure independently.

This results in:

* Duplicate Terraform code
* Inconsistent infrastructure architecture
* Inconsistent security configurations
* Increased maintenance effort
* Configuration drift
* Longer application onboarding
* Repeated troubleshooting
* Difficulty applying organization-wide standards

The platform must provide reusable infrastructure building blocks that solve these problems.

---

## 4. Goals

The Terraform platform must:

1. Provide reusable infrastructure modules.
2. Minimize duplicated Terraform code.
3. Provide secure defaults.
4. Support multiple application teams.
5. Support multiple environments.
6. Provide configurable module inputs.
7. Provide documented outputs.
8. Support module versioning.
9. Support local validation.
10. Integrate with CI/CD.
11. Integrate with Checkov security scanning.
12. Follow Terraform best practices.

---

## 5. Non-Goals

The initial implementation will not:

* Create modules for every AWS service.
* Implement unrestricted production infrastructure.
* Store credentials in Terraform source code.
* Create application-specific infrastructure modules.
* Hard-code environment-specific configuration inside reusable modules.
* Require AWS resources for basic Terraform validation.

---

## 6. Module Architecture

The initial platform should provide reusable modules for common infrastructure requirements.

```text
infrastructure/
└── modules/
    ├── network/
    ├── iam/
    ├── container/
    └── observability/
```

Additional modules may be introduced when a clear reusable requirement is identified.

---

## 7. Standard Module Structure

Every module must follow this structure:

```text
module-name/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── README.md
└── tests/
```

Optional files may include:

```text
locals.tf
data.tf
security.tf
```

Files should only be added when they improve clarity and maintainability.

---

## 8. Module Design Principles

Every Terraform module must:

* Have one clear responsibility.
* Avoid application-specific business logic.
* Use variables for configuration.
* Provide meaningful outputs.
* Use secure defaults.
* Avoid unnecessary complexity.
* Follow Terraform naming conventions.
* Include documentation.
* Include validation where appropriate.
* Be independently testable.

---

# 9. Network Module

## Purpose

Provide standardized networking infrastructure that can be reused by multiple applications.

Potential resources include:

* VPC
* Public subnets
* Private subnets
* Internet Gateway
* Route tables
* NAT configuration where required

### Required Inputs

The module should support configuration for:

* Environment
* VPC CIDR
* Availability Zones
* Public subnet configuration
* Private subnet configuration
* Application name
* Owner
* Cost center
* Tags

### Example

```hcl
module "network" {
  source = "../../modules/network"

  environment = "dev"
  vpc_cidr    = "10.0.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]
}
```

The implementation must avoid hard-coding environment-specific values inside the module.

---

# 10. IAM Module

## Purpose

Provide reusable IAM roles and policies following the principle of least privilege.

The module must:

* Prefer IAM roles over long-lived access keys.
* Avoid wildcard permissions where possible.
* Support explicit policies.
* Avoid hard-coded credentials.
* Support application-specific role requirements through controlled inputs.

The module should not create IAM users unless there is a documented business requirement.

---

# 11. Container Module

## Purpose

Provide reusable container infrastructure.

The initial implementation may support:

* Amazon ECR
* ECS-related resources where required
* Container image configuration

The module must support secure container deployment patterns.

Container images must be scanned before deployment.

The module must not embed credentials inside container configuration.

---

# 12. Observability Module

## Purpose

Provide standardized observability infrastructure.

Potential capabilities include:

* CloudWatch log groups
* Log retention
* Metrics
* Alarms

Log retention must be configurable.

The default retention period should be finite rather than unlimited.

---

# 13. Input Requirements

Terraform variables must:

* Have meaningful names.
* Have descriptions.
* Use appropriate Terraform types.
* Include validation rules where useful.
* Avoid unnecessary defaults.
* Mark sensitive inputs as sensitive where appropriate.

Example:

```hcl
variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "test", "prod"], var.environment)
    error_message = "Environment must be dev, test, or prod."
  }
}
```

---

# 14. Output Requirements

Outputs must:

* Have meaningful names.
* Include descriptions.
* Expose only required information.
* Never expose secrets unnecessarily.

Example:

```hcl
output "vpc_id" {
  description = "ID of the created VPC."
  value       = aws_vpc.this.id
}
```

Sensitive outputs must be marked appropriately.

---

# 15. Security Requirements

All Terraform modules must follow secure-by-default principles.

## Credentials

Never store:

* AWS access keys
* AWS secret keys
* Passwords
* Tokens
* Private keys

in Terraform source code.

## IAM

Use least-privilege policies.

Avoid unrestricted permissions such as:

```text
Action   = "*"
Resource = "*"
```

unless explicitly justified.

## Encryption

Enable encryption for supported resources.

## Public Access

Resources should not be publicly accessible by default.

## Security Groups

Avoid unrestricted inbound access to administrative ports.

For example, SSH/RDP should not normally be exposed to:

```text
0.0.0.0/0
```

---

# 16. Standard Tags

Supported AWS resources should use common organizational tags.

Minimum tags:

```text
Application
Environment
ManagedBy
Owner
CostCenter
```

Example:

```hcl
tags = {
  Application = var.application_name
  Environment = var.environment
  ManagedBy   = "Terraform"
  Owner       = var.owner
  CostCenter  = var.cost_center
}
```

---

# 17. Terraform Versioning

Modules must define supported Terraform versions.

Example:

```hcl
terraform {
  required_version = ">= 1.6.0"
}
```

Provider versions must also be constrained.

Platform modules should follow semantic versioning:

```text
MAJOR.MINOR.PATCH
```

Breaking changes require a major version.

Backward-compatible functionality requires a minor version.

Bug fixes require a patch version.

---

# 18. Environment Separation

Reusable modules must remain environment-independent.

Recommended structure:

```text
infrastructure/
├── modules/
│   ├── network/
│   ├── iam/
│   ├── container/
│   └── observability/
│
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Environment-specific values must be supplied by environment configurations.

---

# 19. Terraform State

Terraform state must never be committed to Git.

The repository must exclude:

```text
*.tfstate
*.tfstate.*
.terraform/
```

For AWS environments, remote state should use an appropriate backend with access control, encryption, and state locking.

For local validation, local state may be used temporarily.

---

# 20. CI/CD Integration

Terraform modules must integrate with the reusable platform workflow.

The pipeline should perform:

```text
Terraform Format
        ↓
Terraform Init
        ↓
Terraform Validate
        ↓
Checkov
        ↓
Terraform Plan
```

Production changes must require appropriate approval according to governance requirements.

---

# 21. Testing Strategy

Terraform modules must be validated at multiple levels.

### Formatting

```bash
terraform fmt -check -recursive
```

### Validation

```bash
terraform validate
```

### Security

```bash
checkov -d .
```

### Plan

```bash
terraform plan
```

Where practical, Terraform-native tests should be added to validate module behavior.

---

# 22. Local Validation

The platform must support Terraform validation without requiring dedicated AWS infrastructure.

Developers must be able to perform at minimum:

```text
Terraform formatting
Terraform initialization
Terraform validation
Checkov scanning
Static analysis
```

Actual AWS deployment is optional for local validation.

---

# 23. Documentation Requirements

Every module must contain a README documenting:

* Module purpose
* Supported Terraform versions
* Required providers
* Inputs
* Outputs
* Example usage
* Dependencies
* Security considerations
* Version information

---

# 24. Reusability Requirement

Terraform modules must support multiple applications.

Example:

```text
                  Network Module
                       │
          ┌────────────┼────────────┐
          │            │            │
         IMS         Orders      Payments
          │            │            │
        Team A       Team B       Team C
```

Applications may provide different configuration values but must consume the same platform module implementation.

---

# 25. Acceptance Criteria

### AC-001

All modules follow the standard directory structure.

### AC-002

Modules contain no application-specific business logic.

### AC-003

Variables and outputs are documented.

### AC-004

Terraform formatting passes.

### AC-005

Terraform validation passes.

### AC-006

Checkov scanning is integrated.

### AC-007

No credentials or secrets are stored in Terraform source code.

### AC-008

IAM configurations follow least-privilege principles.

### AC-009

Supported resources use standardized tags.

### AC-010

Terraform state is excluded from source control.

### AC-011

Environment-specific configuration is separated from reusable modules.

### AC-012

At least two sample applications can consume the modules.

### AC-013

CI/CD can validate Terraform changes automatically.

---

# 26. Definition of Done

The Terraform platform capability is complete when:

* Reusable modules are implemented.
* Modules are documented.
* Security scanning passes.
* Terraform validation passes.
* IMS consumes the reusable modules.
* A second sample application consumes the same modules.
* No duplicated infrastructure implementation exists between applications.
* CI/CD integration is working.
* Architectural decisions are documented.
* Local validation is reproducible.

