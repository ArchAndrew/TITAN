# Rollback Procedure

## Purpose

This runbook describes how Platform Engineering restores the TITAN platform following a failed infrastructure or Kubernetes deployment.

Rollback procedures prioritize platform stability, security, and service availability.

---

# Step 1 – Detect Failed Deployment

Failures may originate from:

- GitHub Actions
- ArgoCD
- Terraform
- Kubernetes
- CloudWatch Alarms
- Security Hub

Platform Engineering validates whether rollback is required.

---

# Step 2 – Determine Rollback Scope

Identify:

- Infrastructure only
- Kubernetes only
- Hybrid deployment

Determine affected AWS accounts, namespaces, and services.

---

# Step 3 – Infrastructure Rollback

If Terraform deployment introduced the issue:

1. Identify last known good Git commit.
2. Revert infrastructure code.
3. Execute validation pipeline.
4. Run Terragrunt Apply.
5. Verify successful provisioning.

Infrastructure should return to the previous desired state.

---

# Step 4 – Kubernetes Rollback

If Kubernetes workloads are affected:

1. Revert Git commit.
2. Push changes to repository.
3. ArgoCD detects repository drift.
4. ArgoCD synchronizes cluster.
5. Previous deployment restored automatically.

---

# Step 5 – Validation

Verify:

✓ Pods healthy

✓ Services healthy

✓ Network Policies active

✓ OPA policies enforced

✓ Prometheus metrics available

✓ Grafana dashboards healthy

✓ Security Hub findings normal

---

# Step 6 – Incident Documentation

Document:

- Root Cause
- Rollback Time
- Services Impacted
- Corrective Actions
- Lessons Learned

---

# Emergency Rollback

If automated rollback fails:

Platform Engineering performs manual recovery using:

- Terraform
- kubectl
- ArgoCD
- AWS Console (break-glass only)

All manual actions must be documented.

---

# Success Criteria

✓ Platform restored

✓ Monitoring healthy

✓ Security controls active

✓ Incident closed

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