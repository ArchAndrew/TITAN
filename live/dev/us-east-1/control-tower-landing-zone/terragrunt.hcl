include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/control-tower-landing-zone"
}

inputs = {
  landing_zone_version = "4.0"
  governed_regions     = ["us-east-1"]

  log_archive_account_id = "588249212808"
  audit_account_id       = "977778967074"
}
