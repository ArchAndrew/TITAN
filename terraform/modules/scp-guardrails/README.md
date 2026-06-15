# SCP Guardrails

## Purpose

This module creates AWS Organizations Service Control Policies used by TITAN to enforce baseline governance guardrails.

## Guardrails

- Deny disabling CloudTrail
- Deny disabling AWS Config
- Deny leaving the AWS Organization
- Deny root user activity
- Optional region restriction

## Safety Note

SCPs are powerful governance controls and can deny actions across accounts.

Do not apply new SCPs without reviewing the policy documents and confirming the target account, OU, or root ID.

## Governance Mapping

- AC-3 Access Enforcement
- AC-6 Least Privilege
- AU-2 Event Logging
- AU-12 Audit Record Generation
- CM-6 Configuration Settings
- SC-7 Boundary Protection