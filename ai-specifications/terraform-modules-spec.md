# AI Engineering Specification — Reusable Terraform Modules

## 1. Document Information

| Field | Value |
|---|---|
| Specification | Reusable Terraform Modules |
| Version | 1.0 |
| Status | Approved |
| Platform | Acme Retail Internal Developer Platform |
| IaC | Terraform |
| Cloud | AWS |
| Security | Checkov |

---

## 2. Purpose

Provide reusable, secure and versioned Terraform modules for common AWS infrastructure.

Application teams must consume platform modules instead of duplicating infrastructure code.

---

## 3. Business Problem

Independent infrastructure implementations cause:

- Duplicate Terraform code
- Inconsistent architecture and security
- Configuration drift
- Higher maintenance effort
- Longer onboarding

The platform standardizes infrastructure through reusable modules.

---

## 4. Goals

The platform must:

- Provide reusable AWS infrastructure modules.
- Minimize duplicated Terraform.
- Use secure defaults.
- Support multiple applications and environments.
- Support configurable inputs and outputs.
- Support versioning.
- Integrate CI/CD and Checkov.
- Enable reproducible validation.

---

## 5. Module Architecture

```text
infrastructure/
└── modules/
    ├── network/
    ├── iam/
    ├── container/
    └── observability/
````

Additional modules may be added when a reusable platform requirement is identified.

---

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

---

## 7. Available Modules

### Network

Provides standardized VPC, subnets, routing and required network controls.

### IAM

Provides reusable IAM roles and policies using least privilege.

### Container

Provides reusable container infrastructure such as Amazon ECR with secure configuration and image scanning support.

### Observability

Provides standardized CloudWatch logging, retention, metrics and alarms where required.

---

## 8. Security Standards

All modules must follow secure-by-default principles.

* No credentials or secrets in Terraform source.
* Use least-privilege IAM.
* Avoid unrestricted `Action = "*"` / `Resource = "*"`.
* Encrypt supported resources.
* Avoid public access by default.
* Restrict administrative ports.
* Use Checkov security scanning.

---

## 9. Input and Output Standards

Variables must:

* Have descriptions and appropriate types.
* Use validation where useful.
* Avoid unnecessary defaults.
* Mark sensitive values appropriately.

Outputs must:

* Have meaningful names and descriptions.
* Expose only required information.
* Not unnecessarily expose secrets.

---

## 10. Standard Tags

AWS resources should use:

```text
Application
Environment
ManagedBy
Owner
CostCenter
```

---

## 11. Versioning and State

Terraform modules must define supported Terraform and provider versions.

Modules use semantic versioning:

```text
MAJOR.MINOR.PATCH
```

Breaking changes require a major version.

Terraform state must never be committed to Git.

```text
*.tfstate
*.tfstate.*
.terraform/
```

AWS environments should use secure remote state with access control, encryption and state locking.

---

## 12. Environment Separation

Reusable modules must remain environment-independent.

```text
infrastructure/
├── modules/
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Environment-specific configuration must be supplied by environment configurations rather than hard-coded in modules.

---

## 13. CI/CD and Validation

Terraform changes must be validated through the reusable platform workflow.

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

Local validation must not require live AWS infrastructure.

Production changes require appropriate approval.

---

## 14. Reusability

The same platform modules must support multiple applications.

Example consumers:

```text
        Reusable Modules
          /          \
     Orders API    Payments API
```

Applications may use different configuration values but must not duplicate the module implementation.

---

## 15. Acceptance Criteria / Definition of Done

The Terraform platform is complete when:

* [ ] Standard module structure is followed.
* [ ] Network, IAM, Container and Observability modules are available.
* [ ] Modules contain no application-specific logic.
* [ ] Security defaults are implemented.
* [ ] Checkov validation passes.
* [ ] Terraform format and validation pass.
* [ ] No secrets are stored in source.
* [ ] Terraform state is excluded from Git.
* [ ] CI/CD validation is working.
* [ ] Orders API consumes the modules.
* [ ] Payments API consumes the same modules.
* [ ] Modules are documented and version controlled.
* [ ] Reusable infrastructure is not duplicated between applications.
