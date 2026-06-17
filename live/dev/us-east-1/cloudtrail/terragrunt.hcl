include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/cloudtrail"
}

inputs = {
  trail_name  = "titan-cloudtrail"
  bucket_name = "titan-cloudtrail-144618662969-us-east-1"
  kms_key_id  = "arn:aws:kms:us-east-1:144618662969:key/6a32981f-4245-44dd-b723-405398ecce73"

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "cloudtrail"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}