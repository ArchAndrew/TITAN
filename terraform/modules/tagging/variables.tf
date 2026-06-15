variable "project_name" {
  description = "Name of the platform or project."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod", "bootstrap", "shared"], var.environment)
    error_message = "Environment must be one of: dev, staging, prod, bootstrap, shared."
  }
}

variable "application" {
  description = "Application or platform component name."
  type        = string
}

variable "business_owner" {
  description = "Business owner responsible for the workload."
  type        = string
}

variable "technical_owner" {
  description = "Technical owner responsible for the workload."
  type        = string
}

variable "cost_center" {
  description = "Cost center responsible for cloud spend."
  type        = string
}

variable "data_classification" {
  description = "Data classification of the workload."
  type        = string

  validation {
    condition     = contains(["public", "internal", "confidential", "restricted"], var.data_classification)
    error_message = "Data classification must be one of: public, internal, confidential, restricted."
  }
}

variable "compliance_scope" {
  description = "Compliance scope for the workload."
  type        = string
  default     = "nist-800-53"
}

variable "managed_by" {
  description = "Tool responsible for managing the resource."
  type        = string
  default     = "terraform"
}

variable "additional_tags" {
  description = "Additional optional tags."
  type        = map(string)
  default     = {}
}