variable "config_bucket_name" {
  description = "S3 bucket name for AWS Config delivery."
  type        = string
}

variable "recorder_name" {
  description = "AWS Config recorder name."
  type        = string
  default     = "titan-config-recorder"
}

variable "delivery_channel_name" {
  description = "AWS Config delivery channel name."
  type        = string
  default     = "titan-config-delivery-channel"
}

variable "tags" {
  description = "Common governance tags."
  type        = map(string)
  default     = {}
}