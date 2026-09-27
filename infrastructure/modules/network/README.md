# Network Terraform Module

Reusable AWS networking module providing a secure VPC foundation for application teams.

## Creates

- VPC
- Public and private subnets
- Internet Gateway
- Route tables and associations
- Restricted default security group
- VPC Flow Logs
- Encrypted CloudWatch Log Group
- KMS key for log encryption

## Usage

```hcl
module "network" {
  source      = "../../modules/network"
  name        = "orders-api"
  environment = "dev"

  vpc_cidr = "10.20.0.0/16"

  availability_zones = ["us-east-1a", "us-east-1b"]

  public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
  private_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]

  tags = {
    Owner      = "Platform"
    CostCenter = "Engineering"
  }
}
````

## Security

* Secure default security group
* Encrypted Flow Logs
* KMS key rotation
* No hard-coded credentials
* Minimum two Availability Zones

## Validation

```text
terraform fmt
terraform init -backend=false
terraform validate
Checkov
```

Workflow:

`.github/workflows/terraform-validate.yml`

## Consumers

```text
infrastructure/examples/
├── orders-api/
└── payments-api/
```

The same module supports multiple applications and environments.

## Requirements

| Tool         | Version       |
| ------------ | ------------- |
| Terraform    | >= 1.6        |
| AWS Provider | >= 5.0, < 7.0 |
