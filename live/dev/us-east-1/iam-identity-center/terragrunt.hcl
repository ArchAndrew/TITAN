include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/iam-identity-center"
}

inputs = {

  permission_sets = {

    PlatformAdmin = {
      description         = "Full administrative access for platform engineering."
      session_duration    = "PT8H"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/AdministratorAccess"
      ]
    }

    SecurityAdmin = {
      description         = "Security administration."
      session_duration    = "PT8H"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/SecurityAudit"
      ]
    }

    PlatformEngineer = {
      description         = "Platform engineering operations."
      session_duration    = "PT8H"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/PowerUserAccess"
      ]
    }

    ReadOnly = {
      description         = "Read-only access."
      session_duration    = "PT8H"
      managed_policy_arns = [
        "arn:aws:iam::aws:policy/ReadOnlyAccess"
      ]
    }
  }

assignments = {

  platform-admin = {
    group_name          = "PlatformAdmins"
    permission_set_name = "PlatformAdmin"
    account_id          = "477187160862" # Shared Services
  }

  security-admin = {
    group_name          = "SecurityAdmins"
    permission_set_name = "SecurityAdmin"
    account_id          = "977778967074" # Audit
  }

  platform-engineer = {
    group_name          = "PlatformEngineers"
    permission_set_name = "PlatformEngineer"
    account_id          = "762382993947" # Platform Dev
  }

  readonly = {
    group_name          = "ReadOnly"
    permission_set_name = "ReadOnly"
    account_id          = "598886663256" # Platform Prod
  }
 }
}