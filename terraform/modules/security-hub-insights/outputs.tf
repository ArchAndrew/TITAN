output "critical_insight_arn" {
  value = aws_securityhub_insight.critical_findings.arn
}

output "high_insight_arn" {
  value = aws_securityhub_insight.high_findings.arn
}

output "failed_compliance_insight_arn" {
  value = aws_securityhub_insight.failed_compliance_findings.arn
}

output "iam_risk_insight_arn" {
  value = aws_securityhub_insight.iam_risk_findings.arn
}

output "s3_exposure_insight_arn" {
  value = aws_securityhub_insight.s3_exposure_findings.arn
}

output "new_active_insight_arn" {
  value = aws_securityhub_insight.new_active_findings.arn
}