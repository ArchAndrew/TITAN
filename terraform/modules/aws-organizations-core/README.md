# AWS Organizations Core

## Purpose

Establishes and manages the AWS Organizations governance foundation for the TITAN Enterprise Self-Service Platform. This module creates and manages the AWS Organization, provisions member accounts, and exposes organization metadata for downstream governance modules.

---

## Responsibilities

- Create and manage the AWS Organization
- Enable the `ALL` feature set
- Enable trusted AWS service integrations
- Provision AWS Organization member accounts
- Export Organization metadata for downstream modules
- Serve as the governance root for the TITAN platform

---

## Managed Resources

- AWS Organization
- AWS Organization Member Accounts
- Trusted Service Access
- Organization Outputs
  - Organization ID
  - Organization ARN
  - Management Account ID
  - Feature Set
  - Member Account IDs

---

## Downstream Dependencies

The following modules consume outputs from this module:

- IAM Identity Center
- SCP Guardrails
- CloudTrail
- AWS Config
- Security Hub
- GuardDuty
- Budget Guardrails
- Access Analyzer
- Control Tower Landing Zone

---

## Notes

- Member accounts are provisioned declaratively using Terraform.
- Account deletion is protected with `prevent_destroy`.
- Account closure is disabled (`close_on_deletion = false`) to prevent accidental loss.
- Organization metadata is exported as Terraform outputs for cross-module dependencies.