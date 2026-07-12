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
export TITAN_NOTIFICATION_EMAIL="arch@example.io"
```

Verified:

```bash
git grep "arch@example.io"
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

***-------------------------------------------------------------***

# TITAN Engineering Journal

## Week 04 – GitOps Expansion, ArgoCD Scaling, OPA Preparation & Cluster Autoscaler

**Date:** June 27, 2026

---

## Objective

Continue evolving TITAN from an infrastructure provisioning project into an enterprise Internal Developer Platform (IDP) by expanding GitOps capabilities, implementing ArgoCD application management, beginning policy enforcement with OPA Gatekeeper, and preparing the Kubernetes platform for automatic node scaling.

---

# Resources Created

### GitOps

* Implemented GitHub authentication for a private repository using a GitHub Fine-Grained Personal Access Token (PAT).
* Stored GitHub credentials securely as a Kubernetes Secret rather than embedding credentials into manifests.
* Configured ArgoCD repository authentication against the private GitHub repository.
* Verified automatic synchronization from GitHub to the Kubernetes cluster.

---

### ArgoCD

Created and validated:

* AppProject
* Application
* ApplicationSet

Verified:

* Automatic Sync
* Self Healing
* Namespace Auto-Creation
* Repository synchronization
* Successful deployment of TITAN application

The platform is now capable of managing future platform applications declaratively without manually creating individual ArgoCD Application resources.

---

### Kubernetes

Successfully deployed:

* TITAN application namespace
* ReplicaSet
* Running application pods
* ArgoCD GitOps workflow

Verified cluster health through:

* kubectl
* ArgoCD UI
* Kubernetes events
* Pod status

---

### OPA Gatekeeper

Completed initial deployment work:

* Added official Gatekeeper Helm repository
* Updated Helm repositories
* Installed Gatekeeper controllers
* Verified controller deployment
* Verified Gatekeeper Audit controller

Prepared environment for:

* Constraint Templates
* Admission Control
* Policy Library

---

### Cluster Autoscaler

Completed foundational work:

* Verified Auto Scaling Group tags
* Confirmed EKS auto-discovery configuration
* Created IAM policy
* Created IRSA IAM Role
* Created Kubernetes ServiceAccount
* Created Cluster Autoscaler Deployment
* Verified new worker node provisioning

Cluster successfully scaled from three worker nodes to four nodes after resource pressure.

---

# Challenges Encountered

## 1. Private Git Repository Authentication

### Problem

ArgoCD was unable to authenticate against the private GitHub repository.

### Resolution

Generated a Fine-Grained GitHub Personal Access Token and injected credentials securely as a Kubernetes Secret using environment variables rather than embedding secrets directly into manifests.

This approach follows enterprise security practices and avoids exposing credentials within source control.

---

## 2. ApplicationSet YAML Parsing

### Problem

Initial ApplicationSet manifest failed due to YAML formatting issues.

### Resolution

Corrected YAML syntax and reapplied the manifest successfully.

---

## 3. Relative Path Errors

### Problem

Attempted to apply manifests using incorrect relative paths after changing directories.

### Resolution

Adjusted execution context and reapplied manifests using the correct repository-relative paths.

---

## 4. Gatekeeper Helm Installation Timeout

### Problem

Helm installation initially timed out and appeared to hang.

### Investigation

Inspection of Kubernetes events showed:

* FailedScheduling
* Insufficient cluster resources
* Pending Gatekeeper controller pods

The Helm installation itself was functioning correctly; Kubernetes lacked sufficient capacity to schedule all required pods.

---

## 5. Cluster Resource Exhaustion

### Problem

Gatekeeper deployments exceeded available node capacity.

Symptoms included:

* Pending Pods
* FailedScheduling
* "Too many pods"
* CrashLoopBackOff during Autoscaler deployment

### Resolution

Investigated scheduler events and identified node capacity as the limiting factor.

Implemented Cluster Autoscaler to allow the EKS Managed Node Group to automatically provision additional worker nodes when resource limits are reached.

After scaling, the cluster successfully added an additional worker node and Gatekeeper components transitioned to Running.

---

# Lessons Learned

