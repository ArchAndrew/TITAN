include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/eventbridge-securityhub-actions"
}

dependencies {
  paths = [
    "../security-hub-custom-actions"
  ]
}

inputs = {
  log_group_name    = "/aws/events/titan/securityhub/custom-actions"
  retention_in_days = 30

  tags = {
    Project            = "TITAN"
    Environment        = "dev"
    Application        = "eventbridge-securityhub-actions"
    BusinessOwner      = "platform-engineering"
    TechnicalOwner     = "cloud-platform"
    CostCenter         = "PLAT-001"
    DataClassification = "internal"
    ComplianceScope    = "nist-800-53"
    ManagedBy          = "terragrunt"
  }
}