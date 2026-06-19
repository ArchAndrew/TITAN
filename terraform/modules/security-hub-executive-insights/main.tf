resource "aws_securityhub_insight" "public_exposure_findings" {
  name = "TITAN Public Exposure Findings"

  filters {
    resource_type {
      comparison = "EQUALS"
      value      = "AwsS3Bucket"
    }

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
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

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
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

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
    }
  }

  group_by_attribute = "ResourceId"
}

resource "aws_securityhub_insight" "encryption_findings" {
  name = "TITAN Encryption Findings"

  filters {
    title {
      comparison = "PREFIX"
      value      = "Encryption"
    }

    workflow_status {
      comparison = "EQUALS"
      value      = "NEW"
    }
  }

  group_by_attribute = "ResourceId"
}