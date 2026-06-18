include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/security-hub-insights"
}

inputs = {
  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "security-governance"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}