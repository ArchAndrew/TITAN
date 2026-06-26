# Journal Entry – Budget Guardrails Backend Conflict Resolution

## Date

2026-06-22

## Objective

Continue hardening TITAN platform configuration by removing hardcoded notification email addresses and transitioning to environment-variable driven configuration.

## Issue Encountered

While validating the `budget-guardrails` stack using Terragrunt, Terraform initialization failed with:

```text
Error: Duplicate "backend" configuration block
```

Initial investigation suggested a Terragrunt backend generation issue. The error persisted even after clearing `.terragrunt-cache`.

## Investigation

Validated generated Terragrunt cache files:

```bash
grep -R 'backend "s3"' .
```

Results revealed:

```text
.terragrunt-cache/.../backend.tf
.terragrunt-cache/.../versions.tf
```

Further inspection showed:

```hcl
terraform {
  backend "s3" {}
}
```

was still present inside:

```text
terraform/modules/budget-guardrails/versions.tf
```

while Terragrunt was simultaneously generating:

```hcl
terraform {
  backend "s3" {
    bucket = ...
    key    = ...
  }
}
```

inside the cache directory.

## Root Cause

The reusable Terraform module contained a legacy:

```hcl
backend "s3" {}
```

block.

Because TITAN uses Terragrunt-managed remote state generation, Terragrunt automatically injected a second backend configuration during runtime, resulting in duplicate backend definitions.

## Resolution

Removed:

```hcl
backend "s3" {}
```

from:

```text
terraform/modules/budget-guardrails/versions.tf
```

Retained backend management exclusively through Terragrunt root configuration.

Cleared cache:

```bash
rm -rf .terragrunt-cache
```

Reinitialized:

```bash
tgi
```

Validated:

```bash
tgp
```

Plan completed successfully.

## Additional Security Improvement

Removed hardcoded notification email addresses from repository configuration.

Implemented:

```hcl
notification_email = get_env(
  "TITAN_NOTIFICATION_EMAIL",
  "placeholder@example.com"
)
```

Configured local environment:

```bash
export TITAN_NOTIFICATION_EMAIL="andrew@strongtowersecurity.io"
```

Verified:

```bash
git grep "andrew@strongtowersecurity.io"
```

returned no repository matches.

## Outcome

* Eliminated duplicate backend configuration error.
* Standardized backend ownership under Terragrunt.
* Removed sensitive email configuration from source control.
* Improved portability between development, testing, and production environments.
* Successfully validated budget guardrails deployment plan.

## Lessons Learned

When using Terragrunt-generated remote state, reusable Terraform modules should never define their own backend blocks. Backend ownership should exist in exactly one location to prevent initialization conflicts and configuration drift.

---------------------------------------------------

2026-06-23
Security Hub Investigation Workflow Validation

Key lessons:

SNS email subscriptions require confirmation.
Terragrunt-generated backends conflict with module-defined backends.
Backend blocks belong in Terragrunt-managed infrastructure, not Terraform modules.
Sensitive values moved from hardcoded inputs to environment-variable driven configuration.
End-to-end validation completed from Security Hub event → Lambda → SNS → Email.

-----------------------------------------------------

# TITAN Observability Foundation

## Objective

Establish foundational observability capabilities for TITAN to support platform operations, security monitoring, and future Kubernetes workloads.

## Components Deployed

### CloudWatch Log Groups

- /titan/platform/events
- /titan/security/events
- /aws/eks/titan/control-plane

### CloudWatch Metric Filter

- titan-investigation-errors

### CloudWatch Alarm

- titan-investigation-errors

### CloudWatch Dashboard

- titan-observability

## Business Value

Provides centralized logging, monitoring, and alerting capabilities for platform services and security workflows.

This foundation supports future integrations including:

- EKS
- Prometheus
- Grafana
- Loki
- Step Functions
- Platform API

## Validation

Successfully deployed through Terragrunt.

Resources Added: 6

## Lessons Learned

Observability should be implemented before platform services and Kubernetes workloads so monitoring and alerting capabilities exist before operational complexity increases.

*********************************************************************

Journal Entry – EKS Platform Build: Multi-Stage Kubernetes Troubleshooting
Objective

Deploy Prometheus into the TITAN EKS platform using persistent storage backed by Amazon EBS.

