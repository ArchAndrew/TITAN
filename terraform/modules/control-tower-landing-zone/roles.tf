resource "aws_iam_role" "controltower_admin" {
  name = "AWSControlTowerAdmin"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "controltower.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "controltower_admin_policy" {
  role       = aws_iam_role.controltower_admin.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerServiceRolePolicy"
}

resource "aws_iam_role_policy" "controltower_admin_inline" {
  name = "AWSControlTowerAdminPolicy"
  role = aws_iam_role.controltower_admin.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "ec2:DescribeAvailabilityZones"
      Resource = "*"
    }]
  })
}

resource "aws_iam_role" "controltower_stackset_role" {
  name = "AWSControlTowerStackSetRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudformation.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy" "controltower_stackset_inline" {
  name = "AWSControlTowerStackSetRolePolicy"
  role = aws_iam_role.controltower_stackset_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "sts:AssumeRole"
      Resource = "arn:aws:iam::*:role/AWSControlTowerExecution"
    }]
  })
}

resource "aws_iam_role" "controltower_cloudtrail_role" {
  name = "AWSControlTowerCloudTrailRole"
  path = "/service-role/"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "cloudtrail.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "controltower_cloudtrail_policy" {
  role       = aws_iam_role.controltower_cloudtrail_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSControlTowerCloudTrailRolePolicy"
}

resource "time_sleep" "controltower_iam_propagation" {
  depends_on = [
    aws_iam_role.controltower_admin,
    aws_iam_role_policy_attachment.controltower_admin_policy,
    aws_iam_role_policy.controltower_admin_inline,
    aws_iam_role.controltower_stackset_role,
    aws_iam_role_policy.controltower_stackset_inline,
    aws_iam_role.controltower_cloudtrail_role
  ]

  create_duration = "90s"
}