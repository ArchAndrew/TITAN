include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/observability"
}

inputs = {

  environment = "dev"

  sns_topic_arn = "arn:aws:sns:us-east-1:144618662969:titan-security-alerts"

  tags = {

    Project          = "TITAN"
    Environment      = "dev"
    Application      = "observability"
    BusinessOwner    = "platform-engineering"
    TechnicalOwner   = "cloud-platform"
    ComplianceScope  = "nist-800-53"
    ManagedBy        = "terragrunt"
  }
}