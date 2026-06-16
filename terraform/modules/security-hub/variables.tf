variable "enable_default_standards" {
  description = "Whether to enable Security Hub default standards."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}