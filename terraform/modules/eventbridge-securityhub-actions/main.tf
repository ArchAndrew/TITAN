resource "aws_cloudwatch_log_group" "securityhub_actions" {
  name              = var.log_group_name
  retention_in_days = var.retention_in_days
  tags              = var.tags
}

resource "aws_cloudwatch_log_resource_policy" "eventbridge_to_logs" {
  policy_name = "titan-eventbridge-securityhub-actions-logs"

  policy_document = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowEventBridgeToWriteLogs"
        Effect = "Allow"
        Principal = {
          Service = [
            "events.amazonaws.com",
            "delivery.logs.amazonaws.com"
          ]
        }
        Action = [
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ]
        Resource = "${aws_cloudwatch_log_group.securityhub_actions.arn}:*"
      }
    ]
  })
}

resource "aws_cloudwatch_event_rule" "securityhub_custom_actions" {
  name        = "titan-securityhub-custom-actions"
  description = "Captures TITAN Security Hub custom action events."

  event_pattern = jsonencode({
    source      = ["aws.securityhub"]
    detail-type = ["Security Hub Findings - Custom Action"]
  })

  tags = var.tags
}

resource "aws_cloudwatch_event_target" "securityhub_actions_to_logs" {
  rule = aws_cloudwatch_event_rule.securityhub_custom_actions.name
  arn  = aws_cloudwatch_log_group.securityhub_actions.arn

  depends_on = [
    aws_cloudwatch_log_resource_policy.eventbridge_to_logs
  ]
}