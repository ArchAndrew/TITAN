resource "aws_organizations_policy" "deny_disable_cloudtrail" {
  name        = "titan-deny-disable-cloudtrail"
  description = "Prevents disabling or deleting CloudTrail trails."
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyDisableCloudTrail"
        Effect = "Deny"
        Action = [
          "cloudtrail:DeleteTrail",
          "cloudtrail:StopLogging",
          "cloudtrail:UpdateTrail"
        ]
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_organizations_policy_attachment" "deny_disable_cloudtrail" {
  policy_id = aws_organizations_policy.deny_disable_cloudtrail.id
  target_id = var.target_id
}

resource "aws_organizations_policy" "deny_disable_config" {
  name        = "titan-deny-disable-config"
  description = "Prevents disabling AWS Config recording and delivery channels."
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "DenyDisableConfig"
        Effect = "Deny"
        Action = [
          "config:DeleteConfigurationRecorder",
          "config:DeleteDeliveryChannel",
          "config:StopConfigurationRecorder"
        ]
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_organizations_policy_attachment" "deny_disable_config" {
  policy_id = aws_organizations_policy.deny_disable_config.id
  target_id = var.target_id
}

resource "aws_organizations_policy" "deny_leave_organization" {
  name        = "titan-deny-leave-organization"
  description = "Prevents member accounts from leaving the AWS Organization."
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenyLeaveOrganization"
        Effect   = "Deny"
        Action   = "organizations:LeaveOrganization"
        Resource = "*"
      }
    ]
  })

  tags = var.tags
}

resource "aws_organizations_policy_attachment" "deny_leave_organization" {
  policy_id = aws_organizations_policy.deny_leave_organization.id
  target_id = var.target_id
}

/*resource "aws_organizations_policy" "region_restriction" {
  count = var.enable_region_restriction ? 1 : 0

  name        = "titan-region-restriction"
  description = "Restricts AWS usage to approved regions."
  type        = "SERVICE_CONTROL_POLICY"

  content = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "DenyUnapprovedRegions"
        Effect   = "Deny"
        NotAction = [
          "iam:*",
          "organizations:*",
          "route53:*",
          "cloudfront:*",
          "support:*",
          "billing:*",
          "account:*"
        ]
        Resource = "*"
        Condition = {
          StringNotEquals = {
            "aws:RequestedRegion" = var.allowed_regions
          }
        }
      }
    ]
  })

  tags = var.tags
}

resource "aws_organizations_policy_attachment" "region_restriction" {
  count = var.enable_region_restriction ? 1 : 0

  policy_id = aws_organizations_policy.region_restriction[0].id
  target_id = var.target_id
}*/