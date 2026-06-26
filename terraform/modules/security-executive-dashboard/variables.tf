variable "dashboard_name" {
  description = "CloudWatch dashboard name"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}