include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/guardduty"
}

inputs = {

  enable_s3_protection  = true
  enable_eks_protection = true

  finding_publishing_frequency = "FIFTEEN_MINUTES"

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "guardduty"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}