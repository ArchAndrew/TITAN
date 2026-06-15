# TITAN Budget Guardrails Module

## Purpose

This module implements budget governance controls within TITAN.

Budget controls serve as preventative governance mechanisms that provide visibility into cloud spending before budget overruns occur.

---

## Features

- Monthly cost budget
- Multi-threshold alerting
- Email notifications
- Governance integration

---

## Default Thresholds

50%
75%
90%
100%

---

## Governance Objectives

The module supports:

- Cost Governance
- Financial Accountability
- Budget Enforcement
- Cloud Operating Model Controls

---

## Example

module "budget_guardrails" {

  source = "../budget-guardrails"

  budget_name       = "titan-dev-budget"
  monthly_limit     = 100
  notification_email = "admin@example.com"

  tags = {
    Project = "TITAN"
  }
}
