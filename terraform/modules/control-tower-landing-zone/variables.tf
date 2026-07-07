variable "landing_zone_version" {
  type        = string
  description = "AWS Control Tower landing zone version."
  default     = "4.0"
}

variable "governed_regions" {
  type        = list(string)
  description = "Regions governed by Control Tower."
  default     = ["us-east-1"]
}

variable "log_archive_account_id" {
  type        = string
  description = "Existing Log Archive account ID."
}

variable "audit_account_id" {
  type        = string
  description = "Existing Audit/Security account ID."
}
