output "organization_id" {
  value = data.aws_organizations_organization.current.id
}

output "organization_arn" {
  value = data.aws_organizations_organization.current.arn
}

output "master_account_id" {
  value = data.aws_organizations_organization.current.master_account_id
}

output "feature_set" {
  value = data.aws_organizations_organization.current.feature_set
}
output "member_account_ids" {
  value = {
    for key, account in aws_organizations_account.member : key => account.id
  }
}