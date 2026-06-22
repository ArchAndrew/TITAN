output "security_alerts_topic_name" {
  value = aws_sns_topic.security_alerts.name
}

output "security_alerts_topic_arn" {
  value = aws_sns_topic.security_alerts.arn
}