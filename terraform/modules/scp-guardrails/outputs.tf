output "cloudtrail_scp_id" {
  value = aws_organizations_policy.deny_disable_cloudtrail.id
}

output "config_scp_id" {
  value = aws_organizations_policy.deny_disable_config.id
}

output "leave_org_scp_id" {
  value = aws_organizations_policy.deny_leave_organization.id
}

/*output "region_restriction_scp_id" {
  value = var.enable_region_restriction ? aws_organizations_policy.region_restriction[0].id : null
}*/