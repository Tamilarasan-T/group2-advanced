# IAM Terraform Module

## Overview

This module creates a reusable AWS IAM role for application workloads.

The module is designed around the **least-privilege principle** and allows each consuming application to provide only the permissions it requires.

It supports common AWS compute workloads:

* Amazon EC2
* Amazon ECS tasks
* Amazon EKS workloads

The module can optionally create an EC2 instance profile.

---

## Module Structure

```text
iam/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```

---

## Architecture

```text
Application
     |
     v
Reusable IAM Module
     |
     v
IAM Role
     |
     +----------------------+
     |                      |
     v                      v
Trust Policy          Application Policy
     |                      |
     v                      v
AWS Compute           Specific AWS Actions
Service               + Resources
```

---

## Usage

### ECS Example

```hcl
module "iam" {
  source = "../../modules/iam"

  name        = "ims"
  environment = "dev"

  trusted_service = "ecs-tasks.amazonaws.com"

  policy_statements = [
    {
      Sid    = "ReadApplicationBucket"
      Effect = "Allow"

      Action = [
        "s3:GetObject",
        "s3:ListBucket"
      ]

      Resource = [
        "arn:aws:s3:::acme-ims-dev",
        "arn:aws:s3:::acme-ims-dev/*"
      ]
    }
  ]

  tags = {
    Owner      = "Platform-Team"
    CostCenter = "Engineering"
  }
}
```

### EC2 Example

For EC2 workloads:

```hcl
module "iam" {
  source = "../../modules/iam"

  name        = "ims"
  environment = "dev"

  trusted_service        = "ec2.amazonaws.com"
  create_instance_profile = true

  policy_statements = [
    {
      Sid    = "ReadApplicationBucket"
      Effect = "Allow"

      Action = [
        "s3:GetObject"
      ]

      Resource = [
        "arn:aws:s3:::acme-ims-dev/*"
      ]
    }
  ]

  tags = {
    Owner      = "Platform-Team"
    CostCenter = "Engineering"
  }
}
```

---

## Least Privilege

The consuming application is responsible for providing the required policy statements.

Example:

```hcl
policy_statements = [
  {
    Sid    = "ReadApplicationBucket"
    Effect = "Allow"

    Action = [
      "s3:GetObject"
    ]

    Resource = [
      "arn:aws:s3:::acme-ims-dev/*"
    ]
  }
]
```

The module does **not** automatically grant broad permissions.

Avoid policies such as:

```hcl
Action   = "*"
Resource = "*"
```

unless there is a documented and approved platform requirement.

---

## Supported Trusted Services

The module currently supports:

```text
ec2.amazonaws.com
ecs-tasks.amazonaws.com
eks.amazonaws.com
```

The trusted service is provided through:

```hcl
trusted_service = "ecs-tasks.amazonaws.com"
```

The module validates the value to prevent unsupported service principals from being accidentally configured.

---

## Inputs

| Name                      | Type          | Required | Default | Description                                  |
| ------------------------- | ------------- | -------: | ------- | -------------------------------------------- |
| `name`                    | `string`      |      Yes | —       | Application or platform name                 |
| `environment`             | `string`      |      Yes | —       | `dev`, `test`, or `prod`                     |
| `trusted_service`         | `string`      |      Yes | —       | AWS service allowed to assume the role       |
| `policy_statements`       | `list(any)`   |       No | `[]`    | Application-specific IAM policy statements   |
| `max_session_duration`    | `number`      |       No | `3600`  | Maximum IAM role session duration in seconds |
| `create_instance_profile` | `bool`        |       No | `false` | Whether to create an EC2 instance profile    |
| `tags`                    | `map(string)` |       No | `{}`    | Additional resource tags                     |

---

## Outputs

| Name                    | Description                                  |
| ----------------------- | -------------------------------------------- |
| `role_id`               | ID of the application IAM role               |
| `role_name`             | Name of the application IAM role             |
| `role_arn`              | ARN of the application IAM role              |
| `instance_profile_id`   | ID of the EC2 instance profile, if created   |
| `instance_profile_name` | Name of the EC2 instance profile, if created |
| `instance_profile_arn`  | ARN of the EC2 instance profile, if created  |

---

## Security Standards

The module follows the platform security requirements.

### Least privilege

Permissions are explicitly supplied by the consuming application.

### No hardcoded credentials

The module does not contain:

* AWS access keys
* AWS secret keys
* Passwords
* API tokens
* Static credentials

### Restricted trust relationship

Only supported AWS compute service principals can be configured.

### Session duration

The default IAM session duration is:

```text
3600 seconds
```

The allowed range is:

```text
3600 - 43200 seconds
```

### Resource-level permissions

Applications should specify exact AWS resources wherever possible.

Preferred:

```hcl
Resource = [
  "arn:aws:s3:::acme-ims-dev/*"
]
```

Avoid:

```hcl
Resource = ["*"]
```

unless technically required and approved.

---

## Tagging

Standard platform tags are applied:

```text
Application
Environment
ManagedBy
```

Additional tags can be supplied:

```hcl
tags = {
  Owner      = "Platform-Team"
  CostCenter = "Engineering"
}
```

---

## Environment Support

The module supports:

```text
dev
test
prod
```

Example environment structure:

```text
infrastructure/
├── modules/
│   └── iam/
│
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

Environment-specific IAM permissions should be configured in the consuming environment rather than hard-coded into the shared module.

---

## Validation

Run Terraform formatting:

```bash
terraform fmt -check -recursive
```

Initialize without a backend:

```bash
terraform init -backend=false
```

Validate the configuration:

```bash
terraform validate
```

Run Checkov:

```bash
checkov -d infrastructure/modules/iam --framework terraform
```

---

## CI/CD Validation

The platform CI/CD workflow should validate:

```text
Terraform Format
       |
       v
Terraform Init
       |
       v
Terraform Validate
       |
       v
Checkov Security Scan
```

IAM changes should not be merged if mandatory security checks fail.

---

## Reusability

The same IAM module can be consumed by multiple applications.

```text
Application A
      |
      +----> IAM Module
      |
      v
   IAM Role


Application B
      |
      +----> IAM Module
      |
      v
   IAM Role
```

Each application can provide different least-privilege policy statements while using the same standardized module implementation.

---

## Design Principles

The module follows these principles:

1. Least privilege
2. Reusable
3. Application-independent
4. Secure by default
5. No hardcoded credentials
6. Explicit trust relationships
7. Resource-level permissions
8. Standardized naming
9. Standardized tagging
10. Automated security validation
11. Environment-aware
12. Version controlled

---

## Limitations

This module intentionally does not manage:

* AWS IAM users
* AWS IAM groups
* IAM access keys
* AWS SSO / IAM Identity Center
* AWS Organizations SCPs
* Complex cross-account trust relationships
* AWS managed policies

These can be implemented through dedicated platform modules when required.

---

## Definition of Done

The IAM module is complete when:

* [ ] IAM role is created.
* [ ] Trust policy is restricted to supported services.
* [ ] Application permissions are configurable.
* [ ] Least-privilege design is documented.
* [ ] Optional EC2 instance profile is supported.
* [ ] Session duration is validated.
* [ ] Standard tags are applied.
* [ ] No credentials are stored.
* [ ] Terraform formatting passes.
* [ ] Terraform validation passes.
* [ ] Checkov validation passes.
* [ ] Documentation is complete.
* [ ] The module can be reused by multiple applications.
