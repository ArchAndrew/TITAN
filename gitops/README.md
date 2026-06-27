# TITAN GitOps

This directory contains all GitOps resources managed by ArgoCD.

## Structure

```
gitops/
├── applications/   # ArgoCD Application manifests
├── apps/           # Kubernetes manifests
├── projects/       # ArgoCD Projects
```

## GitOps Workflow

Developer
↓

Git Push

↓

GitHub

↓

ArgoCD

↓

Kubernetes

↓

Cluster State