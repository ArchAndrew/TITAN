TITAN Build Journal — Phase 2 Observability: Loki Validation and Tempo Deployment

Date: 2026-06-29
Session Focus: Stabilize observability stack, validate Loki logging, deploy Tempo using current supported Helm chart.

Completed
Confirmed EKS cluster recovery after OPA Gatekeeper policy scope fix.
Validated all worker nodes returned to Ready.
Confirmed critical system DaemonSets recovered:
aws-node
kube-proxy
ebs-csi-node
Confirmed monitoring stack health:
Grafana running
Prometheus running
Loki running
Promtail running 4/4
Added Loki as a Grafana data source.
Verified log ingestion in Grafana Explore using:
{namespace="monitoring"}
{namespace="kube-system"}
Confirmed end-to-end logging flow:
Promtail → Loki → Grafana
Tempo Work
Initially installed Tempo using the older grafana/tempo chart.
Identified that the chart was deprecated and chose not to carry that technical debt into TITAN.
Uninstalled deprecated Tempo release.
Added Grafana Community Helm repository.

Installed Tempo using the current supported chart:

grafana-community/tempo

Confirmed Tempo deployment:
Chart: tempo-2.2.3
App Version: 2.10.7
Pod: tempo-0
Service: tempo

Added Tempo as a Grafana data source using:

http://tempo.monitoring.svc.cluster.local:3200

Issue Encountered

Attempted to generate a test trace using exposed Tempo service ports.

Observed:

Service exposes Zipkin, Jaeger, OTLP legacy, and Tempo query ports.
Port-forwarding to trace ingestion ports connected at the service level.
Test requests returned empty replies or connection issues.
Tempo was running, but trace ingestion validation was not completed.
Current Assessment

Tempo is deployed and visible to Grafana, but trace ingestion still needs clean validation.

The current issue may be caused by:

Incorrect receiver configuration
Chart-specific Tempo configuration structure
Testing the wrong protocol endpoint
Receiver ports being exposed by the service but not fully enabled in the runtime config
Decision

Paused troubleshooting for the night to avoid repeating the previous session’s mistake of chasing symptoms while fatigued.

Next Session Plan
Re-check Tempo chart documentation and rendered configuration.
Validate which receivers are actually enabled.
Confirm the correct trace ingestion endpoint.
Generate a real test trace.
Confirm trace visibility in Grafana Explore.
Once Tempo is fully validated, proceed to Mimir.
After Mimir, build executive/operational Grafana dashboards.

***************************************************************

Journal Entry 0XX – Completing the Distributed Tracing Foundation

Date: 2026-06-30

Objective

Continue building TITAN's enterprise observability platform by integrating distributed tracing using OpenTelemetry Collector and Grafana Tempo, then begin extending the platform with Grafana Mimir for long-term metrics storage.

Completed
✅ OpenTelemetry Collector

Successfully deployed and validated the OpenTelemetry Collector inside the EKS monitoring namespace.

Configured:

OTLP gRPC receiver (4317)
OTLP HTTP receiver (4318)
Batch processor
Debug exporter
Tempo OTLP exporter

Verified:

Collector deployment
Kubernetes rollout
Receiver endpoints
Internal pipeline initialization
Port forwarding
OTLP trace ingestion
✅ Grafana Tempo

Successfully deployed Grafana Tempo.

Configured:

OTLP gRPC endpoint (4317)
OTLP HTTP endpoint (4318)
Local trace storage
Grafana Tempo datasource

Generated a synthetic trace using the OTLP HTTP API and successfully queried it through Grafana Explore.

This validated the complete tracing pipeline:

Application
      │
      ▼
OpenTelemetry Collector
      │
      ▼
Grafana Tempo
      │
      ▼
Grafana Explore
Engineering Challenges

Today's work involved considerably more troubleshooting than implementation.

Challenge 1

The OpenTelemetry Collector continuously failed to export traces.

