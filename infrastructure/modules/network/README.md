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

  public_subnet_cidrs = [
    "10.0.1.0/24",
    "10.0.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.0.11.0/24",
    "10.0.12.0/24"
  ]

  tags = {
    Owner     = "Platform-Team"
    CostCenter = "Engineering"
  }
}
```

---

## Inputs

| Name                   | Type           | Required | Description                  |
| ---------------------- | -------------- | -------: | ---------------------------- |
| `name`                 | `string`       |      Yes | Application or platform name |
| `environment`          | `string`       |      Yes | `dev`, `test`, or `prod`     |
| `vpc_cidr`             | `string`       |      Yes | VPC CIDR block               |
| `public_subnet_cidrs`  | `list(string)` |      Yes | Public subnet CIDRs          |
| `private_subnet_cidrs` | `list(string)` |      Yes | Private subnet CIDRs         |
| `tags`                 | `map(string)`  |       No | Additional resource tags     |

---

## Outputs

| Name                      | Description             |
| ------------------------- | ----------------------- |
| `vpc_id`                  | VPC ID                  |
| `vpc_cidr`                | VPC CIDR                |
| `internet_gateway_id`     | Internet Gateway ID     |
| `public_subnet_ids`       | Public subnet IDs       |
| `private_subnet_ids`      | Private subnet IDs      |
| `public_route_table_id`   | Public route table ID   |
| `private_route_table_ids` | Private route table IDs |
| `availability_zones`      | Availability zones used |

---

## Security Standards

This module follows the platform security requirements.

### Network security

* Private subnets do not receive public IP addresses automatically.
* Administrative ports are not exposed by this module.
* Security groups are intentionally managed separately by consuming applications or dedicated modules.
* Network resources are deployed across multiple Availability Zones.

### Credentials

The module does not contain:

* AWS access keys
* AWS secret keys
* Passwords
* Tokens
* Hardcoded credentials

AWS authentication must be provided through the deployment environment.

---

## Environment Support

The module supports:

```text
dev
test
prod
```

Environment-specific configuration should be maintained outside the reusable module.

Example:

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

---

## Validation

Run the following commands from the module or consuming Terraform configuration:

```bash
terraform fmt -check -recursive
terraform init
terraform validate
```

Security validation:

```bash
checkov -d .
```

---

## Reusability

The module is intentionally application-independent.

The same module can be consumed by multiple applications:

```text
Application A
     |
     +----> Network Module v1

Application B
     |
     +----> Network Module v1

Application C
     |
     +----> Network Module v1
```

This avoids duplicating VPC and subnet Terraform configurations across application repositories.

---

## Design Principles

The module follows these principles:

1. Reusable
2. Environment-aware
3. Multi-AZ by default
4. Secure by default
5. Application-independent
6. Minimal required inputs
7. Standardized tagging
8. Version controlled
9. Infrastructure as Code
10. Compatible with automated validation

---

## Limitations

This module intentionally does not create:

* NAT Gateways
* Security Groups
* Network ACL customization
* VPC endpoints
* VPN connections
* Transit Gateway attachments

These capabilities can be introduced through dedicated modules when required.

---

## Definition of Done

The network module is complete when:

* [ ] VPC is created.
* [ ] Internet Gateway is created.
* [ ] Public subnets are created across multiple AZs.
* [ ] Private subnets are created across multiple AZs.
* [ ] Route tables are configured.
* [ ] Outputs are available to consuming modules.
* [ ] Variables contain validation rules.
* [ ] No credentials are stored.
* [ ] Terraform validation passes.
* [ ] Checkov validation passes.
* [ ] Documentation is complete.
* [ ] The module can be reused by multiple applications.
