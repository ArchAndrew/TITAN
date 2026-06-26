output "platform_log_group" {
  value = aws_cloudwatch_log_group.platform_events.name
}

output "security_log_group" {
  value = aws_cloudwatch_log_group.security_events.name
}

output "eks_log_group" {
  value = aws_cloudwatch_log_group.eks_control_plane.name
}

output "dashboard_name" {
  value = aws_cloudwatch_dashboard.observability.dashboard_name
}