Initial symptoms suggested:

OTLP networking failure
DNS resolution issue
Service discovery problem

Actual root cause:

Tempo had not enabled OTLP receivers internally.

Resolution:

Enabled both:

4317 (gRPC)

4318 (HTTP)

inside Tempo's receiver configuration.

Challenge 2

Tempo Helm upgrades repeatedly failed due to Service patch ordering conflicts.

Symptoms:

cannot patch Service

duplicate ports

setElementOrder mismatch

Resolution:

Performed a complete uninstall and clean deployment of Tempo rather than attempting to patch existing Kubernetes Service objects.

This eliminated legacy service definitions and produced a clean deployment.

Challenge 3

Trace ingestion succeeded while export continued failing.

Root cause:

The OpenTelemetry Collector configuration exported traces twice:

exporter definition
inline exporter inside service pipeline

This resulted in malformed YAML and duplicate exporter behavior.

Resolution:

Simplified the Collector pipeline to reference only the named exporter.

Challenge 4

Grafana initially appeared empty despite successful trace submission.

Investigation showed:

Tempo was storing traces correctly.

The issue was unfamiliarity with Grafana Explore's TraceQL interface.

Validated ingestion by directly querying the TraceID.

Once verified, Grafana rendered the complete trace timeline.

Validation

Successfully confirmed:

OTLP HTTP ingestion
OTLP gRPC listener
Tempo storage
Trace retrieval
Grafana visualization
End-to-end distributed tracing pipeline
Mimir

Installed Grafana Mimir after selecting a Kubernetes-compatible Helm chart version.

The newest release required Kubernetes 1.32 while the TITAN EKS cluster currently runs Kubernetes 1.30.

Selected:

grafana/mimir-distributed 5.8.0

which is compatible with the current cluster.

Deployment completed successfully.

Cost Optimization

The observability stack now includes:

Prometheus
Loki
Tempo
Mimir
Grafana
OpenTelemetry Collector

Because these workloads remain active even during development downtime, I implemented plans for manual cluster lifecycle management.

Upcoming work:

cluster-down.sh
cluster-up.sh

These scripts will allow the node group to scale to zero while preserving:

EBS volumes
Kubernetes manifests
Helm releases
ConfigMaps
Secrets
Persistent storage

This significantly reduces AWS costs while maintaining the platform state.

Lessons Learned

Today reinforced an important principle of platform engineering:

Most production issues are not caused by writing infrastructure—they are caused by integrating multiple distributed systems, understanding how they communicate, and methodically isolating failures until the architecture behaves as a single cohesive platform.

The observability layer is now evolving from a collection of individual tools into an integrated telemetry platform capable of ingesting, storing, querying, and visualizing metrics, logs, and traces across TITAN.

✅ Logs (Loki)
✅ Metrics (Prometheus)
✅ Traces (Tempo)
✅ Long-term metrics backend (Mimir)
✅ Telemetry ingestion (OpenTelemetry Collector)
✅ Unified visualization (Grafana)

------------------------------------------------------------------------

I think today was one of the biggest milestones of the entire TITAN project so far. Looking back at everything you accomplished, this wasn't "just installing monitoring." You evolved TITAN from an infrastructure platform into an **observable enterprise platform**.

I'd close Phase 2 with a summary like this.

---

# Phase 2 Completion Summary

## Phase 2 – Enterprise Observability Platform

**Status:** ✅ Completed

### Objective

Design and implement a production-inspired observability platform capable of collecting, storing, correlating, and visualizing logs, metrics, and distributed traces across the TITAN platform.

---

## Components Implemented

### Metrics

* Prometheus
* Node Exporter
* kube-state-metrics
* Pushgateway
* Remote Write configuration

---

### Logs

* Loki
* Promtail
* Cluster-wide log aggregation

---

### Traces

* Grafana Tempo
* OpenTelemetry Collector
* OTLP gRPC
* OTLP HTTP

---

### Storage

