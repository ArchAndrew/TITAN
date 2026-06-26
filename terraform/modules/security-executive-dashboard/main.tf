resource "aws_cloudwatch_dashboard" "security_executive" {

  dashboard_name = var.dashboard_name

  dashboard_body = jsonencode({

    widgets = [

      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 2

        properties = {
          markdown = "# TITAN Executive Security Dashboard"
        }
      },

      {
        type   = "text"
        x      = 0
        y      = 3
        width  = 24
        height = 4

        properties = {
          markdown = <<EOF
## Executive Security Views

Security Hub Insights:
- Critical Findings
- High Findings
- Failed Compliance Findings
- IAM Risk Findings
- S3 Exposure Findings
- New Active Findings

EOF
        }
      }
    ]
  })

}