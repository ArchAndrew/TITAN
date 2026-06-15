# TITAN Tagging Module

## Purpose

This module standardizes required governance tags across TITAN infrastructure.

TITAN treats tagging as a governance control, not as optional metadata.

## Required Tags

| Tag | Purpose |
|---|---|
| Project | Identifies the platform or project |
| Environment | Identifies dev, staging, prod, bootstrap, or shared |
| Application | Identifies the application or platform component |
| BusinessOwner | Identifies the business owner |
| TechnicalOwner | Identifies the technical owner |
| CostCenter | Supports cost governance |
| DataClassification | Supports security and compliance decisions |
| ComplianceScope | Identifies compliance framework alignment |
| ManagedBy | Identifies automation owner |

## Why This Exists

Tags are required for:

- Cost allocation
- Ownership tracking
- Security review
- Compliance evidence
- Budget governance
- Resource inventory

## Usage

```hcl
module "tags" {
  source = "../terraform/modules/tagging"

  project_name        = "TITAN"
  environment         = "dev"
  application         = "platform-api"
  business_owner      = "platform-engineering"
  technical_owner     = "cloud-platform"
  cost_center         = "PLAT-001"
  data_classification = "internal"
}

resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"

  tags = module.tags.tags
}

This module supports:

CM-2: Baseline Configuration
CM-6: Configuration Settings
RA-3: Risk Assessment
AU-12: Audit Record Generation