Phase 1 – Private Networking

Decision

Rather than deploying into the AWS default VPC, I stopped and built a dedicated production-style VPC consisting of:

3 Public Subnets
3 Private Subnets
Internet Gateway
NAT Gateway
Route Tables
Terragrunt-managed deployment

Reason

Production EKS clusters should never rely on the default VPC.

Worker nodes were deployed into private subnets while maintaining outbound internet access through the NAT Gateway.

Phase 2 – EKS Deployment

Provisioned:

Dedicated VPC
EKS Cluster
Managed Node Group
kubectl connectivity
Terraform/Terragrunt automation

Validated:

Cluster Active
Worker node joined
kubectl operational
Phase 3 – Prometheus Deployment

Installed Prometheus using Helm.

Immediately observed:

Server Pending
Alertmanager Pending

Rather than reinstalling everything repeatedly, I began following the scheduling chain.

Root Cause #1 — Missing EBS CSI Driver

Pods reported:

unbound immediate PersistentVolumeClaims

Investigation showed:

EBS CSI addon unhealthy
Controller pods in CrashLoopBackOff

Logs indicated:

no EC2 IMDS role found

Root Cause:

The EBS CSI Controller had no IAM credentials.

Root Cause #2 — Missing IRSA

Verified:

OIDC provider
IAM Role
Trust Relationship

Created:

IRSA role
AmazonEBSCSIDriverPolicy attachment

Associated IRSA with the EBS CSI Controller.

Result:

EBS CSI Controller
Running

EBS CSI Node
Running

Addon
ACTIVE
Root Cause #3 — StorageClass

After fixing IRSA:

PVCs still remained Pending.

Inspection revealed:

StorageClass: <unset>

Created production StorageClass:

gp3
Provisioner:
ebs.csi.aws.com

Marked as default.

Reinstalled Prometheus.

Result:

Prometheus Server PVC immediately Bound.

Root Cause #4 — Scheduler Capacity

Alertmanager still remained Pending.

PVC events showed:

Waiting for first consumer

Pod events showed:

0/1 nodes available

Too many pods

The scheduler—not storage—was now the blocker.

Root Cause #5 — Node Capacity

Scaled the managed node group:

desired = 2
min = 1
max = 3

Terragrunt Apply:

1 additional node provisioned

Immediately afterward:

Alertmanager Running

PVC Bound

Prometheus Running

Entire monitoring stack healthy
Final Validation

✔ Dedicated VPC

✔ Private Subnets

✔ NAT Gateway

✔ EKS

✔ Managed Node Groups

✔ OIDC

✔ IRSA

✔ Amazon EBS CSI Driver

✔ GP3 StorageClass

✔ Persistent Volumes

✔ Helm

✔ Prometheus

✔ Alertmanager

✔ Multi-node scheduling

Lessons Learned

Every fix exposed the next bottleneck:

Missing IAM permissions (IRSA)
Missing CSI-backed StorageClass
Scheduler constraints
Node capacity limitations

This reinforced the importance of troubleshooting infrastructure in dependency order rather than assuming the first error is the only problem.


*********************************************

100%.

In fact, this is exactly what senior engineers do.

They don't just write code—they leave an engineering trail. Six months from now you'll thank yourself when you're preparing for interviews or trying to remember why a particular decision was made.

I'd make this something like:

---

# Journal Entry XX – Kubernetes Observability & GitOps Foundation

**Date:** 2026-06-26

## Objective

Continue building TITAN into an enterprise Internal Developer Platform by implementing observability and beginning the GitOps platform layer.

---

# Accomplishments

## Kubernetes Observability Stack

Successfully deployed the Prometheus monitoring stack into the EKS cluster using Helm.

Components deployed:

* Prometheus Server
* Alertmanager
* Grafana
* kube-state-metrics
* node-exporter
* Prometheus Pushgateway

Validated:

* Prometheus targets healthy
* Metrics successfully scraped
* Grafana connected to Prometheus datasource
* Port forwarding configured
* Imported Node Exporter Full dashboard
* Imported Kubernetes Cluster dashboard

---

## Grafana

Configured Grafana to communicate with Prometheus.

Validated datasource connectivity:

> Successfully queried the Prometheus API.

Imported multiple dashboards including:

* Node Exporter Full
* Kubernetes Views Global

Observed:

