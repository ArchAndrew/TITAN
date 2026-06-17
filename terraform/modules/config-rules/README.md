# Config Rules

Creates AWS Config managed rules for TITAN continuous compliance.

## Purpose

- Evaluate resource compliance
- Support governance visibility
- Feed Security Hub compliance context
- Provide audit evidence for cloud controls

## Rules

- S3 public read prohibited
- S3 public write prohibited
- Encrypted EBS volumes
- Root account MFA enabled
- CloudTrail enabled
- IAM password policy

## Notes

AWS Config must already be enabled before deploying these rules.