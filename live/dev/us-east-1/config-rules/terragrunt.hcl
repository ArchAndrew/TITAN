include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/config-rules"
}

dependencies {
  paths = [
    "../aws-config"
  ]
}

inputs = {
  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "config-rules"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}