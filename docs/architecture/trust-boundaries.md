# Trust Boundaries

TITAN is designed around clearly separated trust zones across source control, CI/CD, cloud governance, Kubernetes runtime, observability, and security monitoring.

## 1. Developer to GitHub Boundary

Developers submit infrastructure or platform changes through GitHub pull requests.

**Crosses boundary:** code, Terraform/Terragrunt changes, Kubernetes manifests, policy files.

**Authentication:** GitHub identity, MFA recommended.

**Authorization:** repository permissions, branch protection, code review, pull request approval.

**Logging/Monitoring:** GitHub audit history, pull request history, GitHub Actions logs.

## 2. GitHub to CI/CD Boundary

GitHub Actions validates every proposed change before merge.

**Crosses boundary:** committed code, IaC, Kubernetes manifests, secrets patterns, dependency files.

**Authentication:** GitHub Actions runner identity.

**Authorization:** workflow permissions, repository-scoped tokens, least-privilege pipeline access.

**Logging/Monitoring:** workflow run logs, failed security gates, scan output artifacts.

Validated controls include:

- Gitleaks for secret detection
- Checkov for IaC security
- Trivy for vulnerability scanning
- Conftest/OPA for policy validation
- Snyk for dependency security

## 3. CI/CD to AWS Boundary

Approved workflows provision AWS infrastructure using Terraform and Terragrunt.

**Crosses boundary:** Terraform plans, state operations, AWS API calls, resource definitions.

**Authentication:** AWS IAM roles and provider credentials.

**Authorization:** IAM permissions, SCP guardrails, permission boundaries, least-privilege role design.

**Logging/Monitoring:** CloudTrail, AWS Config, Security Hub, GuardDuty, Terraform state history.

## 4. AWS Organization Boundary

AWS Organizations separates governance, security, platform, shared services, and workload accounts.

**Crosses boundary:** account provisioning, SCP inheritance, centralized logging, security findings.

**Authentication:** IAM Identity Center and AWS account access roles.

**Authorization:** organizational units, SCPs, permission sets, delegated administration.

**Logging/Monitoring:** CloudTrail, Config, Security Hub, GuardDuty, Access Analyzer.

## 5. Kubernetes Cluster Boundary

EKS hosts platform services and GitOps-managed workloads.

**Crosses boundary:** Kubernetes manifests, container images, service accounts, network traffic.

**Authentication:** Kubernetes API authentication through AWS IAM and cluster identity.

**Authorization:** Kubernetes RBAC, service accounts, OPA Gatekeeper policies, namespace controls.

**Logging/Monitoring:** Kubernetes events, Prometheus metrics, Grafana dashboards, Loki logs.

## 6. GitOps Runtime Boundary

ArgoCD continuously reconciles desired state from GitHub into the Kubernetes cluster.

**Crosses boundary:** application manifests, Helm values, namespace resources, workload definitions.

**Authentication:** ArgoCD authentication and repository access credentials.

**Authorization:** ArgoCD projects, Kubernetes RBAC, namespace-scoped permissions.

**Logging/Monitoring:** ArgoCD sync status, application health, reconciliation history, audit events.

## 7. Policy Enforcement Boundary

OPA Gatekeeper enforces Kubernetes admission policies before resources are admitted.

**Crosses boundary:** Kubernetes admission requests.

**Authentication:** Kubernetes API server identity.

**Authorization:** constraint templates, constraints, admission control decisions.

**Logging/Monitoring:** Gatekeeper violations, denied resources, audit results, Kubernetes events.

## 8. Network Boundary

Cilium controls service networking and provides runtime visibility through Hubble.

**Crosses boundary:** pod-to-pod traffic, service-to-service traffic, DNS requests, API server communication.

**Authentication:** Kubernetes service identity and workload identity context.

**Authorization:** Cilium network policies, namespace segmentation, service-level controls.

**Logging/Monitoring:** Hubble flow visibility, forwarded/dropped traffic, L7 flow context, service maps.

## 9. Observability Boundary

Prometheus, Grafana, Loki, Mimir, Tempo, Promtail, and OpenTelemetry collect platform telemetry.

**Crosses boundary:** metrics, logs, traces, Kubernetes events, service health data.

**Authentication:** service accounts, internal Kubernetes service access.

**Authorization:** namespace permissions, service discovery permissions, dashboard access controls.

**Logging/Monitoring:** Grafana dashboards, Prometheus targets, Loki log streams, Tempo traces, Mimir metrics storage.

## 10. Security Monitoring Boundary

AWS security services monitor cloud posture, runtime events, access patterns, and compliance signals.

**Crosses boundary:** CloudTrail events, Config evaluations, GuardDuty findings, Security Hub findings, Access Analyzer results.

**Authentication:** AWS service-linked roles.

**Authorization:** AWS managed service permissions, delegated security service roles, organization-level integrations.

**Logging/Monitoring:** Security Hub dashboards, GuardDuty findings, AWS Config compliance results, CloudTrail event history, Access Analyzer findings.

## Summary

TITAN separates trust across each major layer:

```text
Developer
  ↓
GitHub
  ↓
GitHub Actions Security Gates
  ↓
Terraform / Terragrunt
  ↓
AWS Organizations / Control Tower / IAM Identity Center
  ↓
EKS
  ↓
ArgoCD
  ↓
OPA Gatekeeper
  ↓
Cilium + Hubble
  ↓
Observability + Security Monitoring