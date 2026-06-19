output "critical_findings_rule_arn" {
  value = aws_securityhub_automation_rule.critical_findings.arn
}

output "iam_risk_findings_rule_arn" {
  value = aws_securityhub_automation_rule.iam_risk_findings.arn
}

output "s3_public_exposure_rule_arn" {
  value = aws_securityhub_automation_rule.s3_public_exposure_findings.arn
}

output "automation_rules_enabled" {
  value = true
}