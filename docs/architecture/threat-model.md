# Threat Model

## Overview

TITAN Enterprise Self-Service Platform follows a defense-in-depth architecture where security controls are layered throughout the entire software delivery lifecycle.

Rather than relying on a single security service, TITAN applies preventative, detective, governance, and monitoring controls across source control, CI/CD, cloud infrastructure, Kubernetes, networking, and runtime operations.

The objective is to reduce the likelihood and impact of common cloud and Kubernetes attack scenarios while maintaining developer productivity through automated security controls.

---

# Threat 1 – Unauthorized Infrastructure Changes

## Threat

A developer or attacker attempts to provision unauthorized AWS resources, modify existing infrastructure, or bypass organizational governance.

## Potential Impact

- Privilege escalation
- Unauthorized infrastructure
- Increased cloud cost
- Compliance violations

## TITAN Mitigations

### GitHub Branch Protection

Infrastructure changes must be submitted through Pull Requests.

This prevents direct modification of the production branch.

---

### GitHub Security Pipeline

Every Pull Request is automatically validated.

Implemented security gates include:

- Gitleaks
- Checkov
- Trivy
- Snyk
- Conftest (OPA)

Any failed scan blocks the merge before infrastructure reaches AWS.

---

### IAM Identity Center

Administrators authenticate through centralized identity management.

Benefits:

- Centralized authentication
- Role-based access
- Least privilege
- Temporary credentials
- Simplified user lifecycle

---

### AWS Organizations

All accounts operate inside an AWS Organization.

Benefits:

- Organizational Units
- Central governance
- Shared security controls
- Centralized account management

---

### Service Control Policies (SCPs)

Even if IAM permissions are overly permissive, SCPs establish organization-wide guardrails.

Examples:

- Restrict unsupported AWS Regions
- Prevent disabling CloudTrail
- Prevent unauthorized IAM actions
- Restrict unsupported services

SCPs represent the final authorization layer before AWS executes an API request.

---

# Threat 2 – Infrastructure Misconfiguration

## Threat

Terraform provisions insecure cloud resources.

Examples include:

- Public S3 buckets
- Open Security Groups
- Disabled encryption
- Weak IAM policies

## Potential Impact

- Data exposure
- Compliance violations
- Cloud compromise

## TITAN Mitigations

### Checkov

Terraform is scanned before deployment.

Checks include:

- Encryption
- Network exposure
- IAM policy analysis
- Storage configuration
- Security group validation

---

### Conftest (OPA)

Custom organizational policies validate infrastructure against enterprise standards.

Examples:

- Required tags
- Approved AWS Regions
- Encryption requirements
- Naming conventions

Infrastructure violating policy is rejected before deployment.

---

### AWS Config

Continuously evaluates deployed resources.

Detects configuration drift after deployment.

---

### AWS Config Conformance Packs

Continuously validate infrastructure against security baselines.

This ensures compliance continues after deployment.

---

# Threat 3 – Credential Leakage

## Threat

Secrets or credentials are accidentally committed to GitHub.

Examples:

- AWS Access Keys
- API Keys
- Tokens
- Passwords

## Potential Impact

AWS account compromise.

## TITAN Mitigations

### Gitleaks

Scans every commit for secrets.

The CI pipeline fails immediately if credentials are detected.

Secrets never reach the protected branch.

---

# Threat 4 – Vulnerable Software Supply Chain

## Threat

Terraform providers, Kubernetes images, or dependencies contain known vulnerabilities.

## Potential Impact

- Remote Code Execution
- Privilege Escalation
- Software compromise

## TITAN Mitigations

### Trivy

Scans:

- Container images
- Filesystems
- Infrastructure as Code

Detects known CVEs before deployment.

---

### Snyk

Scans project dependencies for vulnerable libraries.

This reduces software supply-chain risk.

---

# Threat 5 – Privilege Escalation

## Threat

A user attempts to obtain permissions beyond their assigned role.

## Potential Impact

- Administrative compromise
- Organization takeover
- Unauthorized resource creation

## TITAN Mitigations

### IAM Identity Center

Users receive predefined permission sets.

