resource "aws_controltower_landing_zone" "titan" {
  depends_on = [
    time_sleep.controltower_iam_propagation
  ]

  version = var.landing_zone_version

  manifest_json = jsonencode({
    governedRegions = var.governed_regions

    accessManagement = {
      enabled = true
    }

    centralizedLogging = {
      enabled   = true
      accountId = var.log_archive_account_id

      configurations = {
        loggingBucket = {
          retentionDays = 365
        }

        accessLoggingBucket = {
          retentionDays = 365
        }
      }
    }

    config = {
      enabled   = true
      accountId = var.audit_account_id

      configurations = {
        loggingBucket = {
          retentionDays = 365
        }

        accessLoggingBucket = {
          retentionDays = 365
        }
      }
    }

    securityRoles = {
      enabled   = true
      accountId = var.audit_account_id
    }

    backup = {
      enabled = false
    }
  })
}