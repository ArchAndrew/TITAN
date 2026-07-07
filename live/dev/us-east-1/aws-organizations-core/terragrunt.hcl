include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/aws-organizations-core"
}

inputs = {
  member_accounts = {
    audit = {
      name  = "TITAN-Audit"
      email = "thekingsown3733+audit@gmail.com"
    }

    log_archive = {
      name  = "TITAN-Log-Archive"
      email = "thekingsown3733+log-archive@gmail.com"
    }

    shared_services = {
      name  = "TITAN-Shared-Services"
      email = "thekingsown3733+shared-services@gmail.com"
    }

    platform_dev = {
      name  = "TITAN-Platform-Dev"
      email = "thekingsown3733+platform-dev@gmail.com"
    }

    platform_prod = {
      name  = "TITAN-Platform-Prod"
      email = "thekingsown3733+platform-prod@gmail.com"
    }
  }
}