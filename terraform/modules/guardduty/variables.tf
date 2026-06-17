variable "enable_s3_protection" {
  description = "Enable S3 data event monitoring."
  type        = bool
  default     = true
}

variable "enable_eks_protection" {
  description = "Enable EKS audit log monitoring."
  type        = bool
  default     = true
}

variable "finding_publishing_frequency" {
  description = "GuardDuty finding publishing frequency."
  type        = string
  default     = "FIFTEEN_MINUTES"
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}