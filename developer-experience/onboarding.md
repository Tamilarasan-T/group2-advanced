# Developer Onboarding Guide

## Purpose

This guide defines the standard onboarding process for application teams using the Acme Retail Internal Developer Platform.

The objective is to reduce onboarding time by providing a consistent repository structure, reusable platform capabilities, automated security controls, and documented engineering standards.

## Prerequisites

Before onboarding, the application team should have:

- GitHub organization access
- Access to the required cloud environment
- Application owner identified
- Technical owner identified
- Required environment information
- Application dependencies identified
- Deployment requirements identified
- Required security and compliance requirements identified

## Standard Onboarding Flow

The recommended onboarding process is:

Application Requirements
        ↓
Repository Creation
        ↓
Repository Template
        ↓
Application Configuration
        ↓
Reusable CI/CD Workflows
        ↓
Infrastructure Modules
        ↓
Security Validation
        ↓
Environment Deployment
        ↓
Monitoring and Operations


## Step 1 — Define Application Requirements

The application team should document:

* Application name
* Business purpose
* Application owner
* Technical owner
* Runtime
* Dependencies
* Required environments
* Required infrastructure
* Data requirements
* Security requirements
* Monitoring requirements

## Step 2 — Create the Repository

Create the application repository using the approved repository template.

The standard repository structure should include:

app/
tests/
infrastructure/
docs/
architecture/
ai-specifications/
engineering-decisions/
.github/
Dockerfile
.gitignore
.dockerignore
README.md


## Step 3 — Configure Application Code

Place application source code under:

app/


Application tests should be stored under:


tests/


The application should include appropriate unit and integration tests based on its requirements.

## Step 4 — Configure Dependencies

Application dependencies must be explicitly defined.

For Python applications:


app/requirements.txt


Dependencies should:

* Use approved package sources.
* Use controlled versions.
* Be regularly reviewed.
* Pass vulnerability scanning.

## Step 5 — Configure CI

Application repositories should consume the platform reusable CI workflow.

The reusable workflow provides standardized:

* Source checkout
* Runtime setup
* Dependency installation
* Testing
* CI execution

Application teams should avoid duplicating common CI implementation.

## Step 6 — Configure Security

The platform provides reusable security workflows.

Applicable controls include:

* Gitleaks
* Trivy filesystem scanning
* Trivy container scanning
* Checkov for Terraform

Security checks should run automatically during Pull Requests and protected branch changes according to repository governance.

## Step 7 — Configure Infrastructure

Application teams should consume approved Terraform modules where applicable.

Available platform modules include:


network
iam
container
observability


Teams should avoid recreating common platform infrastructure when an approved reusable module already exists.

## Step 8 — Configure Environments

The standard environment model is:

dev
 ↓
test
 ↓
prod


Environment-specific configuration should be separated from reusable infrastructure logic.

Production changes must follow the required approval process.

## Step 9 — Configure Containerization

Applications requiring container deployment should use the standard Docker build process.

The repository should provide:


Dockerfile
.dockerignore


Container images should:

* Use approved base images.
* Avoid embedded credentials.
* Run as a non-root user where practical.
* Be scanned for vulnerabilities.
* Use immutable tags where supported.

## Step 10 — Configure Observability

Applications should define their logging and monitoring requirements.

Where applicable, teams should consume the platform observability module.

Monitoring should cover:

* Application health
* Availability
* Errors
* Performance
* Resource utilization
* Security-relevant events

## Step 11 — Documentation

Every application repository should document:

* Application purpose
* Architecture
* Deployment process
* Configuration
* Dependencies
* Monitoring
* Troubleshooting
* Ownership
* Support information

Architecture decisions should be recorded as ADRs when significant technical decisions are made.

## Step 12 — Pull Request Governance

All changes to protected branches must use Pull Requests.

Required controls may include:

* Required approvals
* CODEOWNERS review
* Automated CI
* Security scans
* Terraform validation
* Resolved review conversations

## Step 13 — Deployment

Deployment should follow the approved CI/CD process.

A typical flow is:


Developer
    ↓
Pull Request
    ↓
CI
    ↓
Security Scans
    ↓
Review
    ↓
Merge
    ↓
Build
    ↓
Deploy to Dev
    ↓
Validation
    ↓
Test
    ↓
Production Approval
    ↓
Production Deployment


## Step 14 — Handover to Operations

Before production readiness, the application team should provide:

* Application documentation
* Architecture documentation
* Monitoring requirements
* Alert requirements
* Troubleshooting procedures
* Support contacts
* Escalation information
* Deployment and rollback procedures

## Self-Service Principles

The platform should allow application teams to perform common tasks without requiring manual Platform Engineering implementation.

Examples include:

* Creating a standard repository
* Consuming Terraform modules
* Consuming reusable workflows
* Running security scans
* Running tests
* Creating standard infrastructure
* Accessing standardized documentation

## Onboarding Completion Criteria

An application is considered onboarded when:

* Repository uses the standard structure.
* Application tests are configured.
* CI workflow is enabled.
* Security scanning is enabled.
* Infrastructure follows approved standards.
* Required Terraform validation passes.
* Container security requirements are satisfied where applicable.
* Monitoring requirements are documented.
* Architecture documentation exists.
* Ownership is documented.
* Deployment and rollback procedures are documented.

## Expected Outcome

The onboarding process should provide:

* Consistent repository structure
* Reduced manual setup
* Faster developer onboarding
* Reusable infrastructure
* Reusable CI/CD
* Consistent security controls
* Clear ownership
* Standardized operational practices