Access is centrally managed.

---

### IAM Roles

Terraform provisions least-privilege service roles.

---

### SCP Guardrails

Organization-wide policies prevent dangerous API actions even if IAM permissions exist.

---

### IAM Access Analyzer

Detects excessive trust relationships and overly permissive resource policies.

---

# Threat 6 – Kubernetes Policy Violations

## Threat

Developers deploy workloads that violate organizational security standards.

Examples:

- Privileged containers
- HostPath mounts
- Missing labels
- Excessive capabilities

## Potential Impact

Container compromise.

## TITAN Mitigations

### OPA Gatekeeper

Admission controller validates workloads before Kubernetes accepts them.

Examples include:

- Required metadata
- Namespace restrictions
- Security policy enforcement
- Resource governance

Rejected workloads never enter the cluster.

---

# Threat 7 – Lateral Movement Inside Kubernetes

## Threat

A compromised workload attempts to communicate with unauthorized services.

## Potential Impact

- Service compromise
- Data theft
- Cluster-wide compromise

## TITAN Mitigations

### Cilium

Implements Kubernetes Network Policies.

Capabilities include:

- Pod isolation
- Namespace isolation
- Layer 3
- Layer 4
- Layer 7 filtering

Only approved communication paths are permitted.

---

### Hubble

Provides runtime visibility into:

- Pod communication
- Namespace communication
- DNS requests
- Policy decisions
- Dropped packets

This improves investigation and troubleshooting.

---

# Threat 8 – Malicious AWS Activity

## Threat

Suspicious activity occurs after deployment.

Examples include:

- Credential misuse
- Cryptocurrency mining
- Reconnaissance
- Unusual API behavior

## Potential Impact

AWS account compromise.

## TITAN Mitigations

### GuardDuty

Continuously analyzes AWS activity.

Detects:

- Suspicious API calls
- Credential abuse
- EC2 compromise
- Cryptocurrency mining
- Network reconnaissance

---

### Security Hub

Aggregates findings from:

- GuardDuty
- AWS Config
- IAM Access Analyzer
- Additional AWS services

Provides centralized security visibility.

---

# Threat 9 – Compliance Drift

## Threat

Infrastructure becomes non-compliant after deployment.

## Potential Impact

Audit failures.

## TITAN Mitigations

### AWS Config

Continuously evaluates resources.

---

### Conformance Packs

Evaluate compliance against organizational security baselines.

---

### Security Hub

Aggregates compliance findings into a single security dashboard.

---

# Threat 10 – Loss of Auditability

## Threat

Administrative actions cannot be reconstructed after an incident.

## Potential Impact

- Failed investigations
- Regulatory violations
- Limited forensic capability

## TITAN Mitigations

### CloudTrail

Records AWS API activity.

---

### CloudWatch

Captures platform metrics and operational telemetry.

---

### Grafana

Provides operational dashboards for infrastructure health.

---

### Prometheus

Collects Kubernetes metrics.

---

### Loki

Centralizes application and platform logs.

---

### Tempo

Captures distributed traces.

Together these services provide complete operational visibility across infrastructure and Kubernetes workloads.

---

# Defense-in-Depth Summary

TITAN applies multiple independent security layers.

| Layer | Controls |
|---------|----------|
| Identity | IAM Identity Center, IAM Roles |
| Governance | AWS Organizations, Control Tower, SCPs |
| Infrastructure | Terraform, Terragrunt |
| CI/CD | GitHub Actions, Gitleaks, Checkov, Trivy, Snyk, Conftest |
| Cloud Security | GuardDuty, Security Hub, AWS Config, IAM Access Analyzer |
| Kubernetes | ArgoCD, OPA Gatekeeper |
| Networking | Cilium, Hubble |
| Observability | Prometheus, Grafana, Loki, Tempo, Mimir |
| Audit | CloudTrail |
| Executive Visibility | CloudWatch Dashboards, Security Hub |

No single security control is trusted to protect the platform. Instead, security is enforced throughout the entire software delivery lifecycle, from developer commit to cloud governance, Kubernetes admission, runtime networking, continuous monitoring, and executive reporting.