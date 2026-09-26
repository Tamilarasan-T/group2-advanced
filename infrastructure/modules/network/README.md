# Network Terraform Module

## Overview

This module creates a reusable AWS network foundation for application teams.

It provides:

* VPC
* Internet Gateway
* Public subnets
* Private subnets
* Public route table
* Private route tables
* Multi-AZ subnet placement
* Default security group restriction
* VPC Flow Logs
* CloudWatch Log Group for VPC Flow Logs
* Standard resource tagging

The module is designed to be reused across multiple applications and environments.

---

## Architecture

```text
                    AWS Region
                        |
              +---------+---------+
              |                   |
            AZ-1                AZ-2
              |                   |
       +------+-----+       +-----+------+
       |            |       |            |
    Public       Private  Public       Private
    Subnet       Subnet   Subnet       Subnet
       |            |       |            |
       +------------+-------+------------+
                        |
                       VPC
                        |
                 Internet Gateway

                        |
                        v
                 VPC Flow Logs
                        |
                        v
               CloudWatch Log Group
```

---

## Module Structure

```text
network/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```

---

## Usage

Example:

```hcl
module "network" {
  source = "../../modules/network"

  name        = "ims"
  environment = "dev"

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  flow_log_retention_days = 30

  tags = {
    Owner      = "Platform-Team"
    CostCenter = "Engineering"
  }
}
```

> The Availability Zones shown above are examples for the AWS Mumbai region (`ap-south-1`). The consuming environment should provide Availability Zones appropriate for its AWS region.

---

## Inputs

| Name                      | Type           | Required | Default | Description                                               |
| ------------------------- | -------------- | -------: | ------- | --------------------------------------------------------- |
| `name`                    | `string`       |      Yes | —       | Application or platform name                              |
| `environment`             | `string`       |      Yes | —       | Deployment environment: `dev`, `test`, or `prod`          |
| `vpc_cidr`                | `string`       |      Yes | —       | CIDR block for the VPC                                    |
| `availability_zones`      | `list(string)` |      Yes | —       | Explicit AWS Availability Zones used for subnet placement |
| `public_subnet_cidrs`     | `list(string)` |      Yes | —       | CIDR blocks for public subnets                            |
| `private_subnet_cidrs`    | `list(string)` |      Yes | —       | CIDR blocks for private subnets                           |
| `flow_log_retention_days` | `number`       |       No | `30`    | Number of days to retain VPC Flow Logs                    |
| `tags`                    | `map(string)`  |       No | `{}`    | Additional resource tags                                  |

---

## Outputs

| Name                      | Description                                   |
| ------------------------- | --------------------------------------------- |
| `vpc_id`                  | ID of the created VPC                         |
| `vpc_cidr`                | CIDR block of the VPC                         |
| `internet_gateway_id`     | ID of the Internet Gateway                    |
| `public_subnet_ids`       | IDs of the public subnets                     |
| `private_subnet_ids`      | IDs of the private subnets                    |
| `public_route_table_id`   | ID of the public route table                  |
| `private_route_table_ids` | IDs of the private route tables               |
| `availability_zones`      | Availability Zones configured for the network |
| `flow_log_group_name`     | CloudWatch Log Group receiving VPC Flow Logs  |

---

## Network Design

The module creates:

### VPC

A configurable VPC CIDR is provided through:

```hcl
vpc_cidr = "10.0.0.0/16"
```

DNS support and DNS hostnames are enabled.

### Public Subnets

Public subnets are created across the explicitly provided Availability Zones.

Example:

```text
10.0.1.0/24
10.0.2.0/24
```

The public route table provides Internet Gateway routing.

### Private Subnets

Private subnets are created across multiple Availability Zones.

Example:

```text
10.0.11.0/24
10.0.12.0/24
```

Private subnets do not receive public IP addresses automatically.

---

## Availability Zone Strategy

Availability Zones are provided explicitly by the consuming environment.

Example:

```hcl
availability_zones = [
  "ap-south-1a",
  "ap-south-1b"
]
```

This prevents the module from dynamically expanding its Availability Zone selection when AWS adds new Availability Zones.

The number of Availability Zones must be sufficient for the configured public and private subnet CIDRs.

---

## Security Standards

This module follows the platform security requirements defined in the AI Engineering Specifications.

### Default Security Group

The VPC default security group is explicitly restricted.

It does not allow unrestricted:

```text
Ingress
Egress
```

Application-specific security groups should be created separately according to application requirements.

### VPC Flow Logs

VPC Flow Logs are enabled for:

```text
ALL traffic
```

Logs are delivered to a dedicated CloudWatch Log Group.

