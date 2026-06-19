include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/security-hub-automation-rules"
}

dependencies {
  paths = [
    "../security-hub"
  ]
}

inputs = {
  rule_status = "ENABLED"
}