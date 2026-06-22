variable "topic_name" {
  description = "SNS topic name for TITAN security notifications."
  type        = string
  default     = "titan-security-alerts"
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}