output "event_rule_name" {
  value = aws_cloudwatch_event_rule.securityhub_custom_actions.name
}

output "event_rule_arn" {
  value = aws_cloudwatch_event_rule.securityhub_custom_actions.arn
}

output "log_group_name" {
  value = aws_cloudwatch_log_group.securityhub_actions.name
}

output "log_group_arn" {
  value = aws_cloudwatch_log_group.securityhub_actions.arn
}