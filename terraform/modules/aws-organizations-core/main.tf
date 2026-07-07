data "aws_organizations_organization" "current" {}
resource "aws_organizations_account" "member" {
  for_each = var.member_accounts

  name  = each.value.name
  email = each.value.email

  parent_id = contains(["audit", "log_archive"], each.key) ? aws_organizations_organizational_unit.security.id : aws_organizations_organizational_unit.platform.id

  close_on_deletion = false

  lifecycle {
    prevent_destroy = true
  }
}
resource "aws_organizations_organizational_unit" "security" {
  name      = "Security"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}

resource "aws_organizations_organizational_unit" "platform" {
  name      = "Platform"
  parent_id = data.aws_organizations_organization.current.roots[0].id
}