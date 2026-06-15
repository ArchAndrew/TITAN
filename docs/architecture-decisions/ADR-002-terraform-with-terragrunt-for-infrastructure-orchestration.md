# ADR-002: Use Terraform With Terragrunt for Infrastructure Orchestration

## Status

Accepted

---

## Date

2026-06-13

---

## Context

TITAN is being designed as an enterprise self-service platform that provisions and governs cloud infrastructure across multiple environments.

The platform will ultimately support:

* Development environments
* Staging environments
* Production environments
* Platform services
* Kubernetes infrastructure
* Governance services
* Security services
* Observability services

As the number of infrastructure components grows, maintaining separate Terraform configurations for each environment introduces significant duplication and operational overhead.

The project requires a solution that supports:

* Reusable infrastructure modules
* Environment-specific configuration
* Consistent remote state management
* Dependency orchestration
* Multi-account scalability
* Governance-first deployment patterns

---

## Problem Statement

How should TITAN manage infrastructure deployments across multiple environments while minimizing duplication, maintaining consistency, and supporting future platform growth?

---

## Alternatives Considered

### Alternative 1: Terraform Only

Description:

Use native Terraform for all module deployment and environment management.

Advantages:

* Simpler toolchain
* No additional abstraction layer
* Broad industry adoption

Disadvantages:

* Repeated backend configuration
* Repeated provider configuration
* Environment duplication
* Increased maintenance effort
* Complex dependency management as platform grows

Decision:

Rejected.

---

### Alternative 2: CloudFormation

Description:

Use AWS CloudFormation for infrastructure provisioning.

Advantages:

* Native AWS service
* Tight AWS integration

Disadvantages:

* AWS-only approach
* Less portable
* Reduced flexibility for future multi-cloud expansion
* Smaller ecosystem compared to Terraform

Decision:

Rejected.

---

### Alternative 3: Terraform With Terragrunt

Description:

Use Terraform as the Infrastructure as Code engine and Terragrunt as the orchestration and environment management layer.

Advantages:

* DRY infrastructure configuration
* Centralized remote state configuration
* Centralized provider configuration
* Environment inheritance
* Dependency management
* Better support for multi-account architectures
* Cleaner separation between reusable modules and deployed environments
* Aligns with enterprise-scale platform engineering practices

Decision:

Accepted.

---

## Decision

TITAN will use:

* Terraform for infrastructure provisioning
* Terragrunt for orchestration and environment management

Terraform modules will reside within:

terraform/modules/

Terragrunt environment configurations will reside within:

live/dev/

live/staging/

live/prod/

This structure separates reusable infrastructure code from deployed infrastructure instances.

---

## Rationale

The primary goal of TITAN is not merely infrastructure provisioning.

The goal is platform engineering at scale.

As the platform expands to include:

* AWS Organizations
* Control Tower
* SCP Guardrails
* EKS
* Platform APIs
* Observability
* Security Services

the operational overhead of managing duplicated Terraform configurations becomes increasingly difficult.

Terragrunt provides a lightweight orchestration layer that allows TITAN to scale while maintaining consistency and reducing configuration drift.

---

## Consequences

### Positive Consequences

* Reduced code duplication
* Consistent environment configuration
* Easier environment promotion
* Cleaner multi-account support
* Improved module reusability
* Better operational scalability

### Negative Consequences

* Additional tooling dependency
* Slightly steeper learning curve
* Additional abstraction layer for troubleshooting

---

## Architecture Principles Supported

* Infrastructure as Code
* Governance First
* Reusability
* Scalability
* Automation Over Manual Operations
* Consistency Across Environments

---

## Success Criteria

This decision will be considered successful if:

* Infrastructure modules remain reusable
* Environment configuration remains centralized
* Multi-environment deployments are simplified
* Platform growth does not require significant Terraform duplication
* Governance controls remain consistent across environments

---

## Related Documents

* ADR-001 Build TITAN as an Enterprise AI-Governed Self-Service Platform
* NIST 800-53 Control Mapping
* TITAN Project Journal


---

