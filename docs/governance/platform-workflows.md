# TITAN Platform Workflows

## Purpose

This document defines the core self-service workflows supported by TITAN.

TITAN is designed to reduce manual infrastructure requests by allowing engineering teams to consume governed platform capabilities through standardized, auditable, and policy-driven workflows.

---

## Workflow Principles

All TITAN workflows follow these principles:

- Self-service first
- Governance by default
- Human approval for high-risk actions
- Infrastructure as Code
- Least privilege access
- Full auditability
- Cost ownership through tagging
- Security validation before provisioning
- Observable outcomes

---

# 1. Environment Factory

## Purpose

Provision standardized cloud environments for application teams.

## Requestor

Developer, team lead, or platform engineer.

## Required Inputs

- Environment name
- Environment type: dev, staging, prod
- Application name
- Business owner
- Technical owner
- Cost center
- Data classification
- Required region
- High availability requirement

## Governance Checks

- Required tags present
- Budget guardrail assigned
- Approved AWS region
- Data classification reviewed
- SCP compatibility validated
- IAM boundaries applied

## Approval Model

- Dev: platform approval
- Staging: platform approval
- Prod: platform and security approval

## Provisioned Resources

- VPC
- Subnets
- Route tables
- Security groups
- CloudWatch logging
- KMS keys
- Baseline IAM roles
- Budget alerts
- Security monitoring

## Evidence Generated

- Terraform plan
- Approval record
- Resource inventory
- Cost center mapping
- Security control mapping

---

# 2. Namespace Factory

## Purpose

Provision Kubernetes namespaces for application teams on EKS.

## Required Inputs

- Namespace name
- Application name
- Environment
- Team owner
- Resource tier
- Network policy requirements
- Secrets access requirements

## Governance Checks

- Namespace naming standard
- RBAC policy validation
- Resource quota validation
- Network policy enforcement
- Image scanning requirement
- Logging and monitoring enabled

## Provisioned Resources

- Kubernetes namespace
- RBAC bindings
- Resource quotas
- Network policies
- Service account
- Monitoring labels
- Logging configuration

## Evidence Generated

- Namespace manifest
- RBAC mapping
- Resource quota record
- Approval record

---

# 3. Secrets Factory

## Purpose

Provide governed secrets creation and access workflows.

## Required Inputs

- Secret name
- Application name
- Environment
- Secret type
- Owning team
- Rotation requirement
- Accessing workload

## Governance Checks

- KMS encryption required
- Least privilege IAM policy
- Rotation policy validation
- Access approval required
- Audit logging enabled

## Provisioned Resources

- AWS Secrets Manager secret
- KMS key association
- IAM access policy
- Rotation metadata
- Audit trail

## Evidence Generated

- Secret creation record
- IAM access mapping
- Rotation policy record
- Approval history

---

# 4. Access Factory

## Purpose

Standardize access requests for cloud and platform resources.

## Required Inputs

- Requestor identity
- Target resource
- Access level
- Business justification
- Duration
- Approver
- Environment

## Governance Checks

- Least privilege validation
- Separation of duties check
- Privileged access review
- Time-bound access requirement
- MFA requirement
- Approval requirement

## Provisioned Resources

- IAM role assignment
- Permission boundary
- Temporary access grant
- Audit log record

## Evidence Generated

- Access approval record
- IAM policy mapping
- Expiration record
- Audit evidence

---

# 5. Deployment Factory

## Purpose

Standardize application deployment onboarding.

## Required Inputs

- Application name
- Repository URL
- Environment
- Container image
- Deployment strategy
- Required secrets
- Required observability
- Rollback requirement

## Governance Checks

- Repository branch protection
- CI/CD security scan
- Container image scan
- IaC scan
- Required approvals
- Observability enabled
- Rollback plan exists

## Provisioned Resources

- GitHub Actions workflow
- ECR repository
- Helm chart
- Kubernetes deployment
- Service
- Ingress
- Monitoring dashboard
- Alerting rules

## Evidence Generated

- Pipeline logs
- Scan results
- Deployment record
- Rollback record
- Approval record

---

# 6. AI-Assisted Operations Workflow

## Purpose

Allow AI to assist platform operations without giving AI direct authority over production changes.

## Allowed AI Actions

- Interpret natural language requests
- Generate structured request payloads
- Summarize incidents
- Recommend remediation
- Generate documentation
- Explain Terraform plans
- Summarize security findings

## Denied AI Actions

AI may not directly:

- Deploy production infrastructure
- Modify SCPs
- Grant privileged access
- Disable security controls
- Delete resources
- Change IAM admin policies

## Approval Requirement

All AI-generated infrastructure actions must be reviewed and approved by a human before execution.

## Evidence Generated

- AI prompt record
- AI response record
- Human approval record
- Final executed action
- Outcome summary

---

## Workflow Execution Pattern

```text
User Request
    ↓
Platform API
    ↓
Input Validation
    ↓
Governance Checks
    ↓
Approval Workflow
    ↓
Terraform / Kubernetes / AWS Execution
    ↓
Security Validation
    ↓
Observability Registration
    ↓
Evidence Generation
    ↓
Notification