* CPU Utilization
* Memory Utilization
* Namespace metrics
* Pod metrics
* Node metrics
* Cluster resource usage
* Running workloads

---

## Kubernetes Metrics Validation

Verified live metrics from:

* kube-state-metrics
* node-exporter
* Prometheus Server

Confirmed dashboards reflected:

* CPU usage
* Memory usage
* Running Pods
* Namespace utilization
* Cluster capacity
* Resource requests/limits

---

# GitOps Foundation

Installed ArgoCD into the cluster.

Components deployed:

* Application Controller
* Repo Server
* API Server
* Redis
* Notifications Controller
* Dex
* ApplicationSet Controller

Successfully accessed the ArgoCD Web UI.

---

# Problems Encountered

## 1. Grafana Datasource Configuration

Issue:

Datasource would not populate during dashboard import.

Root Cause:

Datasource required manual configuration.

Resolution:

Configured Prometheus datasource using internal Kubernetes service.

Validated:

Successfully queried Prometheus API.

---

## 2. Port Forward Confusion

Issue:

kubectl port-forward appeared to hang.

Root Cause:

Port forwarding is designed to remain attached while proxying traffic.

Resolution:

Verified browser connectivity.

Confirmed expected behavior.

---

## 3. Dashboard Import Differences

Issue:

Documentation referenced datasource selection while newer Grafana versions automatically detected datasource.

Resolution:

Validated dashboard imported correctly despite UI differences.

---

## 4. ArgoCD Installation

Issue:

Received CRD annotation warning.

Resolution:

Installation continued successfully.

Most ArgoCD components deployed correctly.

---

## 5. Pods Remaining Pending

Issue:

ArgoCD pods remained in Pending state.

Diagnosis:

```text
0/2 nodes available

Too many pods
```

Determined cluster capacity had been exhausted.

---

## 6. EKS Capacity Planning

Modified Terraform node group:

Before:

```hcl
desired_size = 2
max_size     = 3
min_size     = 1
```

After:

```hcl
desired_size = 3
max_size     = 5
min_size     = 2
```

Applied via Terragrunt.

Validated:

New worker node joined cluster.

Pending workloads scheduled successfully.

---

## 7. ArgoCD Recovery

After node expansion:

All ArgoCD core components reached Running state.

Verified:

* Application Controller
* Repo Server
* Redis
* Notifications
* API Server
* Dex
* ApplicationSet

Successfully logged into ArgoCD Web UI.

---

# Lessons Learned

Infrastructure failures are frequently capacity failures rather than application failures.

Pending pods should always be investigated using:

```bash
kubectl describe pod <pod>
```

The Kubernetes scheduler provides the exact scheduling reason.

Increasing cluster capacity immediately resolved scheduling constraints.

---

# Architectural Decisions (ADR Candidates)

### Decision

Continue using managed EKS Node Groups for Titan v1.

Reason

Simple operational model while platform capabilities are still being developed.

---

### Future Enhancement

Replace static node scaling with Cluster Autoscaler.

Benefits:

* Automatic node provisioning
* Cost optimization
* Better scheduling
* Enterprise best practice

---

### Future Enhancement

Adopt Karpenter during Titan Phase 2.

Reasons:

* Faster provisioning
* Better instance selection
* Spot integration
* Improved cost optimization

---

# Platform Status

Current platform capabilities:

✅ AWS Organizations

✅ IAM

✅ SCPs

✅ Security Hub

✅ GuardDuty

✅ AWS Config

✅ CloudTrail

✅ KMS

✅ Budget Guardrails

✅ Terraform

✅ Terragrunt

✅ Amazon EKS

✅ Kubernetes

✅ Prometheus

✅ Grafana

✅ Node Exporter

✅ kube-state-metrics

✅ ArgoCD

---

# Next Session

* Deploy Cluster Autoscaler
* Configure GitOps repositories
* Create first ArgoCD Application
* Implement automatic synchronization
* Begin GitOps deployment workflow


> **Milestone Achieved:** TITAN has officially evolved beyond an Infrastructure-as-Code project into an **enterprise platform engineering environment**. The platform now includes infrastructure provisioning, Kubernetes orchestration, observability, monitoring, and GitOps capabilities, closely reflecting the architecture of a modern Internal Developer Platform (IDP).

---