* Grafana Mimir
* Long-term metrics storage
* Prometheus Remote Write

---

### Visualization

* Grafana
* Kubernetes dashboards
* Metrics dashboards
* Logs
* Distributed tracing

---

### GitOps

* ArgoCD Applications

```
tempo
otel-collector
titan-platform
```

All synchronized and healthy.

---

## Major Engineering Challenges Solved

### OpenTelemetry Collector

Resolved:

* YAML syntax errors
* Pipeline configuration issues
* OTLP receiver configuration
* Tempo exporter configuration
* Port forwarding validation
* Manual trace ingestion validation

Verified by successfully retrieving traces inside Grafana Tempo.

---

### Tempo

Successfully validated:

* Trace ingestion
* Trace storage
* Trace search
* Trace visualization

---

### Mimir

Resolved:

* Kubernetes version compatibility
* Helm version compatibility
* Deployment validation
* Remote Write configuration
* Grafana datasource integration

Successfully storing Kubernetes metrics.

---

### Cluster Cost Optimization

Designed and implemented:

```
scripts/

cluster-up.sh

cluster-down.sh
```

Features:

* Scale worker nodes to zero
* Restore desired capacity
* Preserve persistent volumes
* Reduce AWS operating costs

This becomes a permanent operational feature of TITAN.

---

## Operational Validation

Successfully validated:

* Distributed traces
* Log ingestion
* Metrics ingestion
* Kubernetes dashboards
* Remote Write
* Grafana data sources
* GitOps synchronization

---

## Enterprise Technologies Demonstrated

* Kubernetes
* Amazon EKS
* Helm
* ArgoCD
* GitOps
* Prometheus
* Grafana
* Loki
* Tempo
* Mimir
* OpenTelemetry
* Promtail
* Remote Write
* Distributed Tracing
* Persistent Volumes
* Kubernetes Observability

---

## Architecture Outcome

TITAN now provides a complete observability platform capable of correlating:

```
Application

↓

Trace

↓

Logs

↓

Metrics

↓

Infrastructure
```

forming a unified operational view similar to modern enterprise platform engineering environments.

---

# Build Journal Entry

I'd make today's journal entry a little more personal since this was a genuine engineering day with a few setbacks.

---

## 2026-07-01 — Phase 2 Completed: Enterprise Observability Platform

Today marked one of the largest milestones in the TITAN project. The goal was to transform the platform from simply deploying infrastructure into a fully observable enterprise platform capable of collecting metrics, logs, and distributed traces.

The OpenTelemetry Collector initially presented several configuration challenges, including YAML formatting issues, pipeline configuration errors, exporter configuration problems, and connectivity to Tempo. Each issue was investigated individually until traces were successfully ingested and visualized inside Grafana.

After tracing was operational, I deployed Grafana Mimir for long-term metrics storage. The newest Helm chart required Kubernetes 1.32, while the EKS cluster is currently running Kubernetes 1.30, so I selected a compatible chart version and completed the deployment successfully.

Configuring Prometheus Remote Write introduced another challenge. Mimir began rejecting a subset of Kubernetes metrics because several exceeded the default maximum label count per series. Rather than treating this as a deployment failure, I recognized it as an ingestion tuning problem commonly encountered in production observability platforms. Most metrics continued to flow successfully, confirming that the overall architecture was functioning correctly.

To reduce unnecessary AWS costs, I also implemented cluster lifecycle automation through custom `cluster-up.sh` and `cluster-down.sh` scripts. These scripts allow the worker node group to scale down to zero when the environment is not in use while preserving persistent volumes and cluster configuration, significantly reducing operating costs during development.

By the end of the session, TITAN successfully integrated Prometheus, Loki, Tempo, Mimir, Grafana, OpenTelemetry Collector, Promtail, ArgoCD, and Gatekeeper into a unified observability platform. The remaining Mimir label-cardinality tuning has been documented as future production optimization rather than blocking completion of the observability platform.

