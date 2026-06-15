output "state_bucket_name" {
  description = "Terraform remote state S3 bucket name."
  value       = aws_s3_bucket.terraform_state.bucket
}

output "state_bucket_arn" {
  description = "Terraform remote state S3 bucket ARN."
  value       = aws_s3_bucket.terraform_state.arn
}

output "lock_table_name" {
  description = "Terraform state lock DynamoDB table name."
  value       = aws_dynamodb_table.terraform_locks.name
}

output "kms_key_arn" {
  description = "KMS key ARN used for Terraform state encryption."
  value       = aws_kms_key.terraform_state.arn
}

output "kms_alias_name" {
  description = "KMS alias for Terraform state encryption."
  value       = aws_kms_alias.terraform_state.name
}