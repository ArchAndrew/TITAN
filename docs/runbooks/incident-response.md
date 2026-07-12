Step 1 – Detect the Incident

Incidents may originate from:

• AWS GuardDuty
• Security Hub
• CloudWatch Alarms
• Grafana Alerts
• GitHub Security Alerts

The Platform Engineer first validates whether the alert represents a true positive or a false positive.

---

Step 2 – Assess Severity

Determine:

• Business Impact
• Services Affected
• Number of AWS Accounts
• Customer Impact
• Compliance Impact

Assign:

P1
P2
P3
P4

according to the incident classification matrix.

---

Step 3 – Containment

Depending on the incident:

• Disable IAM credentials
• Quarantine EC2 instances
• Block Security Groups
• Apply SCP restrictions
• Scale workloads to zero
• Remove compromised Pods

Document every containment action.

...

Step 7 – Lessons Learned

Within five business days:

• Conduct RCA
• Update Terraform
• Update Guardrails
• Update Runbooks
• Update Threat Model
• Update ADRs

---

# Related Documents

- High-Level Architecture
- Data Flow
- Threat Model
- Trust Boundaries
- Security Control Mapping

---

# Roles and Responsibilities

| Role | Responsibility |
|------|----------------|
| Developer | Submit Request |
| Platform Engineer | Provision and Validate |
| Security Engineer | Review Security Controls |
| Cloud Operations | Monitor Platform |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | Initial Release | Initial enterprise runbook for TITAN |