# TITAN Terraform Bootstrap

## Purpose

This module creates the foundational backend infrastructure required for TITAN Terraform and Terragrunt deployments.

## Resources Created

- S3 bucket for Terraform remote state
- DynamoDB table for state locking
- KMS key for state encryption
- S3 public access block
- S3 bucket policy enforcing TLS
- Versioning for state recovery

## Why This Exists

TITAN requires secure, centralized, and auditable Terraform state management before additional infrastructure modules are deployed.

This bootstrap module supports:

- Secure remote state
- State locking
- Encryption
- Recovery through versioning
- Governance evidence

## Usage

```bash
terraform init
terraform plan -var="state_bucket_name=<globally-unique-bucket-name>"
terraform apply -var="state_bucket_name=<globally-unique-bucket-name>"