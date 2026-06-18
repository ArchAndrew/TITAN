output "critical_insight_arn" {
  value = aws_securityhub_insight.critical_findings.arn
}

output "high_insight_arn" {
  value = aws_securityhub_insight.high_findings.arn
}