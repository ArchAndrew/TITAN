# TITAN Governance Control Mapping

## Purpose

This document maps TITAN platform capabilities to selected NIST 800-53 Rev. 5 control families.

TITAN is designed to embed governance, security, auditability, and risk management directly into self-service platform workflows.

---

## Control Mapping Summary

| Control Family | Focus Area | TITAN Capability |
|---|---|---|
| AC | Access Control | Access Factory, IAM, RBAC, Permission Boundaries |
| AU | Audit & Accountability | CloudTrail, workflow logs, approval records |
| CM | Configuration Management | Terraform, Terragrunt, GitHub Actions |
| IA | Identification & Authentication | IAM Identity Center, OIDC, MFA |
| IR | Incident Response | Alerting, Security Hub, GuardDuty, runbooks |
| RA | Risk Assessment | Security scans, AI risk register, governance checks |
| SC | System & Communications Protection | KMS, TLS, network policies, private subnets |
| SI | System & Information Integrity | Vulnerability scanning, drift detection, policy checks | 

---

# AC - Access Control

## AC-2: Account Management

### TITAN Implementation

- IAM Identity Center for centralized access
- Access Factory for standardized access requests
- Time-bound access grants
- Approval workflows
- Access expiration tracking

### Evidence Generated

- Access request record
- Approval record
- IAM role mapping
- Expiration record

---

## AC-3: Access Enforcement

### TITAN Implementation

- IAM policies
- Permission boundaries
- Kubernetes RBAC
- Service Control Policies
- Secrets Manager resource policies

### Evidence Generated

- IAM policy documents
- SCP attachments
- RBAC manifests
- Secrets access mappings

---

## AC-6: Least Privilege

### TITAN Implementation

- Role-based access
- Permission boundaries
- Just-in-time access model
- Scoped service accounts
- Human approval for privileged access

### Evidence Generated

- Access review logs
- Role definitions
- Permission boundary records
- Approval history

---

# AU - Audit & Accountability

## AU-2: Event Logging

### TITAN Implementation

- CloudTrail
- CloudWatch Logs
- Step Functions execution history
- GitHub Actions logs
- Platform API request logs

### Evidence Generated

- API request logs
- Workflow execution records
- Deployment logs
- Approval logs

---

## AU-6: Audit Review, Analysis, and Reporting

### TITAN Implementation

- Grafana dashboards
- Security Hub findings
- GuardDuty findings
- Platform activity dashboards
- Compliance evidence reports

### Evidence Generated

- Dashboard screenshots
- Security findings
- Compliance reports
- Audit summaries

---

## AU-12: Audit Record Generation

### TITAN Implementation

- Workflow-generated audit records
- Platform API logging
- Terraform plan archives
- Deployment records
- AI-assisted action records

### Evidence Generated

- Terraform plans
- Approval records
- AI prompt/response records
- Deployment history

---

# CM - Configuration Management

## CM-2: Baseline Configuration

### TITAN Implementation

- Standard Terraform modules
- Terragrunt live environment structure
- Approved platform patterns
- Standard Kubernetes namespace templates

### Evidence Generated

- Terraform module source
- Terragrunt environment files
- Kubernetes manifests
- Baseline configuration documentation

---

## CM-3: Configuration Change Control

### TITAN Implementation

- GitHub pull requests
- Branch protection
- Terraform plan review
- Human approval before production changes
- CI/CD validation gates

### Evidence Generated

- Pull request history
- Terraform plans
- Approval records
- Pipeline execution logs

---

## CM-6: Configuration Settings

### TITAN Implementation

- Policy-as-code checks
- Terraform variable standards
- Kubernetes resource quotas
- Network policy templates
- Security baseline modules

### Evidence Generated

- Policy scan results
- Configuration validation logs
- Module defaults
- Environment configuration files

---

# IA - Identification and Authentication

## IA-2: Identification and Authentication

### TITAN Implementation

