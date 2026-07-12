# TITAN Data Flow

## 1. Developer Change

A platform engineer or developer makes a change in the GitHub repository.

This may include:

- Terraform module updates
- Terragrunt environment changes
- Kubernetes manifests
- ArgoCD Application manifests
- OPA Gatekeeper policies
- DevSecOps pipeline updates

GitHub acts as the source of truth for platform state.

---

## 2. Pull Request Validation

When code is pushed, GitHub Actions validates the change before it is merged.

Validation includes:

- Gitleaks for secret detection
- Checkov for IaC security scanning
- Trivy for vulnerability scanning
- Conftest/OPA for policy validation
- Snyk for dependency security

This prevents unsafe infrastructure or application changes from entering the main branch.

---

## 3. Infrastructure Deployment

Approved infrastructure changes are applied through Terraform and Terragrunt.

Terragrunt manages environment-level orchestration across modules such as:

- VPC
- EKS
- IAM Identity Center
- CloudTrail
- AWS Config
- GuardDuty
- Security Hub
- KMS
- Budget Guardrails
- SCP Guardrails

This creates a repeatable multi-account AWS platform.

---

## 4. AWS Governance Enforcement

After infrastructure is deployed, AWS governance controls enforce guardrails across the environment.

These controls include:

- AWS Organizations
- Organizational Units
- Service Control Policies
- IAM Identity Center groups
- Budget controls
- AWS Config rules
- Conformance packs

The governance layer ensures cloud accounts remain aligned to security, compliance, and cost requirements.

---

## 5. Kubernetes Platform Deployment

Terraform provisions the Amazon EKS cluster, node groups, networking, IAM roles, and storage integrations.

The Kubernetes platform hosts services such as:

- ArgoCD
- OPA Gatekeeper
- Cilium
- Hubble
- Prometheus
- Grafana
- Loki
- Tempo
- Mimir

This creates the runtime layer for platform services and observability workloads.

---

## 6. GitOps Reconciliation

ArgoCD continuously monitors Git for Kubernetes desired state.

When changes are detected, ArgoCD syncs the manifests into the cluster.

This includes:

- Platform services
- Monitoring components
- Policy controllers
- Networking components
- Application manifests

ArgoCD provides drift detection and declarative delivery.

---

## 7. Policy Enforcement

OPA Gatekeeper evaluates Kubernetes resources against defined policy constraints.

Policies can enforce:

- Required labels
- Namespace standards
- Security restrictions
- Resource limits
- Deployment guardrails

This prevents non-compliant workloads from being admitted into the cluster.

---

## 8. Network Flow Visibility

Cilium provides Kubernetes networking and service connectivity.

Hubble captures live network flow telemetry across namespaces, services, and workloads.

This allows platform engineers to visualize:

- Pod-to-pod traffic
- Namespace communication
- DNS traffic
- API server communication
- Allowed and forwarded flows

This creates runtime visibility into east-west cluster traffic.

---

## 9. Observability Collection

Prometheus collects metrics from Kubernetes workloads and platform components.

Loki collects logs.

Tempo collects traces.

Mimir provides scalable metrics storage.

Grafana visualizes operational telemetry through dashboards.

This gives the platform team visibility into cluster health, resource utilization, and service behavior.

---

## 10. Security Monitoring

AWS security services continuously monitor the cloud environment.

Security signals are collected from:

- GuardDuty
- Security Hub
- AWS Config
- CloudTrail
- IAM Access Analyzer

These services detect misconfigurations, suspicious activity, compliance drift, and access risks.

---

## 11. Executive Visibility

Security, governance, cost, and observability data are surfaced through dashboards and documentation.

This gives technical and non-technical stakeholders visibility into:

- Platform health
- Security posture
- Compliance status
- AWS resource inventory
- Cost trends
- Operational readiness

---

## 12. Infrastructure Teardown

When testing is complete, Terragrunt destroys the infrastructure in dependency-aware order.

This validates that the platform is not only deployable, but also fully reproducible and removable.

The destroy process helps control cost and proves that infrastructure lifecycle management is automated end-to-end.