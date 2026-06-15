resource "aws_budgets_budget" "monthly_budget" {

  name         = var.budget_name
  budget_type  = "COST"
  limit_amount = var.monthly_limit
  limit_unit   = "USD"
  time_unit    = "MONTHLY"

  dynamic "notification" {

    for_each = var.alert_thresholds

    content {

      comparison_operator = "GREATER_THAN"

      threshold = notification.value

      threshold_type = "PERCENTAGE"

      notification_type = "ACTUAL"

      subscriber_email_addresses = [
        var.notification_email
      ]
    }
  }
}