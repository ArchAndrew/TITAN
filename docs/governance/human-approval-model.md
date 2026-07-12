# Human Approval Model

## Overview

Although TITAN automates infrastructure provisioning, critical production changes require human approval.

This balances developer velocity with organizational governance.

---

## Development

Developers may:

- Create feature branches
- Submit Pull Requests
- Execute Terraform validation
- Execute security scans

No infrastructure changes occur until validation succeeds.

---

## Pull Request Review

Every Pull Request requires review before merge.

Reviewers verify:

- Business justification
- Infrastructure design
- Security implications
- Cost impact
- Compliance requirements

---

## Automated Validation

GitHub Actions executes:

- Terraform Validate
- Terraform Format
- Checkov
- Trivy
- Gitleaks
- Snyk
- Conftest (OPA)

Any failure blocks deployment.

---

## Production Approval

Once validation succeeds:

Platform Engineering approves deployment.

Approval verifies:

- Architecture
- Governance
- Security
- Cost
- Organizational policy

---

## Emergency Changes

Emergency deployments require:

- Documented justification
- Platform Engineering approval
- Post-implementation review
- Audit documentation

---

## Separation of Duties

TITAN follows separation-of-duties principles.

Developers cannot independently deploy insecure infrastructure into production.

Platform Engineering maintains final approval authority.