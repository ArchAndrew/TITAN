# Access Request Runbook

## Purpose

This runbook describes the standardized process for requesting, reviewing, approving, provisioning, and auditing access to AWS resources managed by the TITAN Enterprise Self-Service Platform.

TITAN follows the principles of Zero Trust and Least Privilege. Users are granted only the permissions necessary to perform their job responsibilities, and all access requests require business justification and approval.

---

# Scope

This procedure applies to:

- Developers
- Platform Engineers
- Cloud Operations
- Security Engineering
- Project Managers

---

# Prerequisites

Before requesting access, the user must:

- Possess a valid corporate identity.
- Complete required security awareness training.
- Be onboarded into the organization's Identity Provider.
- Have manager approval.
- Provide a business justification.

---

# Step 1 – Submit Access Request

The requester submits an access request containing:

- Full name
- Team
- Business owner
- AWS Account(s)
- Requested Permission Set
- Duration (Temporary or Permanent)
- Business justification

Incomplete requests are returned for correction.

---

# Step 2 – Management Approval

The request is reviewed by the requester's manager.

The manager confirms:

- Business need
- Employment status
- Appropriate level of access
- Separation of duties

Only approved requests proceed to Platform Engineering.

---

# Step 3 – Platform Engineering Review

Platform Engineering verifies:

- Least privilege
- Existing IAM Identity Center groups
- SCP restrictions
- Existing permissions
- Compliance requirements

If excessive permissions are requested, the request is revised before approval.

---

# Step 4 – Provision Access

Platform Engineering performs the following:

1. Assign IAM Identity Center Permission Set.
2. Add user to appropriate Identity Center Group.
3. Verify AWS Account assignments.
4. Confirm inherited SCP restrictions.
5. Validate CLI and Console access.

---

# Step 5 – Validation

The requester verifies:

✓ AWS Console login

✓ CLI authentication

✓ Expected AWS accounts visible

✓ Required services accessible

Access outside the approved scope must not be available.

---

# Step 6 – Audit and Documentation

Platform Engineering records:

- Request ID
- Approval
- Permission Set
- Assigned AWS Accounts
- Date Granted
- Expiration (if temporary)

CloudTrail automatically records authentication activity.

---

# Access Revocation

Access must be removed when:

- Employment ends
- Project completes
- Temporary access expires
- Security incident occurs

Identity Center group membership is removed and access is immediately revoked.

---

# Logging

Access activity is monitored through:

- IAM Identity Center
- CloudTrail
- AWS Config
- Security Hub

---

# Success Criteria

✓ Access granted

✓ Least privilege maintained

✓ Audit trail recorded

✓ Security controls validated

---

# Related Documents

- High-Level Architecture
- Data Flow
- Threat Model
- Trust Boundaries
- Security Control Mapping

---

# Roles and Responsibilities

| Role | Responsibility |
|------|----------------|
| Developer | Submit Request |
| Platform Engineer | Provision and Validate |
| Security Engineer | Review Security Controls |
| Cloud Operations | Monitor Platform |

---

# Revision History

| Version | Date | Description |
|----------|------|-------------|
| 1.0 | Initial Release | Initial enterprise runbook for TITAN |