# AI Engineering Specification — Reusable Terraform Modules

## 1. Document Information

| Field         | Value                                   |
| ------------- | --------------------------------------- |
| Specification | Reusable Terraform Modules              |
| Version       | 1.0                                     |
| Status        | Approved                                |
| Platform      | Acme Retail Internal Developer Platform |
| IaC           | Terraform                               |
| Cloud         | AWS                                     |
| Security      | Checkov                                 |

## 2. Purpose

Provide reusable, secure and versioned Terraform modules for common AWS infrastructure.

Application teams must consume platform modules instead of duplicating infrastructure code.

## 3. Business Problem

Independent infrastructure implementations cause:

* Duplicate Terraform code
* Inconsistent architecture and security
* Configuration drift
* Higher maintenance effort
* Longer onboarding

The platform standardizes infrastructure through reusable modules.

## 4. Goals

* Reusable AWS infrastructure
* Secure defaults
* Multiple applications and environments
* Configurable inputs and outputs
* Module versioning
* CI/CD integration
* Checkov security scanning
* Reproducible validation

## 5. Module Architecture

```text
infrastructure/
└── modules/
    ├── network/
    ├── iam/
    ├── container/
    └── observability/
```

## 6. Module Standards

Each module must:

* Have one clear responsibility.
* Avoid application-specific logic.
* Use configurable variables.
* Provide documented outputs.
* Use secure defaults.
* Include validation where appropriate.
* Be independently testable.

Standard structure:

```text
module/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
├── README.md
└── tests/
```

## 7. Platform Modules

**Network:** VPC, subnets, routing and network controls.

**IAM:** Reusable roles and policies using least privilege.

**Container:** ECR/container infrastructure with secure configuration and image scanning.

**Observability:** CloudWatch logging, retention, metrics and alarms where required.

## 8. Security Standards

* No credentials or secrets in Terraform source.
* Least-privilege IAM.
* Avoid unrestricted `Action = "*"` / `Resource = "*"`.
* Encrypt supported resources.
* Avoid public access by default.
* Restrict administrative ports.
* Checkov scanning is required.

## 9. Input and Output Standards

Variables must have descriptions, appropriate types and validation where useful.

Sensitive inputs must be marked sensitive.

Outputs must be documented and must not unnecessarily expose secrets.

## 10. Standard Tags

AWS resources should use:

```text
Application
Environment
ManagedBy
Owner
CostCenter
```

## 11. Versioning and State

Modules must define supported Terraform/provider versions and use semantic versioning:

```text
MAJOR.MINOR.PATCH
```

Breaking changes require a major version.

Terraform state must never be committed:

```text
*.tfstate
*.tfstate.*
.terraform/
```

AWS environments should use secure remote state with encryption, access control and state locking.

## 12. Environment Separation

```text
infrastructure/
├── modules/
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Environment-specific configuration must not be hard-coded inside reusable modules.

## 13. CI/CD and Validation

Terraform changes must run:

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

Production changes require appropriate approval.

Local validation must not require live AWS infrastructure.

## 14. Reusability

The same modules must support multiple applications.

```text
Reusable Terraform Modules
        /          \
   Orders API    Payments API
```

Applications may use different configuration values but must not duplicate module implementations.

## 15. Acceptance Criteria / Definition of Done

* [ ] Standard module structure is followed.
* [ ] Network, IAM, Container and Observability modules are implemented.
* [ ] No application-specific logic exists.
* [ ] Secure defaults are implemented.
* [ ] Checkov passes.
* [ ] Terraform format and validation pass.
* [ ] No secrets are stored in source.
* [ ] Terraform state is excluded from Git.
* [ ] CI/CD validation works.
* [ ] Orders API consumes the modules.
* [ ] Payments API consumes the same modules.
* [ ] Modules are documented and version controlled.
* [ ] Infrastructure duplication is eliminated.
