output "investigate_action_arn" {
  value = aws_securityhub_action_target.investigate.arn
}

output "escalate_action_arn" {
  value = aws_securityhub_action_target.escalate.arn
}

output "suppress_action_arn" {
  value = aws_securityhub_action_target.suppress.arn
}

output "custom_actions_enabled" {
  value = true
}