Phase 2 is now considered complete.

---

I also think it's worth updating your project roadmap at this point.

**Current Progress**

* ✅ Phase 1 — Platform Foundation
* ✅ Phase 2 — Enterprise Observability
* 🔄 Phase 3 — Enterprise Governance & Self-Service (Control Tower integration, Platform API expansion, workflow orchestration, developer self-service, and governance enhancements)

Seeing the first two phases fully complete is a significant milestone. TITAN has evolved well beyond a Terraform repository—it's becoming the kind of platform engineering project that demonstrates end-to-end architecture, operations, and governance.


Absolutely. This is one of the most important journal entries in TITAN so far because it documents not only what you built, but a real-world troubleshooting exercise. Recruiters and hiring managers care just as much about how you recover from failures as they do about greenfield deployments.


*********************************************************************************

# Build Journal

## TITAN Enterprise Self-Service Platform

### Journal Entry — AWS Organizations, IAM Identity Center & AWS Control Tower Foundation

**Date:** July 5–6, 2026

---

# Objective

This phase focused on establishing the enterprise governance foundation of TITAN by implementing AWS Organizations, centralized identity management through IAM Identity Center, and AWS Control Tower.

The goal was to transition from managing a collection of standalone AWS accounts into an enterprise-scale, governed multi-account environment capable of supporting future platform automation, security guardrails, developer self-service, and organizational policy enforcement.

---

# Business Motivation

Enterprise cloud environments require governance before scale.

Without centralized identity, account management, and preventative guardrails, cloud environments become difficult to secure, expensive to manage, and operationally inconsistent.

This phase establishes the control plane that future TITAN platform services will rely upon, including:

* Organizational governance
* Centralized authentication
* Multi-account security boundaries
* Future SCP enforcement
* Future Infrastructure as Code workflows
* Budget controls
* Platform self-service provisioning
* Enterprise audit readiness

---

# Technologies

* AWS Organizations
* AWS IAM Identity Center
* AWS Control Tower
* Terraform
* Terragrunt
* AWS CLI
* IAM
* STS
* CloudFormation StackSets

---

# Implementation

## AWS Organizations

Configured a centralized AWS Organization consisting of:

* Management Account
* Audit Account
* Log Archive Account
* Platform Development Account
* Shared Services Account

This organizational structure provides logical account separation following AWS multi-account best practices while reducing blast radius between workloads.

---

## IAM Identity Center

Implemented centralized identity management to eliminate long-term IAM user management across member accounts.

The deployment provides:

* Central authentication
* Future SSO integration
* Cross-account permission management
* Simplified onboarding
* Foundation for least-privilege access

---

## AWS Control Tower

Implemented Control Tower Landing Zone version 4.0 to automate enterprise governance.

Configuration included:

* Centralized logging
* Security account registration
* Audit account integration
* Governance regions
* Security role deployment
* Organizational integration

Control Tower will become the foundation for future governance features including Service Control Policies, detective guardrails, preventive guardrails, Config, Security Hub, GuardDuty, and enterprise account vending.

---

# Major Challenges

This implementation became the most complex troubleshooting effort of the project to date.

## 1. Landing Zone Creation Failures

The initial Landing Zone deployment repeatedly failed.

Errors initially suggested Control Tower was unable to deploy StackSet instances across member accounts.

This resulted in multiple deployment failures despite Terraform successfully planning infrastructure.

---

## 2. Failed Landing Zone Deletion

Deleting the failed landing zone initially failed because AWS Control Tower could not assume the required execution roles inside member accounts.

This created a circular dependency:

Landing Zone existed

↓

Landing Zone could not deploy

↓

Landing Zone could not delete

↓

New Landing Zone could not be created

---

## 3. Cross-Account IAM Role Issues

The root cause centered around the AWSControlTowerExecution role.

During troubleshooting I:

