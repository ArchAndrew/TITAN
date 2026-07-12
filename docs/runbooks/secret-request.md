# Secret Request Runbook

## Purpose

This runbook describes how application teams request, provision, rotate, and audit secrets within TITAN.

Sensitive values are centrally managed using AWS Secrets Manager and encrypted using AWS KMS.

---

# Step 1 – Submit Secret Request

The requester provides:

- Application name
- Secret type
- Environment
- Rotation requirements
- Business justification

---

# Step 2 – Platform Review

Platform Engineering verifies:

- Need for secret
- Existing secret availability
- Access scope
- Least privilege

---

# Step 3 – Secret Creation

Platform Engineering:

1. Creates secret in AWS Secrets Manager.
2. Encrypts using KMS.
3. Applies naming convention.
4. Applies tags.
5. Records metadata.

---

# Step 4 – Access Configuration

IAM policies are updated so that only authorized workloads can retrieve the secret.

Human users do not receive direct access unless specifically approved.

---

# Step 5 – Deployment

Application configuration references the Secrets Manager ARN.

Secrets are never stored:

- GitHub
- Terraform variables
- Kubernetes manifests
- Source code

---

# Step 6 – Validation

Verify:

✓ Secret accessible

✓ IAM permissions correct

✓ KMS encryption enabled

✓ Application starts successfully

---

# Rotation

Secrets are rotated:

- On schedule
- Following compromise
- During credential replacement

Applications are validated after rotation.

---

# Logging

Secret access is monitored through:

- CloudTrail
- Secrets Manager
- Security Hub

---

# Success Criteria

✓ Secret encrypted

✓ Least privilege enforced

✓ Audit logging enabled

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