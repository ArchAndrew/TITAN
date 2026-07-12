# Platform Onboarding Runbook

## Purpose

This runbook describes how new application teams onboard onto the TITAN Enterprise Self-Service Platform.

The objective is to provide a standardized, secure, and repeatable onboarding process that enables development teams to deploy cloud infrastructure while inheriting organizational governance, security controls, and observability.

---

# Step 1 – Initial Engagement

Platform Engineering meets with the application team to collect:

- Business requirements
- Application architecture
- Deployment environments
- Networking requirements
- Compliance requirements
- Estimated infrastructure size

---

# Step 2 – Repository Provisioning

Create:

- GitHub Repository
- Branch Protection Rules
- CODEOWNERS
- GitHub Actions
- Required Secrets
- Repository Permissions

Repository becomes the GitOps source of truth.

---

# Step 3 – Cloud Resource Preparation

Provision:

- AWS Account (if required)
- IAM Identity Center access
- IAM Roles
- Terraform State
- Budget Guardrails
- Logging Buckets

---

# Step 4 – Kubernetes Preparation

Provision:

- Namespace
- Resource Quotas
- Limit Ranges
- RBAC
- Network Policies
- ArgoCD Application

OPA Gatekeeper policies are inherited automatically.

---

# Step 5 – CI/CD Validation

Every Pull Request executes:

- terraform fmt
- terraform validate
- Checkov
- Trivy
- Gitleaks
- Conftest
- Snyk

Failures prevent deployment.

---

# Step 6 – Initial Deployment

Once validation succeeds:

1. Pull Request approved.
2. Changes merged into main.
3. GitHub Actions executes deployment.
4. Terraform/Terragrunt provisions AWS.
5. ArgoCD synchronizes Kubernetes.
6. Platform reaches desired state.

---

# Step 7 – Platform Validation

Platform Engineering validates:

✓ Infrastructure

✓ IAM

✓ Networking

✓ Monitoring

✓ Logging

✓ Security Hub

✓ GuardDuty

✓ ArgoCD

✓ Grafana

✓ Prometheus

---

# Step 8 – Production Readiness Review

Before production:

- Security review
- Cost review
- Architecture review
- Disaster recovery review
- Documentation review

Application is officially onboarded.

---

# Success Criteria

✓ GitOps operational

✓ Monitoring active

✓ Security controls enabled

✓ Developers productive

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