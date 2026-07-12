# TITAN Platform API

## Purpose

The Platform API represents the next evolution of TITAN's Internal Developer Platform (IDP).

Version 1 of TITAN focuses on infrastructure governance, GitOps, Kubernetes platform engineering, and automated DevSecOps guardrails.

The Platform API is intentionally included as the foundation for Version 2.

## Current Status

Current Status: Planned (v2)

The API scaffolding exists to demonstrate the intended architecture and project direction. Infrastructure provisioning in Version 1 is performed through GitHub Actions, Terraform, Terragrunt, ArgoCD, and GitOps workflows.

## Future Capabilities

The Platform API will expose secure REST endpoints allowing developers to:

- Provision infrastructure through self-service requests
- Request Kubernetes namespaces
- Deploy approved platform templates
- Trigger Terraform/Terragrunt workflows
- View deployment status
- Request secrets
- Request IAM access
- Integrate with approval workflows
- Integrate with AI-assisted platform operations

The Platform API removes the requirement for developers to directly interact with Terraform while maintaining governance and security controls.