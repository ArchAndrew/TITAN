resource "aws_cloudwatch_log_group" "platform_events" {

  name              = "/titan/platform/events"
  retention_in_days = 30

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "security_events" {

  name              = "/titan/security/events"
  retention_in_days = 30

  tags = var.tags
}

resource "aws_cloudwatch_log_group" "eks_control_plane" {

  name              = "/aws/eks/titan/control-plane"
  retention_in_days = 30

  tags = var.tags
}

#Investigation Error Metric

resource "aws_cloudwatch_log_metric_filter" "investigation_errors" {

  name           = "titan-investigation-errors"
  log_group_name = aws_cloudwatch_log_group.security_events.name

  pattern = "ERROR"

  metric_transformation {

    name      = "InvestigationErrors"
    namespace = "TITAN/Security"
    value     = "1"
  }
}

#Security Alarm

resource "aws_cloudwatch_metric_alarm" "investigation_error_alarm" {

  alarm_name          = "titan-investigation-errors"
  comparison_operator = "GreaterThanThreshold"
  evaluation_periods  = 1
  metric_name         = "InvestigationErrors"
  namespace           = "TITAN/Security"
  period              = 300
  statistic           = "Sum"
  threshold           = 0

  alarm_description = "TITAN investigation workflow errors detected"

  alarm_actions = [
    var.sns_topic_arn
  ]

  tags = var.tags
}

#Executive Observability Dashboard

resource "aws_cloudwatch_dashboard" "observability" {

  dashboard_name = "titan-observability"

  dashboard_body = jsonencode({

    widgets = [

      {
        type   = "text"
        x      = 0
        y      = 0
        width  = 24
        height = 3

        properties = {
          markdown = "# TITAN Observability Dashboard"
        }
      },

      {
        type   = "metric"
        x      = 0
        y      = 4
        width  = 12
        height = 6

        properties = {

          metrics = [
            [
              "TITAN/Security",
              "InvestigationErrors"
            ]
          ]

          period = 300
          stat   = "Sum"
          title  = "Security Investigation Errors"
          region = "us-east-1"
        }
      }
    ]
  })
}