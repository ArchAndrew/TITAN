# ADR-006: AWS Control Tower Integration Strategy

## Status
Accepted

## Context
TITAN is evolving from an infrastructure project into an enterprise internal developer platform. Target enterprise environments often require AWS Control Tower for governed multi-account landing zones, account enrollment, preventive controls, detective controls, and standardized account baselines.

## Decision
TITAN will be designed as Control Tower-compatible.

For v1, TITAN will not depend on a live Control Tower landing zone. Instead, TITAN will implement and document equivalent governance capabilities using Terraform/Terragrunt while preserving a future path to AWS Control Tower and Account Factory for Terraform.

## Rationale
A live Control Tower deployment introduces unnecessary cost, complexity, and account-management overhead for the lab environment. However, the platform must still demonstrate enterprise governance alignment.

## Current TITAN Equivalents
- AWS Organizations
- Organizational Units
- Service Control Policies
- IAM Identity Center design
- CloudTrail
- AWS Config
- Security Hub
- GuardDuty
- Budget guardrails
- KMS-backed logging
- S3 log archive patterns
- Terraform/Terragrunt account baseline modules

## Future Control Tower Path
In an enterprise deployment, Control Tower would provide the governed landing zone. TITAN would integrate with Account Factory for Terraform to provision workload accounts, apply baselines, enforce tags, attach SCPs, and register accounts into observability and compliance workflows.

## Consequences
TITAN remains lightweight for portfolio development while still aligning with enterprise AWS governance patterns.