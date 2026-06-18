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