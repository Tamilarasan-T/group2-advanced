# Container Terraform Module

Reusable AWS ECR module for application teams and environments.

## Capabilities

- ECR repository
- Immutable image tags
- Image scanning on push
- KMS encryption and rotation
- Lifecycle management
- Secure defaults
- Standard tagging

## Usage

```hcl
module "container" {
  source      = "../../modules/container"
  name        = "orders-api"
  environment = "dev"

  tags = {
    Owner      = "Platform"
    CostCenter = "Engineering"
  }
}
````

## Security

* KMS encryption with key rotation
* Image scanning
* Immutable tags
* No public repository configuration
* No credentials in Terraform
* Protected repository deletion
* Standard resource tags

## Lifecycle

* Untagged images removed after 7 days.
* Latest 30 version-tagged images retained.

## Validation

```text
terraform fmt
terraform init -backend=false
terraform validate
Checkov
```

## Reusability

The same module can create isolated ECR repositories for multiple applications such as:

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
