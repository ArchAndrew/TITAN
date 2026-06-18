# Security Hub Insights Module

## Purpose

Creates custom AWS Security Hub Insights used by TITAN to surface
high-priority security findings for executive and operational teams.

## Features

- Critical Findings Insight
- High Findings Insight
- Resource-based grouping
- Executive reporting support

## Usage

```hcl
module "security_hub_insights" {
  source = "../../modules/security-hub-insights"

  tags = {
    Project = "TITAN"
  }
}