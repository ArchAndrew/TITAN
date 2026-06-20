include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/security-hub-investigation-lambda"
}

dependencies {
  paths = [
    "../eventbridge-securityhub-actions"
  ]
}

inputs = {
  function_name      = "titan-securityhub-investigator"
  event_rule_name    = "titan-securityhub-custom-actions"
  log_retention_days = 30

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "security-hub-investigation-lambda"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}