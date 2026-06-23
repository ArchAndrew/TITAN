variable "topic_arn" {
  description = "SNS topic ARN for TITAN security notifications."
  type        = string
}

variable "notification_email" {
  description = "Email address to subscribe to TITAN security notifications."
  type        = string
}