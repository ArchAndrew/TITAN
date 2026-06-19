resource "aws_securityhub_automation_rule" "critical_findings" {
  rule_name   = "TITAN Critical Findings Triage"
  description = "Prioritize active critical findings for executive and security operations review."
  rule_order  = 1
  rule_status = var.rule_status

  criteria {
    severity_label {
      comparison = "EQUALS"
      value      = "CRITICAL"
    }

    record_state {
      comparison = "EQUALS"
      value      = "ACTIVE"
    }

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
    }
  }

  actions {
    type = "FINDING_FIELDS_UPDATE"

    finding_fields_update {
      note {
        text       = "TITAN automation rule identified this as a critical active finding requiring priority review."
        updated_by = "TITAN Security Hub Automation"
      }

      user_defined_fields = {
        TITANPriority = "P1"
        TITANCategory = "CriticalFinding"
        TITANRouting  = "SecurityOperations"
      }

      workflow {
        status = "NEW"
      }
    }
  }
}

resource "aws_securityhub_automation_rule" "iam_risk_findings" {
  rule_name   = "TITAN IAM Risk Findings Triage"
  description = "Classify active IAM-related Security Hub findings as identity risk."
  rule_order  = 2
  rule_status = var.rule_status

  criteria {
    resource_type {
      comparison = "PREFIX"
      value      = "AwsIam"
    }

    record_state {
      comparison = "EQUALS"
      value      = "ACTIVE"
    }

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
    }
  }

  actions {
    type = "FINDING_FIELDS_UPDATE"

    finding_fields_update {
      note {
        text       = "TITAN automation rule classified this finding as an IAM or identity-related risk."
        updated_by = "TITAN Security Hub Automation"
      }

      user_defined_fields = {
        TITANPriority = "P2"
        TITANCategory = "IdentityRisk"
        TITANRouting  = "IAMGovernance"
      }

      workflow {
        status = "NEW"
      }
    }
  }
}

resource "aws_securityhub_automation_rule" "s3_public_exposure_findings" {
  rule_name   = "TITAN S3 Public Exposure Triage"
  description = "Classify active S3 bucket findings as public exposure risk."
  rule_order  = 3
  rule_status = var.rule_status

  criteria {
    resource_type {
      comparison = "EQUALS"
      value      = "AwsS3Bucket"
    }

    record_state {
      comparison = "EQUALS"
      value      = "ACTIVE"
    }

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
    }
  }

  actions {
    type = "FINDING_FIELDS_UPDATE"

    finding_fields_update {
      note {
        text       = "TITAN automation rule classified this finding as a potential S3 public exposure risk."
        updated_by = "TITAN Security Hub Automation"
      }

      user_defined_fields = {
        TITANPriority = "P1"
        TITANCategory = "PublicExposure"
        TITANRouting  = "CloudSecurity"
      }

      workflow {
        status = "NEW"
      }
    }
  }
}