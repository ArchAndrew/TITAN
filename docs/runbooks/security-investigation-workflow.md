# TITAN Security Investigation Workflow

## Purpose

The TITAN Security Investigation Workflow provides automated triage, classification, routing, and notification of security findings originating from AWS Security Hub.

The objective is to reduce analyst response time by automatically:

- Receiving Security Hub findings
- Enriching finding metadata
- Assigning investigation priority
- Determining routing destinations
- Generating remediation guidance
- Delivering notifications to downstream systems

This workflow serves as the foundation for future integrations with:

- Jira
- Slack
- ServiceNow
- PagerDuty
- Security Operations platforms

---

## Architecture

### Components

| Component | Purpose |
|------------|-----------|
| AWS Security Hub | Source of security findings |
| Security Hub Custom Action | Analyst-triggered investigation action |
| Amazon EventBridge | Event routing and orchestration |
| TITAN Investigation Lambda | Investigation and enrichment engine |
| Amazon SNS | Notification distribution |
| Email Subscription | Human notification endpoint |
| CloudWatch Logs | Audit trail and troubleshooting |

---

### High-Level Architecture

```text
Security Hub Finding
        │
        ▼
Security Hub Custom Action
(TITANInvestigate)
        │
        ▼
Amazon EventBridge
        │
        ▼
TITAN Investigation Lambda
        │
        ├──────── Classification
        ├──────── Priority Assignment
        ├──────── Routing Decision
        └──────── Remediation Guidance
        │
        ▼
Amazon SNS
        │
        ▼
Email Notification

-----------------------------------------------------

Absolutely. Based on what you've actually built and validated tonight, I'd make this document read like something an enterprise security engineering team would publish internally.

# security-investigation-workflow.md

````markdown
# TITAN Security Investigation Workflow

## Purpose

The TITAN Security Investigation Workflow provides automated triage, classification, routing, and notification of security findings originating from AWS Security Hub.

The objective is to reduce analyst response time by automatically:

- Receiving Security Hub findings
- Enriching finding metadata
- Assigning investigation priority
- Determining routing destinations
- Generating remediation guidance
- Delivering notifications to downstream systems

This workflow serves as the foundation for future integrations with:

- Jira
- Slack
- ServiceNow
- PagerDuty
- Security Operations platforms

---

## Architecture

### Components

| Component | Purpose |
|------------|-----------|
| AWS Security Hub | Source of security findings |
| Security Hub Custom Action | Analyst-triggered investigation action |
| Amazon EventBridge | Event routing and orchestration |
| TITAN Investigation Lambda | Investigation and enrichment engine |
| Amazon SNS | Notification distribution |
| Email Subscription | Human notification endpoint |
| CloudWatch Logs | Audit trail and troubleshooting |

---

### High-Level Architecture

```text
Security Hub Finding
        │
        ▼
Security Hub Custom Action
(TITANInvestigate)
        │
        ▼
Amazon EventBridge
        │
        ▼
TITAN Investigation Lambda
        │
        ├──────── Classification
        ├──────── Priority Assignment
        ├──────── Routing Decision
        └──────── Remediation Guidance
        │
        ▼
Amazon SNS
        │
        ▼
Email Notification
````

---

## Event Flow

### Step 1 - Finding Generated

Security Hub generates or receives a security finding.

Example:

```text
IAM User Has AdministratorAccess
Severity: HIGH
Compliance Status: FAILED
Workflow Status: NEW
```

---

### Step 2 - Custom Action Invoked

Security analyst selects:

```text
TITANInvestigate
```

from the Security Hub custom actions menu.

---

### Step 3 - EventBridge Routing

EventBridge captures the custom action event and forwards it to the TITAN Investigation Lambda.

Event Rule:

```text
titan-securityhub-custom-actions
```

---

### Step 4 - Investigation Processing

The Lambda function performs:

#### Finding Normalization

Extracts:

* Finding ID
* Severity
* Resource Information
* Account ID
* Region
* Compliance Status

#### Priority Assignment

Example mapping:

| Severity | Priority |
| -------- | -------- |
| CRITICAL | P1       |
| HIGH     | P2       |
| MEDIUM   | P3       |
| LOW      | P4       |

---

### Step 5 - Routing Decision

Current routing:

```text
Jira/Slack
```

Future integrations:

* Jira Issue Creation
* Slack Notifications
* ServiceNow Incident Creation
* PagerDuty Escalation

---

### Step 6 - Notification Publication

Investigation results are published to:

```text
SNS Topic:
titan-security-alerts
```

---

### Step 7 - Email Delivery

SNS distributes the investigation summary to subscribed recipients.

Example Subject:

```text
TITAN Security Finding Routed
```

---

## Test Procedure

### Verify EventBridge Target

```bash
aws events list-targets-by-rule \
--rule titan-securityhub-custom-actions
```

Expected:

```text
titan-securityhub-investigator
```

---

### Verify Lambda Configuration

```bash
aws lambda get-function-configuration \
--function-name titan-securityhub-investigator
```

Expected:

```text
SNS_TOPIC_ARN
```

environment variable present.

---

### Invoke Test Event

```bash
MSYS_NO_PATHCONV=1 aws lambda invoke \
--function-name titan-securityhub-investigator \
--payload fileb://tests/test-events/securityhub-custom-action.json \
tests/test-events/response.json
```

Expected:

```json
{
  "statusCode": 200
}
```

---

### Verify Lambda Logs

Navigate:

```text
CloudWatch
→ Log Groups
→ /aws/lambda/titan-securityhub-investigator
```

Expected log entries:

```text
TITAN Security Hub investigation event received
```

```text
TITAN investigation routing summary
```

```text
Published TITAN security notification to SNS
```

---

### Verify SNS Topic

```bash
aws sns get-topic-attributes \
--topic-arn arn:aws:sns:us-east-1:<account-id>:titan-security-alerts
```

Expected:

```text
Topic exists
```

---

### Verify Email Delivery

Confirm receipt of:

```text
TITAN Security Finding Routed
```

notification email.

---

## Expected Output

Example investigation summary:

```json
{
  "platform": "TITAN",
  "workflow": "securityhub-investigation-routing",
  "finding_count": 1,
  "priority": "P2",
  "route": "Jira/Slack",
  "recommended_action":
    "Prioritized remediation required. Assign ownership and track to closure."
}
```

---

### Example Finding

```json
{
  "finding_id": "finding-001",
  "severity": "HIGH",
  "compliance_status": "FAILED",
  "workflow_status": "NEW",
  "record_state": "ACTIVE"
}
```

---

## Troubleshooting

### SNS Email Not Received

Verify:

```bash
aws sns list-subscriptions-by-topic \
--topic-arn <topic-arn>
```

Check:

```text
PendingConfirmation = false
```

---

### Lambda Not Triggering

Verify EventBridge target:

```bash
aws events list-targets-by-rule \
--rule titan-securityhub-custom-actions
```

Confirm Lambda target exists.

---

### Lambda Permission Issues

Verify:

```text
aws_lambda_permission.allow_eventbridge
```

exists in Terraform state.

---

### No CloudWatch Logs

Verify:

```text
/aws/lambda/titan-securityhub-investigator
```

log group exists.

Verify Lambda execution role contains:

```text
logs:CreateLogGroup
logs:CreateLogStream
logs:PutLogEvents
```

---

### SNS Publish Failures

Verify Lambda IAM role contains:

```text
sns:Publish
```

against:

```text
arn:aws:sns:us-east-1:<account-id>:titan-security-alerts
```

---

### Test Event File Not Found

Run from repository root:

```bash
cd /d/Titan/titan-enterprise-self-service-platform
```

Invoke using:

```bash
fileb://tests/test-events/securityhub-custom-action.json
```

---

## Evidence

Validation evidence is stored under:

```text
compliance/evidence/
├── screenshots/
├── terraform-plans/
├── pipeline-logs/
└── approval-records/
```

Artifacts include:

* Terraform Apply Output
* Lambda Configuration
* EventBridge Rule
* CloudWatch Logs
* SNS Topic
* SNS Subscription
* Email Notification
* Test Event Results

---

## Future Enhancements

Planned integrations:

* Jira Issue Creation
* Slack Channel Routing
* ServiceNow Incident Creation
* PagerDuty Escalation
* AI-Assisted Investigation Summaries
* Executive Security Dashboard
* Automated Remediation Workflows

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
