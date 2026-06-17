include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/kms"
}

inputs = {
  alias_name  = "alias/titan-security"
  description = "TITAN customer managed key for platform security services."

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "kms"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}