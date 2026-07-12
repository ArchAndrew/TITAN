# TITAN Platform Scripts

## Purpose

The scripts in this directory provide operational utilities for managing the TITAN Enterprise Internal Developer Platform during development and testing.

Infrastructure provisioning within TITAN is performed through Terraform, Terragrunt, GitHub Actions, and GitOps workflows. These scripts are intentionally limited to operational tasks that are frequently executed by platform engineers.

---

# cluster-up.sh

## Purpose

Starts the Kubernetes-based platform services required for the TITAN development environment.

This script is intended to simplify local platform startup by bringing the Kubernetes platform into a known operational state before testing or validating infrastructure changes.

Typical components include:

- Amazon EKS worker nodes
- ArgoCD
- OPA Gatekeeper
- Cilium
- Hubble
- Prometheus
- Grafana
- Loki

## When to use

Execute before:

- Infrastructure validation
- GitOps testing
- Platform demonstrations
- Security testing
- Observability validation

---

# cluster-down.sh

## Purpose

Gracefully scales down Kubernetes workloads when the development environment is no longer required.

The primary objectives are:

- Reduce AWS infrastructure costs
- Prevent unnecessary compute utilization
- Preserve infrastructure state while stopping workloads
- Support efficient development cycles

Rather than destroying infrastructure, this script scales platform components to zero replicas where appropriate, allowing the environment to be restored quickly using `cluster-up.sh`.

## When to use

Execute after:

- Development sessions
- Platform demonstrations
- Testing activities
- Validation exercises



