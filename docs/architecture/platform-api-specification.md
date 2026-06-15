# TITAN Platform API Specification

## Purpose

The TITAN Platform API serves as the primary interface between users, engineering teams, automation systems, AI assistants, and platform workflows.

The API does not directly provision infrastructure.

Instead, the API validates requests and initiates governed workflow execution.

---

# Architecture Pattern

```text
User
  ↓
Platform API
  ↓
Validation
  ↓
Governance Checks
  ↓
Approval Workflow
  ↓
Step Functions
  ↓
Terraform / Kubernetes / AWS
  ↓
Evidence Generation
  ↓
Notification
```

---

# API Design Principles

- RESTful
- Workflow-driven
- Governance-first
- Audit-friendly
- Human approval for high-risk actions
- Idempotent where possible
- Evidence generation by default

---

# API Version

Current Version:

v1

Base URL:

/api/v1

-----------------------------------------------------

# Environment Factory

## Create Environment

POST /api/v1/environments

### Request

```json
{
  "environment_name": "payments-prod",
  "environment_type": "prod",
  "application_name": "payments",
  "business_owner": "finance",
  "technical_owner": "platform-team",
  "cost_center": "FIN-001",
  "data_classification": "confidential",
  "region": "us-east-1",
  "high_availability": true
}
```

### Workflow

1. Schema Validation
2. Governance Validation
3. Budget Validation
4. Approval Workflow
5. Environment Provisioning
6. Evidence Generation

### Response

```json
{
  "request_id": "ENV-12345",
  "status": "PENDING_APPROVAL"
}
```

----------------------------------------------------

# Namespace Factory

POST /api/v1/namespaces

### Request

```json
{
  "namespace": "payments",
  "environment": "prod",
  "team": "payments-team",
  "resource_tier": "standard"
}
```

### Response

```json
{
  "request_id": "NS-12345",
  "status": "PENDING"
}
```

-----------------------------------------------

# Access Factory

POST /api/v1/access

### Request

```json
{
  "user": "jdoe",
  "resource": "payments-prod",
  "access_level": "read-only",
  "justification": "production troubleshooting",
  "duration_hours": 8
}
```

### Response

```json
{
  "request_id": "ACC-12345",
  "status": "PENDING_APPROVAL"
}
```
---------------------------------------------------

# Secrets Factory

POST /api/v1/secrets

### Request

```json
{
  "secret_name": "payments-db-password",
  "environment": "prod",
  "application": "payments",
  "rotation_required": true
}
```

### Response

```json
{
  "request_id": "SEC-12345",
  "status": "PENDING"
}
```

-----------------------------------------------

# Deployment Factory

POST /api/v1/deployments

### Request

```json
{
  "application": "payments",
  "environment": "prod",
  "container_image": "payments:v1.0.0",
  "deployment_strategy": "rolling"
}
```

### Response

```json
{
  "request_id": "DEP-12345",
  "status": "PENDING"
}
```

-----------------------------------------------

# AI Operations

POST /api/v1/ai/operations

### Request

```json
{
  "prompt": "Create a new development environment for the payments team"
}
```

### Processing

AI may:

- Interpret request
- Generate workflow payload
- Explain Terraform plans
- Summarize incidents
- Recommend remediation

AI may not:

- Deploy infrastructure directly
- Grant privileged access
- Modify governance controls
- Disable security controls

### Response

```json
{
  "request_id": "AI-12345",
  "status": "AWAITING_HUMAN_REVIEW"
}
```

