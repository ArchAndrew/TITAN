include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/budget-guardrails"
}

inputs = {
  budget_name        = "titan-dev-budget"
  monthly_limit      = 50
  notification_email = "andrew@strongtowersecurity.io"

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "platform-foundation"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}