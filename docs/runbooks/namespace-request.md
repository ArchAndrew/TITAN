# Kubernetes Namespace Request Runbook

## Purpose

This runbook describes the standardized process for requesting, reviewing, provisioning, and validating Kubernetes namespaces within the TITAN Enterprise Self-Service Platform.

Namespaces provide logical isolation between applications, environments, and teams while allowing Platform Engineering to enforce governance, security policies, resource quotas, and observability standards.

---

# Scope

This process applies to:

- Development teams
- DevSecOps engineers
- Platform Engineering
- Cloud Operations

---

# Prerequisites

Before requesting a namespace, ensure:

- The application has a documented business owner.
- A GitHub repository exists.
- The application has been approved for deployment.
- IAM Identity Center access has been granted.
- Required cloud accounts have been assigned.

---

# Step 1 – Submit Namespace Request

The application owner submits a request including:

- Application name
- Environment (Dev/Test/Prod)
- Team name
- Business owner
- Estimated CPU and Memory
- Expected storage requirements
- Required ingress endpoints
- External service dependencies

Platform Engineering reviews the request to verify that all required information has been provided.

---

# Step 2 – Architecture Review

Platform Engineering evaluates the request.

Items reviewed include:

- Namespace naming convention
- Resource sizing
- Multi-tenancy considerations
- Existing cluster capacity
- Security requirements
- Compliance requirements

If additional information is required, the request is returned to the application owner.

---

# Step 3 – Create Namespace

Once approved, Platform Engineering provisions:

- Kubernetes Namespace
- ResourceQuota
- LimitRange
- ServiceAccount
- RBAC Roles
- RoleBindings

This ensures the namespace follows organizational standards before workloads are deployed.

---

# Step 4 – Apply Platform Security Controls

The namespace automatically inherits platform guardrails.

These include:

- OPA Gatekeeper admission policies
- Cilium Network Policies
- Kubernetes Pod Security Standards
- Image registry restrictions
- Namespace labels
- Required annotations

Workloads violating organizational policy are rejected during admission.

---

# Step 5 – Configure Observability

Monitoring components are automatically enabled.

This includes:

- Prometheus metrics scraping
- Grafana dashboards
- Loki log aggregation
- Tempo distributed tracing
- Hubble network visibility

The namespace is verified to ensure telemetry is flowing correctly.

---

# Step 6 – Deploy Application

Developers deploy workloads using GitOps.

Deployment flow:

1. Commit changes to GitHub.
2. GitHub Actions performs validation.
3. Security scans execute.
4. Merge Request is approved.
5. ArgoCD synchronizes the cluster.
6. Kubernetes schedules workloads.

---

# Step 7 – Validation

Platform Engineering validates:

✓ Pods Running

✓ Resource Limits Applied

✓ Network Policies Enforced

✓ Metrics Available

✓ Logs Available

✓ Traces Available

✓ OPA Policies Active

✓ Cilium Policies Active

---

# Step 8 – Close Request

Once validation succeeds:

- Request is marked complete.
- Documentation is updated.
- Application owner is notified.
- Namespace enters normal operational support.

---

# Rollback

If provisioning fails:

1. Delete the namespace.
2. Remove RBAC bindings.
3. Remove GitOps application.
4. Remove monitoring configuration.
5. Document root cause.
6. Re-submit after remediation.

---

# Evidence

Platform Engineers should capture:

- kubectl get ns
- kubectl get resourcequota
- kubectl get networkpolicy
- ArgoCD Application status
- Grafana Dashboard
- Hubble Flow visualization

These artifacts serve as implementation evidence during operational reviews.

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