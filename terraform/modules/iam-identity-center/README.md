# IAM Identity Center Module

This module configures AWS IAM Identity Center permission sets and account assignments for TITAN.

## Purpose

IAM Identity Center provides centralized workforce access across AWS accounts. In TITAN, this module supports the governance layer by defining who can access platform, security, audit, and workload accounts.

## What It Manages

- Permission sets
- AWS managed policy attachments
- Group-based account assignments

## Assumptions

- IAM Identity Center is already enabled in the AWS Organization.
- Groups already exist in the Identity Store.
- Account IDs are supplied by the live Terragrunt configuration.

## TITAN Governance Role

This module supports:

- Least privilege
- Separation of duties
- Centralized access governance
- Multi-account access control
- Control Tower alignment
