variable "target_id" {
  description = "AWS Organizations target ID where SCPs will be attached. Usually the Root ID or OU ID."
  type        = string
}

variable "enable_region_restriction" {
  description = "Whether to enable region restriction SCP."
  type        = bool
  default     = false
}

variable "allowed_regions" {
  description = "AWS regions allowed when region restriction is enabled."
  type        = list(string)
  default     = ["us-east-1"]
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}