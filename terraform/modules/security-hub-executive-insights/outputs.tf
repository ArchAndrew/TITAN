output "public_exposure_insight_arn" {
  value = aws_securityhub_insight.public_exposure_findings.arn
}

output "iam_risk_insight_arn" {
  value = aws_securityhub_insight.iam_risk_findings.arn
}

output "failed_compliance_insight_arn" {
  value = aws_securityhub_insight.failed_compliance_findings.arn
}

output "encryption_insight_arn" {
  value = aws_securityhub_insight.encryption_findings.arn
}