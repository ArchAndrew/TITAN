resource "aws_securityhub_insight" "critical_findings" {
  name = "TITAN Critical Findings"

  filters {
    severity_label {
      comparison = "EQUALS"
      value      = "CRITICAL"
    }
  }

  group_by_attribute = "ResourceId"
}

resource "aws_securityhub_insight" "high_findings" {
  name = "TITAN High Findings"

  filters {
    severity_label {
      comparison = "EQUALS"
      value      = "HIGH"
    }
  }

  group_by_attribute = "ResourceId"
}

resource "aws_securityhub_insight" "failed_compliance_findings" {
  name = "TITAN Failed Compliance Findings"

  filters {
    compliance_status {
      comparison = "EQUALS"
      value      = "FAILED"
    }
  }

  group_by_attribute = "ResourceId"
}

resource "aws_securityhub_insight" "iam_risk_findings" {
  name = "TITAN IAM Risk Findings"

  filters {
    resource_type {
      comparison = "PREFIX"
      value      = "AwsIam"
    }
  }

  group_by_attribute = "ResourceId"
}

resource "aws_securityhub_insight" "s3_exposure_findings" {
  name = "TITAN S3 Exposure Findings"

  filters {
    resource_type {
      comparison = "EQUALS"
      value      = "AwsS3Bucket"
    }
  }

  group_by_attribute = "ResourceId"
}

resource "aws_securityhub_insight" "new_active_findings" {
  name = "TITAN New Active Findings"

  filters {
    record_state {
      comparison = "EQUALS"
      value      = "ACTIVE"
    }

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
    }
  }

  group_by_attribute = "ResourceId"
}