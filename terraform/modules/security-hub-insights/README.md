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

----------------------------------------

# TITAN Executive Security Insights

## Purpose

Provide executive-level visibility into security risk,
compliance posture, and active remediation priorities.

## Insights

### TITAN Critical Findings

Business Value:
Identifies the highest-risk findings requiring immediate action.

Executive Question Answered:
"What can hurt us today?"

---

### TITAN Failed Compliance Findings

Business Value:
Highlights control failures impacting compliance posture.

Executive Question Answered:
"Where are we failing policy requirements?"

---

### TITAN IAM Risk Findings

Business Value:
Identifies excessive permissions and identity exposure.

Executive Question Answered:
"Who has more access than they should?"

---

### TITAN S3 Exposure Findings

Business Value:
Highlights exposed storage resources.

Executive Question Answered:
"Is company data publicly exposed?"

---

### TITAN New Active Findings

Business Value:
Tracks incoming unresolved risk.

Executive Question Answered:
"What is the current workload facing security operations?"