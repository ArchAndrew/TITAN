resource "aws_sns_topic" "security_alerts" {
  name = var.topic_name
  tags = var.tags
}