- IAM Identity Center
- Federated access
- GitHub OIDC
- MFA enforcement
- Kubernetes service accounts

### Evidence Generated

- Identity provider configuration
- IAM role trust policies
- OIDC configuration
- MFA enforcement records

---

## IA-5: Authenticator Management

### TITAN Implementation

- Secrets Manager
- KMS encryption
- Secret rotation metadata
- Controlled access to secrets
- Audit logging for secret access

### Evidence Generated

- Secret metadata
- Rotation configuration
- IAM access mapping
- KMS key association

---

# IR - Incident Response

## IR-4: Incident Handling

### TITAN Implementation

- GuardDuty detection
- Security Hub aggregation
- EventBridge event routing
- Slack notifications
- Incident response runbooks

### Evidence Generated

- Finding records
- Notification logs
- Incident runbook references
- Response history

---

## IR-5: Incident Monitoring

### TITAN Implementation

- CloudWatch metrics
- Prometheus alerts
- Grafana dashboards
- Security Hub
- GuardDuty

### Evidence Generated

- Alert records
- Monitoring dashboards
- Security findings
- Incident timeline

---

# RA - Risk Assessment

## RA-3: Risk Assessment

### TITAN Implementation

- Risk register
- Data classification during environment requests
- AI risk register
- Security validation before provisioning
- Governance review checkpoints

### Evidence Generated

- Risk register entries
- Data classification records
- Approval history
- AI risk documentation

---

## RA-5: Vulnerability Monitoring and Scanning

### TITAN Implementation

- Trivy container scanning
- Checkov IaC scanning
- Semgrep code scanning
- Terraform validation
- GitHub Actions security pipelines

### Evidence Generated

- Scan results
- Pipeline logs
- Vulnerability reports
- Remediation records

---

# SC - System and Communications Protection

## SC-7: Boundary Protection

### TITAN Implementation

- VPC design
- Private subnets
- Security groups
- Network policies
- Ingress controls

### Evidence Generated

- VPC architecture
- Security group rules
- Network policy manifests
- Ingress configuration

---

## SC-12: Cryptographic Key Establishment and Management

### TITAN Implementation

- AWS KMS
- Key policies
- Secrets Manager encryption
- S3 encryption
- EKS secret encryption

### Evidence Generated

- KMS key configuration
- Key policy documents
- Encryption validation records
- Secrets encryption mappings

---

## SC-13: Cryptographic Protection

### TITAN Implementation

- TLS enforcement
- KMS encryption
- Encrypted storage
- Encrypted secrets
- Secure communication patterns

### Evidence Generated

- TLS configuration
- KMS records
- Encryption settings
- Security scan results

---

# SI - System and Information Integrity

## SI-2: Flaw Remediation

### TITAN Implementation

- CI/CD security scans
- Container vulnerability scanning
- IaC scanning
- Dependency checks
- Remediation tracking

### Evidence Generated

- Vulnerability scan reports
- Pipeline results
- Remediation records
- Pull request history

---

## SI-4: System Monitoring

### TITAN Implementation

- Prometheus
- Grafana
- Loki
- CloudWatch
- Security Hub
- GuardDuty

### Evidence Generated

- Monitoring dashboards
- Log records
- Alert records
- Security findings

---

# AI Governance Alignment

Although NIST AI RMF is documented separately, TITAN applies AI governance principles across platform operations.

## AI Guardrails

AI may:

- Interpret natural language requests
- Generate structured request payloads
- Summarize incidents
- Explain Terraform plans
- Generate documentation
- Recommend remediation

AI may not directly:

- Deploy production infrastructure
- Modify SCPs
- Grant privileged access
- Disable security controls
- Delete resources

## Evidence Generated

- AI prompt record
- AI response record
- Human approval record
- Final action record
- Outcome summary

---

# Evidence Collection Strategy

TITAN stores compliance evidence under:

```text
compliance/evidence/
├── screenshots/
├── terraform-plans/
├── pipeline-logs/
├── security-scans/
└── approval-records/