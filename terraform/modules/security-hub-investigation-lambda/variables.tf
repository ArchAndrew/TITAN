variable "function_name" {
  type    = string
  default = "titan-securityhub-investigator"
}

variable "event_rule_name" {
  type    = string
  default = "titan-securityhub-custom-actions"
}

variable "log_retention_days" {
  type    = number
  default = 30
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "sns_topic_arn" {
  description = "SNS topic ARN for TITAN security notifications."
  type        = string
}