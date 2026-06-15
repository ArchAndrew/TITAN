variable "project_name" {
  description = "Name of the project."
  type        = string
  default     = "titan"
}

variable "environment" {
  description = "Bootstrap environment name."
  type        = string
  default     = "bootstrap"
}

variable "aws_region" {
  description = "AWS region for backend resources."
  type        = string
  default     = "us-east-1"
}

variable "state_bucket_name" {
  description = "Globally unique S3 bucket name for Terraform remote state."
  type        = string
}

variable "lock_table_name" {
  description = "DynamoDB table name for Terraform state locking."
  type        = string
  default     = "titan-terraform-locks"
}

variable "tags" {
  description = "Common tags applied to all bootstrap resources."
  type        = map(string)
  default = {
    Project     = "TITAN"
    ManagedBy   = "Terraform"
    Environment = "Bootstrap"
  }
}