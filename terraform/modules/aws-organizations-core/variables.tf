variable "organization_feature_set" {
  description = "AWS Organizations feature set"
  type        = string
  default     = "ALL"
}

variable "service_access_principals" {
  description = "AWS services granted access to Organizations"
  type        = list(string)

  default = [
    "cloudtrail.amazonaws.com",
    "config.amazonaws.com",
    "sso.amazonaws.com"
  ]
}