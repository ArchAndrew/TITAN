# Security Control Mapping

## Overview

This document maps TITAN platform components to the security objectives they enforce.

---

| Platform Component | Security Objective |
|--------------------|--------------------|
| IAM Identity Center | Authentication |
| IAM Roles | Least Privilege |
| AWS Organizations | Central Governance |
| AWS Control Tower | Landing Zone Governance |
| Service Control Policies | Prevent Unauthorized AWS Actions |
| GitHub Branch Protection | Change Control |
| GitHub Actions | Automated Validation |
| Checkov | Infrastructure Security |
| Trivy | Vulnerability Management |
| Gitleaks | Secret Detection |
| Snyk | Dependency Security |
| Conftest | Policy-as-Code |
| AWS Config | Configuration Compliance |
| Config Conformance Packs | Continuous Compliance |
| GuardDuty | Threat Detection |
| Security Hub | Security Aggregation |
| IAM Access Analyzer | Permission Analysis |
| CloudTrail | Audit Logging |
| CloudWatch | Monitoring |
| Grafana | Operational Visibility |
| Prometheus | Metrics Collection |
| Loki | Centralized Logging |
| Tempo | Distributed Tracing |
| ArgoCD | GitOps Deployment |
| OPA Gatekeeper | Kubernetes Admission Control |
| Cilium | Network Segmentation |
| Hubble | Network Visibility |

---

## Security Principles

TITAN enforces security using multiple layers.

Authentication

- IAM Identity Center
- IAM Roles

Authorization

- IAM Policies
- SCPs
- Kubernetes RBAC

Governance

- Control Tower
- Organizations
- Config
- Conformance Packs

Detection

- GuardDuty
- Security Hub

Observability

- Grafana
- Prometheus
- Loki
- Tempo

Deployment Security

- GitHub Actions
- ArgoCD
- OPA Gatekeeper