Default retention:

```text
30 days
```

The retention period can be customized:

```hcl
flow_log_retention_days = 30
```

### Credentials

The module does not contain:

* AWS access keys
* AWS secret keys
* Passwords
* API tokens
* Hardcoded credentials

AWS authentication must be provided by the deployment environment.

---

## CloudWatch Logging

VPC Flow Logs are sent to a dedicated CloudWatch Log Group.

Example:

```text
/aws/vpc/flow-logs/ims-dev
```

The log group retention is configurable through:

```hcl
flow_log_retention_days = 30
```

This provides network-level visibility for troubleshooting and security investigations.

---

## Resource Tagging

The module applies standard platform tags:

```text
Application
Environment
ManagedBy
```

Additional tags can be supplied by the consuming application.

Example:

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

Environment-specific configuration should be maintained outside the reusable module.

Recommended structure:

```text
infrastructure/
├── modules/
│   └── network/
│
└── environments/
    ├── dev/
    ├── test/
    └── prod/
```

The reusable module should contain infrastructure logic, while environment directories provide environment-specific inputs.

---

## Validation

Run Terraform formatting validation:

```bash
terraform fmt -check -recursive
```

Initialize Terraform without configuring a backend:

```bash
terraform init -backend=false
```

Validate the Terraform configuration:

```bash
terraform validate
```

Run security validation:

```bash
checkov -d infrastructure/modules/network --framework terraform
```

---

## CI/CD Validation

The module is validated automatically through GitHub Actions.

The validation workflow performs:

```text
Terraform Format Check
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

The workflow is located at:

```text
.github/workflows/terraform-validate.yml
```

---

## Reusability

The module is intentionally application-independent.

Multiple applications can consume the same module:

```text
Application A
      |
      +----> Network Module
      |
      v
   AWS VPC


Application B
      |
      +----> Network Module
      |
      v
   AWS VPC
```

This eliminates duplicated VPC and subnet Terraform configurations.

---

## Example Multi-Environment Usage

### Development

```hcl
module "network" {
  source = "../../modules/network"

  name        = "ims"
  environment = "dev"

  vpc_cidr = "10.0.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]
}
```

### Production

A production environment can consume the same module with different inputs:

```hcl
module "network" {
  source = "../../modules/network"

  name        = "ims"
  environment = "prod"

  vpc_cidr = "10.10.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b",
    "ap-south-1c"
  ]

  public_subnet_cidrs = [
    "10.10.1.0/24",
    "10.10.2.0/24",
    "10.10.3.0/24"
  ]

  private_subnet_cidrs = [
    "10.10.11.0/24",
    "10.10.12.0/24",
    "10.10.13.0/24"
  ]

  flow_log_retention_days = 90
}
```

The same reusable module can therefore support different environments without duplicating the underlying infrastructure implementation.

---

## Design Principles

The module follows these principles:

1. Reusable
2. Environment-aware
3. Multi-AZ capable
4. Secure by default
5. Application-independent
6. Explicit Availability Zone selection
7. Standardized tagging
8. Network observability
9. Infrastructure as Code
10. Automated security validation
11. Version controlled
12. Minimal application-specific logic

---

## Limitations

This module intentionally does not create:

* NAT Gateways
* Application-specific Security Groups
* Network ACL customization
* VPC Endpoints
* VPN connections
* Transit Gateway attachments
* Load Balancers

These capabilities can be introduced through dedicated reusable modules when required.

---

## Security Validation

The module is expected to pass the platform security checks, including:

```text
CKV_AWS_394
CKV2_AWS_12
CKV2_AWS_11
```

These checks ensure:

* Availability Zones are explicitly defined.
* The default VPC security group is restricted.
* VPC Flow Logs are enabled.

Additional Checkov policies may be introduced as platform security requirements evolve.

---

## Definition of Done

The Network module is complete when:

* [ ] VPC is created.
* [ ] Internet Gateway is created.
* [ ] Public subnets are created across Availability Zones.
* [ ] Private subnets are created across Availability Zones.
* [ ] Public route table is configured.
* [ ] Private route tables are configured.
* [ ] Default security group is restricted.
* [ ] VPC Flow Logs are enabled.
* [ ] CloudWatch Log Group is configured.
* [ ] Outputs are available to consuming applications.
* [ ] Variables contain validation rules.
* [ ] No credentials are stored.
* [ ] Terraform formatting passes.
* [ ] Terraform initialization passes.
* [ ] Terraform validation passes.
* [ ] Checkov validation passes.
* [ ] Documentation is complete.
* [ ] The module can be reused by multiple applications.
