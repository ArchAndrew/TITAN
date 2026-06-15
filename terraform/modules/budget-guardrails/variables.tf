variable "budget_name" {
  description = "Budget name."
  type        = string
}

variable "monthly_limit" {
  description = "Monthly budget limit in USD."
  type        = number
}

variable "notification_email" {
  description = "Budget notification email."
  type        = string
}

variable "alert_thresholds" {
  description = "Percentage thresholds for alerts."
  type        = list(number)

  default = [
    50,
    75,
    90,
    100
  ]
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
}