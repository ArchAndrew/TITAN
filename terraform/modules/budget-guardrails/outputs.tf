output "budget_name" {
  value = aws_budgets_budget.monthly_budget.name
}

output "monthly_limit" {
  value = var.monthly_limit
}

output "thresholds" {
  value = var.alert_thresholds
}