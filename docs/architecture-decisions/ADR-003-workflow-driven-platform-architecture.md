# ADR-003: Use a Workflow-Driven Platform Architecture

## Status

Accepted

---

## Date

2026-06-13

---

## Context

TITAN is designed to provide governed self-service platform capabilities for engineering teams.

The platform supports workflows such as:

- Environment Factory
- Namespace Factory
- Secrets Factory
- Access Factory
- Deployment Factory
- AI-Assisted Operations

Each workflow requires more than simple API execution. A request must move through validation, governance checks, approval logic, infrastructure execution, evidence generation, observability registration, and notification.

Because of this, TITAN cannot be treated as a basic CRUD application or a collection of disconnected automation scripts.

---

## Problem Statement

How should TITAN structure platform operations so that self-service requests remain auditable, governed, repeatable, observable, and scalable?

---

## Decision

TITAN will use a workflow-driven platform architecture.

The Platform API will act as the entry point for user requests, but workflow orchestration will control the lifecycle of each platform operation.

A typical request will follow this pattern:

```text
User Request
    ↓
Platform API
    ↓
Input Validation
    ↓
Governance Checks
    ↓
Approval Workflow
    ↓
Workflow Orchestration
    ↓
Terraform / Kubernetes / AWS Execution
    ↓
Security Validation
    ↓
Evidence Generation
    ↓
Notification

---

