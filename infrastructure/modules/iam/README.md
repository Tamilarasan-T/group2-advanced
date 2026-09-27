# IAM Terraform Module

Reusable AWS IAM role module for application workloads following least-privilege principles.

## Supports

- EC2
- ECS tasks
- EKS workloads
- Optional EC2 instance profile

## Usage

```hcl
module "iam" {
  source = "../../modules/iam"

  name             = "orders-api"
  environment      = "dev"
  trusted_service  = "ecs-tasks.amazonaws.com"

  policy_statements = [
    {
      Sid      = "ReadApplicationBucket"
      Effect   = "Allow"
      Action   = ["s3:GetObject"]
      Resource = ["arn:aws:s3:::acme-orders-dev/*"]
    }
  ]

  tags = {
    Owner      = "Platform"
    CostCenter = "Engineering"
  }
}
````

## Security

* Least-privilege permissions
* Restricted trust relationships
* Resource-level permissions
* No hard-coded credentials
* Configurable session duration
* Standard tagging

Avoid unrestricted:

```hcl
Action   = "*"
Resource = "*"
```

unless explicitly required and approved.

## Validation

```text
terraform fmt
terraform init -backend=false
terraform validate
Checkov
```

## Reusability

The same module can be consumed by multiple applications with application-specific IAM policies.

## Requirements

| Tool         | Version       |
| ------------ | ------------- |
| Terraform    | >= 1.6        |
| AWS Provider | >= 5.0, < 7.0 |
