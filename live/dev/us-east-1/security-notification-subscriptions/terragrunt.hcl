include "root" {
  path = find_in_parent_folders("root.hcl")
}

terraform {
  source = "../../../../terraform/modules/security-notification-subscriptions"
}

dependencies {
  paths = [
    "../security-notifications"
  ]
}

inputs = {
  topic_arn = "arn:aws:sns:us-east-1:144618662969:titan-security-alerts"

  notification_email = get_env(
    "TITAN_NOTIFICATION_EMAIL",
    "placeholder@example.com"
  )
}