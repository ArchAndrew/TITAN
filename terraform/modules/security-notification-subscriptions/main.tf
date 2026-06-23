resource "aws_sns_topic_subscription" "email" {
  topic_arn = var.topic_arn
  protocol  = "email"
  endpoint  = var.notification_email
}