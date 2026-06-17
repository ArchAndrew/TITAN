variable "alias_name" {
  description = "KMS alias name."
  type        = string
  default     = "alias/titan-security"
}

variable "description" {
  description = "KMS key description."
  type        = string
  default     = "TITAN customer managed key for platform security services."
}

variable "deletion_window_in_days" {
  description = "KMS key deletion window."
  type        = number
  default     = 30
}

variable "enable_key_rotation" {
  description = "Enable automatic KMS key rotation."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}