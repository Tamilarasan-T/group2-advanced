# Network Terraform Module

Reusable Terraform module for creating a secure AWS network foundation.

## Purpose

This module provides a standardized VPC networking capability that can be reused by multiple application teams.

The module creates:

- Amazon VPC
- Internet Gateway
- Public subnets
- Private subnets
- Public route table
- Private route table
- Route table associations
- Restricted default security group
- VPC Flow Logs
- Encrypted CloudWatch Log Group
- KMS key for log encryption
- IAM role and policy for VPC Flow Logs

---

## Architecture

```text
                    Internet
                       |
                       v
              Internet Gateway
                       |
                       v
                +-------------+
                |     VPC     |
                |             |
                | Public      |
                | Subnets     |
                |             |
                | Private     |
                | Subnets     |
                |             |
                | Flow Logs   |
                +-------------+
                       |
                       v
              CloudWatch Logs
                       |
                       v
                    AWS KMS
````

---

## Usage

Example:

```hcl
module "network" {
  source = "../../modules/network"

  name        = "orders-api"
  environment = "dev"

  vpc_cidr = "10.20.0.0/16"

  availability_zones = [
    "us-east-1a",
    "us-east-1b"
  ]

  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.20.11.0/24",
    "10.20.12.0/24"
  ]

  flow_log_retention_days = 365

  tags = {
    Owner     = "Platform"
    CostCenter = "Engineering"
  }
}
```

---

## Inputs

| Name                      | Type           | Default | Description                                   |
| ------------------------- | -------------- | ------- | --------------------------------------------- |
| `name`                    | `string`       | —       | Application or platform name                  |
| `environment`             | `string`       | —       | Environment name such as dev, test, or prod   |
| `vpc_cidr`                | `string`       | —       | CIDR block for the VPC                        |
| `availability_zones`      | `list(string)` | —       | Availability Zones used by the VPC            |
| `public_subnet_cidrs`     | `list(string)` | —       | CIDR blocks for public subnets                |
| `private_subnet_cidrs`    | `list(string)` | —       | CIDR blocks for private subnets               |
| `flow_log_retention_days` | `number`       | `365`   | CloudWatch retention period for VPC Flow Logs |
| `tags`                    | `map(string)`  | `{}`    | Additional resource tags                      |

---

## VPC Flow Logs

The module enables VPC Flow Logs and sends them to an encrypted CloudWatch Log Group.

The default retention period is:

**365 days**

The retention period can be customized using:

```text
flow_log_retention_days
```

The configured value must be at least **365 days**.

VPC Flow Logs provide network traffic visibility that can support:

* Security investigation
* Network troubleshooting
* Operational monitoring
* Compliance requirements

---

## Security

The module follows security-by-default principles.

### Default Security Group

The default VPC security group is restricted and does not provide unrestricted inbound or outbound access.

### Encryption

VPC Flow Logs are stored in an encrypted CloudWatch Log Group using AWS KMS.

The KMS key has automatic key rotation enabled.

### VPC Flow Logs

VPC Flow Logs are enabled for network visibility.

### Availability Zones

The module requires at least two unique Availability Zones to support a highly available network design.

### No Hard-Coded Credentials

The module does not contain:

* AWS access keys
* AWS secret keys
* Passwords
* Tokens
* Other credentials

---

## Tags

The module applies standard tags including:

```text
Application
Environment
ManagedBy
```

Additional tags can be supplied through the `tags` variable.

Example:

```hcl
tags = {
  Owner      = "Platform"
  CostCenter = "Engineering"
}
```

---

## Outputs

The module provides outputs including:

* VPC ID
* VPC CIDR
* Public subnet IDs
* Private subnet IDs
* Public route table ID
* Private route table ID
* VPC Flow Log ID
* Flow Log CloudWatch Log Group
* Flow Log KMS key ARN

These outputs allow application teams to consume the network without accessing the internal implementation details of the module.

---

## Validation

The module is validated using:

```text
terraform fmt
terraform init -backend=false
terraform validate
Checkov
```

The platform validation workflow is:

```text
.github/workflows/terraform-validate.yml
```

The module also has validation guidance under:

tests/README.md
```

---

## Reusability

The module is designed to support multiple application teams.

Example consumers include:


infrastructure/examples/orders-api
infrastructure/examples/payments-api


Each application can provide different:

* Application name
* Environment
* VPC CIDR
* Subnet CIDRs
* Availability Zones
* Tags
* Flow log retention configuration

The network implementation remains centralized and reusable.

---

## Requirements

| Requirement  | Version       |
| ------------ | ------------- |
| Terraform    | >= 1.6        |
| AWS Provider | >= 5.0, < 7.0 |

---

## Module Design Principles

This module follows these principles:

* Reusable
* Secure by default
* Least privilege
* No hard-coded credentials
* No application-specific business logic
* Standard tagging
* Encryption by default
* Infrastructure as Code
* Automated validation
* Version-controlled implementation

---

## Definition of Done

The Network module is considered complete when:

* [x] VPC is created.
* [x] Public and private subnets are supported.
* [x] Multiple Availability Zones are supported.
* [x] Route tables are configured.
* [x] Default security group is restricted.
* [x] VPC Flow Logs are enabled.
* [x] Flow Logs are encrypted.
* [x] CloudWatch retention is configurable.
* [x] KMS key rotation is enabled.
* [x] Terraform validation passes.
* [x] Checkov validation passes.
* [x] Consumer examples can reuse the module.
