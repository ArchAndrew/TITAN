include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/security-notifications"
}

inputs = {
  topic_name = "titan-security-alerts"

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "security-notifications"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}