# Self-Service Platform Guide

## Purpose

This document defines the self-service capabilities provided by the Acme Retail Internal Developer Platform.

The objective is to allow application teams to consume standardized platform capabilities without requiring Platform Engineering to manually implement common infrastructure and CI/CD solutions for every application.

## Self-Service Model

The platform follows this model:

```text
Application Team
       |
       v
Standard Repository Template
       |
       +----> Reusable CI
       |
       +----> Reusable Security
       |
       +----> Reusable Terraform
       |
       +----> Terraform Modules
       |
       +----> Standard Governance
       |
       v
Application Delivery


## Available Platform Capabilities

Application teams can consume the following standardized capabilities.

### Repository Template

The repository template provides:

* Standard directory structure
* Application skeleton
* Automated tests
* Dockerfile
* CODEOWNERS
* Documentation structure
* Architecture documentation structure
* AI specification structure
* Engineering decision structure

### Terraform Modules

The platform provides reusable Terraform modules:


network
iam
container
observability


These modules provide common infrastructure capabilities without requiring each application team to implement them independently.

## Network Module

The Network module provides reusable VPC capabilities.

Typical capabilities include:

* VPC
* Public subnets
* Private subnets
* Internet Gateway
* Route tables
* Default security group restrictions
* VPC Flow Logs
* KMS encryption for flow logs
* Standard resource tagging

Example:

module "network" {
  source = "../../modules/network"

  name        = "orders-api"
  environment = "dev"

  vpc_cidr = "10.20.0.0/16"

  availability_zones = [
    "ap-south-1a",
    "ap-south-1b"
  ]

  public_subnet_cidrs = [
    "10.20.1.0/24",
    "10.20.2.0/24"
  ]

  private_subnet_cidrs = [
    "10.20.11.0/24",
    "10.20.12.0/24"
  ]
}


## IAM Module

The IAM module provides reusable application IAM capabilities.

It supports:

* Application IAM roles
* Approved AWS service principals
* Optional instance profiles
* Configurable policy statements
* Standard tags
* Controlled session duration

Application teams should provide only the permissions required by their workload.

## Container Module

The Container module provides:

* Amazon ECR repository
* Immutable image tags
* Image scanning on push
* KMS encryption
* KMS key rotation
* Image lifecycle management
* Standard tags

Example:

module "container" {
  source = "../../modules/container"

  name        = "orders-api"
  environment = "dev"
}


## Observability Module

The Observability module provides:

* CloudWatch Log Group
* KMS encryption
* KMS key rotation
* Configurable log retention
* Standard tags

Example:

module "observability" {
  source = "../../modules/observability"

  name               = "orders-api"
  environment        = "dev"
  log_group_name     = "/applications/orders-api/dev"
  retention_in_days  = 365
}


## Reusable Workflows

Application teams should consume reusable GitHub Actions workflows instead of duplicating common pipeline logic.

Available workflows include:


reusable-ci.yml
reusable-security.yml
reusable-terraform.yml

### Reusable CI

Provides standardized:

* Repository checkout
* Runtime setup
* Dependency installation
* Application testing

### Reusable Security

Provides:

* Gitleaks
* Trivy filesystem scanning
* Optional Trivy container image scanning

### Reusable Terraform

Provides:

* Terraform formatting
* Terraform initialization
* Terraform validation
* Checkov security scanning

## Standard Consumption Pattern

A typical application workflow can consume the platform capabilities:


jobs:
  ci:
    uses: ./.github/workflows/reusable-ci.yml

  security:
    uses: ./.github/workflows/reusable-security.yml

  terraform:
    uses: ./.github/workflows/reusable-terraform.yml
    with:
      working-directory: infrastructure


For cross-repository consumption, the reusable workflow should be referenced from the approved platform repository and versioned reference.

## Self-Service Lifecycle

The recommended self-service lifecycle is:


Select Template
      |
      v
Create Repository
      |
      v
Configure Application
      |
      v
Select Terraform Modules
      |
      v
Configure Reusable Workflows
      |
      v
Run Validation
      |
      v
Create Pull Request
      |
      v
Review and Approval
      |
      v
Deploy
      |
      v
Monitor


## Versioning

Platform capabilities should be versioned to prevent unexpected changes from affecting application teams.

Teams should consume approved versions of:

* Terraform modules
* Reusable workflows
* Repository templates

Breaking changes should be communicated before adoption.

## Platform Ownership

Platform Engineering owns:

* Terraform modules
* Reusable workflows
* Repository templates
* Platform standards
* Security defaults
* Developer experience documentation

Application teams own:

* Application source code
* Application-specific configuration
* Application-specific tests
* Application-specific infrastructure configuration
* Application operational requirements

## Guardrails

Self-service does not remove governance requirements.

Platform guardrails should enforce:

* Required security scanning
* Required CI validation
* Terraform security validation
* Branch protection
* Pull Request review
* CODEOWNERS
* Secret protection
* Production approval

## Exceptions

If an application cannot use a standard platform capability, the team must follow the documented exception process.

Exceptions should include:

* Reason
* Risk
* Compensating controls
* Owner
* Expiration date
* Remediation plan

## Benefits

The self-service model is intended to provide:

* Faster application onboarding
* Reduced platform engineering effort
* Consistent infrastructure
* Consistent security controls
* Reduced pipeline duplication
* Standard developer experience
* Improved maintainability
* Better governance
* Faster delivery

## Definition of Done

The self-service capability is considered complete when application teams can:

* Start from the standard repository template.
* Consume approved Terraform modules.
* Consume reusable CI workflows.
* Consume reusable security workflows.
* Consume reusable Terraform validation.
* Pass automated security and quality gates.
* Follow standard governance.
* Deploy through the approved delivery process.
* Access documented operational guidance.


