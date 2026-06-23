output "subscription_arn" {
  value = aws_sns_topic_subscription.email.arn
}

output "notification_email" {
  value = var.notification_email
}