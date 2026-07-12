# TITAN Risk Register

## Overview

This document tracks operational, security, and architectural risks associated with the TITAN Enterprise Self-Service Platform.

---

| ID | Risk | Impact | Likelihood | Mitigation | Owner |
|----|------|----------|------------|------------|-------|
| R-001 | Unauthorized infrastructure deployment | High | Low | GitHub Actions, Checkov, Conftest, Branch Protection | Platform Engineering |
| R-002 | Privilege escalation | High | Low | IAM Identity Center, IAM Roles, SCPs | Platform Engineering |
| R-003 | Infrastructure drift | Medium | Medium | AWS Config, Conformance Packs | Cloud Operations |
| R-004 | Kubernetes policy violations | High | Low | OPA Gatekeeper | Platform Engineering |
| R-005 | Container vulnerabilities | High | Medium | Trivy, Snyk | DevSecOps |
| R-006 | Secret leakage | Critical | Low | Gitleaks | DevSecOps |
| R-007 | Lateral movement inside cluster | High | Low | Cilium Network Policies | Platform Engineering |
| R-008 | Runtime compromise | High | Medium | GuardDuty, Security Hub | Security Operations |
| R-009 | Cloud cost overruns | Medium | Medium | AWS Budgets, Cost Explorer | Cloud Operations |
| R-010 | Loss of audit evidence | High | Low | CloudTrail, CloudWatch Logs | Security |

---

## Risk Review Process

Platform Engineering reviews the risk register quarterly or whenever major architectural changes occur.

New risks are evaluated based on:

- Business impact
- Technical impact
- Likelihood
- Existing controls
- Residual risk

Risks with High or Critical impact require documented mitigation before production deployment.