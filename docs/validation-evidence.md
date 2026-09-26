Great. ✅ Your root README is now the main entry point for the capstone.

### Next: Create validation evidence documentation

This will make the project easier for the evaluator to verify without opening every GitHub Actions run.

Create:

```text
docs/validation-evidence.md
```

Paste:

````markdown
# Validation Evidence

## Purpose

This document records the automated validation performed against the platform implementation.

The goal is to demonstrate that the implementation satisfies the AI Engineering Specifications and that reusable platform components can be consumed consistently.

---

## 1. Platform CI

Workflow:

```text
.github/workflows/platform-ci.yml
````

Validation includes:

| Check                        | Result  |
| ---------------------------- | ------- |
| Reusable CI / Build and Test | PASS    |
| Gitleaks Secret Scan         | PASS    |
| Trivy Filesystem Scan        | PASS    |
| Trivy Container Image Scan   | SKIPPED |
| Reusable Terraform           | PASS    |

### Container Scan

The Trivy container-image scan is intentionally skipped when no container image is supplied to the workflow.

Filesystem security scanning remains enabled.

---

## 2. Terraform Module Validation

Workflow:

```text
.github/workflows/terraform-validate.yml
```

The following platform modules are validated:

* Network
* IAM
* Container
* Observability

Each module is checked using:

```text
terraform fmt
terraform init
terraform validate
Checkov
```

Expected result:

```text
Network          PASS
IAM              PASS
Container        PASS
Observability    PASS
```

---

## 3. Terraform Consumer Validation

Workflow:

```text
.github/workflows/terraform-consumer-validation.yml
```

Two independent application consumers use the same reusable platform modules.

### Orders API

```text
infrastructure/examples/orders-api/
```

Validation:

```text
Terraform Format       PASS
Terraform Init         PASS
Terraform Validate     PASS
Checkov                PASS
```

### Payments API

```text
infrastructure/examples/payments-api/
```

Validation:

```text
Terraform Format       PASS
Terraform Init         PASS
Terraform Validate     PASS
Checkov                PASS
```

### Reusability Evidence

Both applications consume:

* Network module
* IAM module
* Container module
* Observability module

This demonstrates that the platform infrastructure components are reusable rather than application-specific.

---

## 4. Repository Template Validation

Workflow:

```text
.github/workflows/template-validation.yml
```

Validation includes:

| Check                         | Result |
| ----------------------------- | ------ |
| Python Tests                  | PASS   |
| Docker Build                  | PASS   |
| Template Structure Validation | PASS   |

The structure validation verifies required platform-standard files including:

* Application directory
* Tests
* Infrastructure
* Documentation
* Architecture
* AI specifications
* Engineering decisions
* CODEOWNERS
* Pull request template
* Dockerfile
* `.dockerignore`
* `.gitignore`
* README
* SECURITY.md

---

## 5. Security Validation

Security controls implemented by the platform include:

### Gitleaks

Purpose:

```text
Detect accidentally committed secrets and credentials.
```

### Trivy

Purpose:

```text
Identify filesystem and container vulnerabilities.
```

### Checkov

Purpose:

```text
Identify insecure Terraform configurations.
```

### Terraform Secure Defaults

Platform modules implement controls including:

* Encryption
* KMS
* Restricted security groups
* Least-privilege IAM
* VPC Flow Logs
* Secure resource configuration
* No hard-coded credentials

---

## 6. Validation Strategy

The platform follows this validation model:

```text
AI Engineering Specification
            |
            v
     Implementation
            |
            v
      Automated Tests
            |
            v
   Security Validation
            |
            v
    Reusable Consumer
       Validation
            |
            v
       Documentation
```

AI-generated implementation is not treated as automatically correct.

Each implementation component is reviewed against the corresponding engineering specification and validated using automated checks.

---

## 7. Evidence Collection

For the final capstone submission, GitHub Actions run screenshots should be retained for:

1. Platform CI
2. Terraform Module Validation
3. Terraform Consumer Validation
4. Repository Template Validation

The screenshots should clearly show successful workflow execution and the relevant job names.

---

## 8. Acceptance Criteria

The implementation satisfies the following validation requirements:

* [x] Platform architecture documented
* [x] AI Engineering Specifications created
* [x] Reusable Terraform modules implemented
* [x] Terraform security validation implemented
* [x] Multiple Terraform consumers validated
* [x] Reusable GitHub Actions implemented
* [x] Repository template implemented
* [x] Repository template automatically validated
* [x] Security scanning integrated
* [x] Governance documentation created
* [x] Developer experience documentation created
* [x] ADRs created for major engineering decisions
* [x] Root project documentation created

---

## 9. Validation Status

The platform implementation has successfully passed the automated validation workflows available in the repository at the time of validation.

Actual deployment of AWS infrastructure is separate from static Terraform validation and requires an appropriately configured AWS environment and credentials.
