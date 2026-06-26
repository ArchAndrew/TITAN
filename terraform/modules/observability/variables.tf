variable "environment" {
  description = "Environment name"
  type        = string
}

variable "sns_topic_arn" {
  description = "SNS topic for alerting"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}