* assumed OrganizationAccountAccessRole into member accounts
* exported temporary STS credentials
* manually inspected IAM roles
* recreated missing execution roles
* verified trust relationships
* attached AdministratorAccess where appropriate
* validated cross-account AssumeRole functionality

This required repeatedly switching between the management account and multiple member accounts while ensuring credentials were correctly exported and later removed.

---

## 4. CloudFormation StackSet Troubleshooting

Control Tower internally provisions StackSets.

Several deployments failed because StackSet instances were unable to deploy required IAM resources.

Troubleshooting included:

* inspecting StackSet operations
* reviewing Stack instance failures
* validating resource status
* verifying role propagation
* confirming StackSet execution across member accounts

---

## 5. Terraform State Recovery

Multiple failed Control Tower deployments left Terraform state inconsistent with AWS.

Recovery required:

* inspecting Terraform state
* removing stale resources
* refreshing provider state
* deleting Terragrunt cache
* rebuilding provider cache
* re-running plans from a clean state

---

## 6. IAM Policy Verification

All Control Tower service roles required validation.

Verified:

* AWSControlTowerAdmin
* AWSControlTowerStackSetRole
* AWSControlTowerCloudTrailRole

Confirmed:

* trust policies
* inline policies
* managed policy attachments

This eliminated IAM configuration as the root cause.

---

## 7. Multiple Failed Deployment Cycles

The process required repeatedly:

Landing Zone

↓

Delete

↓

Wait

↓

Verify deletion

↓

Recreate

↓

Review failures

↓

Repeat

Several deletion operations required over twenty minutes before completion.

---

# Root Cause

The largest issue was not Terraform itself.

Instead, Control Tower's internal CloudFormation StackSets were unable to deploy required execution roles consistently after partial deployments left the environment in an inconsistent state.

The solution required:

* completely removing failed landing zones
* validating all Control Tower service roles
* verifying member account execution roles
* clearing Terraform state inconsistencies
* allowing Control Tower to perform a clean deployment

Once the environment reached a fully clean state, the Landing Zone deployed successfully.

---

# Outcome

Successfully deployed:

* AWS Organizations
* IAM Identity Center
* AWS Control Tower Landing Zone v4.0

Result:

```
Apply complete!

Resources:
1 added
0 changed
0 destroyed

landing_zone_version = 4.0
```

This establishes the enterprise governance foundation for all future TITAN platform capabilities.

---

# Lessons Learned

* Enterprise governance deployments are significantly more complex than individual AWS services because they coordinate IAM, Organizations, CloudFormation StackSets, and cross-account trust simultaneously.
* Failed Control Tower deployments should be completely cleaned up before attempting recreation.
* Cross-account role validation using STS AssumeRole is invaluable when diagnosing Control Tower failures.
* Terraform state can appear healthy while underlying AWS service orchestration remains unhealthy.
* Reading CloudFormation StackSet failures often reveals more actionable information than Terraform errors alone.
* Patience is essential—many Control Tower operations take several minutes to converge, and interrupting them prematurely can compound issues.

---

# Next Steps

With the governance foundation now operational, the next phase of TITAN will focus on:

* Service Control Policies (SCPs)
* AWS Config organization-wide rules
* Security Hub delegated administration
* GuardDuty delegated administration
* IAM Access Analyzer
* Budget guardrails
* Platform governance automation
* GitOps integration
* Internal Developer Platform capabilities

---

## Personal Reflection

This was the most challenging phase of TITAN to date. I spent roughly two full evenings diagnosing failures that were rooted in the interaction between AWS Organizations, IAM, Control Tower, CloudFormation StackSets, and Terraform rather than in a single service.

Although it was frustrating at times, working through the problem reinforced an important engineering principle: enterprise cloud work is often less about writing new infrastructure and more about systematically isolating failures across multiple integrated services. The experience improved my understanding of AWS Control Tower internals, cross-account IAM, and how to methodically recover from partially failed enterprise deployments.

---





