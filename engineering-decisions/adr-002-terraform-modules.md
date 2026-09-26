# ADR-002: Reusable Terraform Modules

## Context

Acme Retail Ltd. has multiple application teams that require common AWS infrastructure such as networking, IAM, container registries, and observability resources.

Creating Terraform configurations independently for every application would result in duplicated code, inconsistent security controls, and increased maintenance effort.

The platform requires reusable infrastructure components with secure defaults and consistent interfaces.

## Problem

We need a standard approach for provisioning common AWS infrastructure that:

- Reduces Terraform duplication
- Provides secure defaults
- Supports multiple application teams
- Encourages consistent tagging
- Enables independent module versioning
- Supports automated validation and security scanning
- Prevents application-specific logic from being embedded in shared modules

## Decision

We will create reusable Terraform modules for common AWS platform capabilities.

The initial modules are:

- Network
- IAM
- Container
- Observability

Each module will follow a consistent structure:

```text
module/
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
````

Modules will follow these standards:

* Terraform >= 1.6
* AWS provider version constraints
* Secure-by-default configuration
* Input validation
* Consistent resource tagging
* No hard-coded credentials
* No application-specific business logic
* Clear inputs and outputs
* Terraform formatting and validation
* Checkov security scanning

Terraform state files and sensitive state data will not be committed to Git.

## Alternatives

### Alternative 1: Application-specific Terraform

Each application maintains its own Terraform resources without shared modules.

### Alternative 2: One large Terraform module

All platform infrastructure is combined into a single module.

### Alternative 3: Small reusable Terraform modules

Common infrastructure capabilities are separated into focused modules that application teams can consume independently.

## Trade-offs

### Benefits

* Reduces duplicated infrastructure code
* Provides consistent infrastructure patterns
* Makes security controls reusable
* Simplifies maintenance
* Allows modules to evolve independently
* Enables reuse across multiple applications

### Costs

* Modules require version management
* Changes to shared modules may affect multiple consumers
* Module interfaces need backward compatibility
* Additional documentation is required

## Consequences

Application teams can consume standard platform modules instead of implementing common infrastructure from scratch.

For example:

```hcl
module "network" {
  source = "../../modules/network"

  name               = "orders"
  environment        = "dev"
  vpc_cidr           = "10.20.0.0/16"
  availability_zones = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.20.11.0/24",
    "10.20.12.0/24"
  ]
}
```

Shared modules will be validated through CI using:

* `terraform fmt`
* `terraform init`
* `terraform validate`
* Checkov

The modules will also be tested for consumption by multiple application examples.

## Rationale

Focused reusable modules provide a balance between standardization and flexibility.

They allow the platform team to maintain common infrastructure and security patterns while application teams control application-specific configuration.

This approach supports the platform's goals of reusability, security, automation, and developer self-service.

## Status

Accepted
