output "config_rule_names" {
  value = [
    aws_config_config_rule.s3_bucket_public_read_prohibited.name,
    aws_config_config_rule.s3_bucket_public_write_prohibited.name,
    aws_config_config_rule.encrypted_volumes.name,
    aws_config_config_rule.root_account_mfa_enabled.name,
    aws_config_config_rule.cloudtrail_enabled.name,
    aws_config_config_rule.iam_password_policy.name
  ]
}

output "config_rules_enabled" {
  value = true
}