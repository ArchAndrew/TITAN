include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/security-executive-dashboard"
}

inputs = {

  dashboard_name = "titan-executive-security-dashboard"

  tags = {
    Project     = "TITAN"
    Environment = "dev"
  }
}