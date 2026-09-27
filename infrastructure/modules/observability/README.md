# Observability Terraform Module

Reusable AWS CloudWatch logging module for application teams and environments.

## Capabilities

- CloudWatch Log Group
- KMS encryption and key rotation
- Configurable log retention
- Secure defaults
- Standard resource tagging

## Usage

```hcl
module "observability" {
  source = "../../modules/observability"

  name              = "orders-api"
  environment       = "dev"
  log_group_name    = "/applications/orders-api/dev"
  retention_in_days = 365

  tags = {
    Owner      = "Platform"
    CostCenter = "Engineering"
  }
}
````

## Security

* Logs encrypted with AWS KMS.
* KMS key rotation enabled.
* Configurable log retention.
* Restricted CloudWatch Logs access.
* No credentials or secrets in Terraform.

## Validation

```text
terraform fmt
terraform init -backend=false
terraform validate
Checkov
```

## Reusability

The same module can provide isolated CloudWatch Log Groups for multiple applications such as:

```text
orders-api
payments-api
customer-api
```

## Requirements

| Tool         | Version       |
| ------------ | ------------- |
| Terraform    | >= 1.6        |
| AWS Provider | >= 5.0, < 7.0 |
