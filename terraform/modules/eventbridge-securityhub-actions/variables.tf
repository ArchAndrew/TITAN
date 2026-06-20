variable "log_group_name" {
  description = "CloudWatch log group name for Security Hub custom action events."
  type        = string
  default     = "/aws/events/titan/securityhub/custom-actions"
}

variable "retention_in_days" {
  description = "CloudWatch log retention period."
  type        = number
  default     = 30
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}