* GitOps for private repositories requires secure credential management; Kubernetes Secrets backed by environment variables provide a cleaner and safer solution than embedding credentials.
* ArgoCD ApplicationSets significantly reduce operational overhead by generating Application resources automatically as the platform expands.
* Enterprise policy engines such as OPA Gatekeeper introduce meaningful scheduling overhead that must be considered during cluster sizing.
* EKS node groups should be configured for automatic scaling before introducing admission controllers, service meshes, or other control-plane extensions.
* Kubernetes Events (`kubectl get events`) proved to be the most effective troubleshooting tool for identifying scheduling failures and resource exhaustion.

---

# Current Platform Status

## Completed

* AWS Landing Zone
* Terraform/Terragrunt
* Security Hub
* GuardDuty
* AWS Config
* CloudTrail
* IAM Access Analyzer
* Budget Guardrails
* GitOps
* ArgoCD
* AppProject
* Application
* ApplicationSet
* Prometheus
* Grafana
* Cluster Autoscaler Foundation

## In Progress

* OPA Gatekeeper
* Constraint Templates
* Admission Control

---

## Next Session Objectives

1. Finalize Cluster Autoscaler validation.
2. Complete OPA Gatekeeper deployment.
3. Implement initial Constraint Templates and Constraints.
4. Validate Admission Control by intentionally deploying a policy-violating workload.
5. Commit all GitOps manifests and documentation to the repository.


*********************************************************************

Absolutely. This one is worth documenting because it demonstrates **methodical troubleshooting** rather than just getting a feature working. That's something interviewers care about.

---

# TITAN Development Journal

**Date:** June 27–28, 2026

**Phase:** Kubernetes Policy Enforcement (OPA Gatekeeper) & Cluster Autoscaler Validation

## Objective

Continue maturing the TITAN Enterprise Self-Service Platform by:

* Completing Kubernetes Cluster Autoscaler
* Implementing OPA Gatekeeper admission control
* Building reusable security policies
* Validating policy enforcement using intentionally insecure workloads

---

## Resources Created

### Cluster Autoscaler

Successfully implemented:

* IAM Policy
* IAM Role (IRSA)
* Kubernetes ServiceAccount
* ClusterRole
* ClusterRoleBinding
* Deployment
* Auto-discovery configuration
* ASG tagging
* Autoscaling permissions

Validated:

* Successfully discovers EKS Managed Node Group
* Detects unschedulable workloads
* Calculates node utilization
* Evaluates scale-up / scale-down decisions

---

### OPA Gatekeeper

Installed and validated:

* Gatekeeper Controller Manager
* Admission Webhook
* Audit Controller
* ConstraintTemplate
* Constraint

Custom security policies created:

* Disallow `:latest` container images
* Block privileged containers

---

## Challenges Encountered

### 1. Gatekeeper installation failed

Initial Helm installation timed out.

Investigation showed:

* Pods remained Pending
* Scheduler reported:

```
0/3 nodes available
Too many pods
```

### Root Cause

The EKS cluster had exhausted available pod capacity.

### Resolution

Implemented Kubernetes Cluster Autoscaler to dynamically increase cluster capacity when workloads cannot be scheduled.

---

### 2. Cluster Autoscaler CrashLoopBackOff

Autoscaler initially failed with:

```
Failed to get nodes from apiserver
nodes is forbidden
```

### Root Cause

The ServiceAccount lacked the required Kubernetes RBAC permissions.

The IAM permissions were correct, but Kubernetes authorization was incomplete.

### Resolution

Created:

* ClusterRole
* ClusterRoleBinding

Granting the autoscaler permission to list and watch cluster resources.

After rollout restart:

```
Cluster Autoscaler Running
```

Logs confirmed:

* Node discovery
* ASG discovery
* Scale calculations
* Scale-down evaluation

---

### 3. Privileged Container Policy Appeared Broken

Testing with:

```
kubectl apply -f bad-privileged-pod.yaml
```

Unexpectedly succeeded.

At first glance, it appeared the Rego policy had failed.

### Investigation

Verified:

* YAML syntax
* Rego logic
* Admission webhook
* Existing Gatekeeper installation

Discovered:

```
kubectl get k8sblockprivileged

error:
the server doesn't have a resource type
"k8sblockprivileged"
```

---

## Root Cause

The ConstraintTemplate had never been applied.

Without the ConstraintTemplate:

* Kubernetes never generated the CRD
* The Constraint resource could not exist
* Gatekeeper had no policy to enforce

This was not a Rego issue—it was a deployment sequencing issue.

---

## Resolution

Applied:

```
ConstraintTemplate
```

Verified:

