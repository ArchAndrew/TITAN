include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/aws-config"
}

inputs = {
  config_bucket_name = "titan-config-144618662969-us-east-1"

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "config-governance"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}