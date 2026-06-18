variable "conformance_pack_name" {
  description = "Name of the AWS Config conformance pack."
  type        = string
  default     = "titan-security-baseline"
}

variable "template_body" {
  description = "YAML template body for the conformance pack."
  type        = string
}