# AWS Control Tower Integration Strategy

## Purpose

TITAN is designed as a Control Tower-compatible enterprise landing zone and internal developer platform.

The current implementation builds the underlying governance capabilities directly with Terraform and Terragrunt, while preserving a clear path to AWS Control Tower and Account Factory for Terraform adoption in a larger enterprise environment.

## Current TITAN Governance Capabilities

TITAN currently implements:

- AWS Organizations structure
- Organizational Units
- Service Control Policies
- IAM Identity Center / SSO design
- Centralized CloudTrail
- AWS Config governance
- Security Hub
- GuardDuty
- KMS-backed logging
- S3 log archive patterns
- Budget guardrails
- Tagging standards
- EKS platform governance
- OPA Gatekeeper policy enforcement

## Control Tower Mapping

| Control Tower Capability | TITAN Equivalent |
|---|---|
| Landing Zone | Terraform/Terragrunt multi-account foundation |
| Account Factory | Future self-service account vending workflow |
| Preventive controls | SCP modules |
| Detective controls | AWS Config, Security Hub, GuardDuty |
| Centralized logging | CloudTrail, S3 log archive, Loki |
| Identity governance | IAM Identity Center / SSO |
| Governed OUs | Terraform-managed OU structure |
| Account baselines | Terraform modules and future AFT customizations |

## Target Enterprise Architecture

In an enterprise deployment, TITAN would integrate with AWS Control Tower as follows:

1. AWS Control Tower establishes the governed landing zone.
2. AWS Organizations provides the OU and account structure.
3. Account Factory for Terraform provisions new workload accounts.
4. TITAN self-service workflows request new accounts, environments, or platform capabilities.
5. Terraform/Terragrunt applies account-level customizations.
6. ArgoCD deploys Kubernetes platform services.
7. Security Hub, GuardDuty, Config, CloudTrail, Prometheus, Loki, Tempo, and Mimir provide governance and observability.

## Design Decision

For TITAN v1, Control Tower is treated as an enterprise integration pattern rather than a hard runtime dependency.

This avoids unnecessary cost and operational complexity in the lab while demonstrating that the platform is designed to align with AWS enterprise governance patterns.

## Future Enhancement

TITAN v2 will introduce an Account Factory for Terraform workflow:

- Account request definition
- Approval workflow
- OU placement
- Baseline security controls
- Terraform customization pipeline
- Cost center and tag enforcement
- Integration with the TITAN platform API

----------------------------------------------------------------------

# AWS Control Tower Integration

TITAN is designed as a Control Tower-compatible internal developer platform.

## Enterprise Pattern

AWS Control Tower provides:
- Landing zone governance
- Account enrollment
- Organizational Unit baselines
- Preventive controls
- Detective controls
- Centralized logging
- Account Factory

TITAN extends this with:
- Terraform/Terragrunt customization
- GitOps platform deployment
- Observability
- Cost guardrails
- Policy-as-code
- Self-service workflows

## Control Tower Mapping

| Control Tower Capability | TITAN Implementation |
|---|---|
| Landing Zone | Terraform/Terragrunt AWS foundation |
| Account Factory | Future self-service account vending |
| Preventive Controls | SCP modules |
| Detective Controls | AWS Config, Security Hub, GuardDuty |
| Central Logging | CloudTrail, S3 logging, Loki |
| Identity | IAM Identity Center design |
| Baselines | Terraform account baseline modules |
| Governance Reporting | Grafana, Security Hub, Config |

## Future v2 Enhancement

TITAN will introduce Account Factory for Terraform integration to support:

- Account request workflow
- OU placement
- Baseline module execution
- Cost-center tagging
- Approval workflow
- Security account enrollment
- Observability registration