```
kubectl get constrainttemplates
```

Confirmed CRD creation:

```
k8sblockprivileged.constraints.gatekeeper.sh
```

Applied:

```
Constraint
```

Verified:

```
kubectl get k8sblockprivileged
```

Returned:

```
ENFORCEMENT ACTION:
deny
```

---

## Validation

Retested the insecure workload.

Attempted deployment:

```
securityContext:
  privileged: true
```

Gatekeeper rejected the request:

```
Error:

[block-privileged]

Container nginx is privileged.

Privileged containers are not allowed.
```

Policy enforcement successfully validated.

---

## Key Lessons Learned

### Kubernetes authorization and AWS IAM are separate systems.

IRSA solved AWS API authentication.

RBAC solved Kubernetes API authorization.

Both were required.

---

### ConstraintTemplates create Kubernetes APIs.

A Constraint cannot function until its corresponding ConstraintTemplate has successfully registered a CRD with the Kubernetes API server.

---

### Diagnose before rewriting.

Rather than assuming the Rego policy was incorrect, troubleshooting followed a structured approach:

* Validate workload
* Validate policy
* Validate Gatekeeper
* Validate CRD registration
* Validate Constraint
* Retest

The issue was deployment order, not policy logic.

---

## Current Platform Status

### ✅ Completed

* AWS Foundation
* Terraform / Terragrunt
* GitOps
* ArgoCD
* EKS
* Cluster Autoscaler
* OPA Gatekeeper
* Latest Image Policy
* Privileged Container Policy
* Prometheus
* Grafana
* Security Hub
* GuardDuty
* AWS Config
* IAM Access Analyzer

---

## Next Objective

Continue platform maturation by implementing:

* Executive Operational Dashboards

  * GitOps synchronization
  * Cluster health
  * Autoscaler activity
  * Policy compliance
  * Security posture
* Improve ArgoCD workflow to manage platform applications declaratively
* Continue working through the remaining checklist toward 100% completion.

---

Upon seeing that the privileged pod was admitted, I did not jump straight to "the Rego policy is broken." Instead, I traced the request through the entire admission chain:

1. Is the test manifest correct?
2. Is the webhook running?
3. Is the ConstraintTemplate installed?
4. Was the CRD generated?
5. Does the Constraint exist?
6. Is enforcement set to `deny`?
7. Re-run the test.

This is why verifying each layer rather than assuming the last thing changed is at fault.

**********************************************************************

TITAN Build Journal — Observability Platform (Loki Integration)

Date: 2026-06-28

Objective
Integrate enterprise-grade centralized logging into TITAN by deploying Grafana Loki alongside the existing Prometheus/Grafana monitoring stack.

Completed
Successfully deployed Grafana Loki using the current Grafana Helm chart.
Replaced deprecated Loki deployment approach with the supported single-binary deployment.
Configured Loki Gateway for centralized log ingestion.
Verified Loki services and StatefulSet deployment.
Installed Promtail as a DaemonSet for Kubernetes node log collection.
Confirmed Promtail scheduling issue was unrelated to Helm configuration.
Root Cause Investigation

Initial assumption:

Loki/Promtail deployment issue.

Actual findings:

Worker nodes were reaching the Kubernetes pod-per-node limit.
Original EKS worker nodes used t3.small instances supporting only 11 pods/node.
Promtail DaemonSet could not schedule on saturated nodes.
Infrastructure Improvements
Upgraded managed node group from t3.small to t3.medium.
Increased pod capacity from 11 to 17 pods per worker.
Successfully replaced original worker nodes.
Remaining Issue

Replacement nodes intermittently entered:

NotReady
NetworkPluginNotReady
CNI plugin not initialized

Observed errors:

aws-cni
connection refused
127.0.0.1:50051

This indicates an AWS VPC CNI initialization issue rather than a Loki or Promtail deployment issue.

Current Status
Grafana ✅
Prometheus ✅
Loki ✅
Promtail: partially operational (2/3 running)
Remaining work centers on stabilizing AWS VPC CNI and managed node initialization.
Next Session
Validate Managed Node Group health.
Validate AWS VPC CNI deployment.
Stabilize worker node initialization.
Achieve Promtail DaemonSet 3/3 Ready.
Connect Grafana to Loki.
Build log dashboards.
Deploy Tempo for distributed tracing.
Integrate External Secrets.
Continue Platform API implementation.


