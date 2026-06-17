variable "trail_name" {
  description = "CloudTrail name."
  type        = string
  default     = "titan-cloudtrail"
}

variable "bucket_name" {
  description = "S3 bucket for CloudTrail logs."
  type        = string
}

variable "kms_key_id" {
  description = "KMS key ARN or alias for CloudTrail encryption."
  type        = string
  default     = null
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}