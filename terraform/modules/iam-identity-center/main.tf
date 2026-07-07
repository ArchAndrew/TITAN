data "aws_ssoadmin_instances" "this" {}

locals {
  instance_arn      = tolist(data.aws_ssoadmin_instances.this.arns)[0]
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]
}

resource "aws_ssoadmin_permission_set" "this" {
  for_each = var.permission_sets

  name             = each.key
  description      = each.value.description
  instance_arn     = local.instance_arn
  session_duration = each.value.session_duration
}

resource "aws_ssoadmin_managed_policy_attachment" "this" {
  for_each = {
    for item in flatten([
      for ps_name, ps in var.permission_sets : [
        for policy_arn in ps.managed_policy_arns : {
          key        = "${ps_name}-${basename(policy_arn)}"
          ps_name    = ps_name
          policy_arn = policy_arn
        }
      ]
    ]) : item.key => item
  }

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.ps_name].arn
  managed_policy_arn = each.value.policy_arn
}

resource "aws_identitystore_group" "this" {
  for_each = var.assignments

  identity_store_id = local.identity_store_id
  display_name      = each.value.group_name

  description = "TITAN ${each.value.group_name} access group"
}

resource "aws_ssoadmin_account_assignment" "this" {
  for_each = var.assignments

  instance_arn       = local.instance_arn
  permission_set_arn = aws_ssoadmin_permission_set.this[each.value.permission_set_name].arn

  principal_id = aws_identitystore_group.this[each.key].group_id
  principal_type = "GROUP"

  target_id   = each.value.account_id
  target_type = "AWS_ACCOUNT"
}