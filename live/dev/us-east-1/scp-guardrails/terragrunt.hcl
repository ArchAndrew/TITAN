include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/scp-guardrails"
}

inputs = {
  target_id = "r-ejah"

  enable_region_restriction = false

  allowed_regions = [
    "us-east-1"
  ]

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "governance"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}