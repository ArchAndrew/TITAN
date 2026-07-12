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
      email = "audit@example.com"
    }

    log_archive = {
      name  = "TITAN-Log-Archive"
      email = "archive@example.com"
    }

    shared_services = {
      name  = "TITAN-Shared-Services"
      email = "shared-services@example.com"
    }

    platform_dev = {
      name  = "TITAN-Platform-Dev"
      email = "platform-dev@example.com"
    }

    platform_prod = {
      name  = "TITAN-Platform-Prod"
      email = "platform-prod@example.com"
    }
  }
}