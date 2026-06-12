ADR-002: Use Terraform as the Primary Infrastructure as Code Tool
Status

Accepted

Context

TITAN needs reusable infrastructure modules across AWS services including networking, IAM, EKS, security services, observability, and platform automation.

Decision

Terraform will be used as the primary Infrastructure as Code tool.

Rationale

Terraform provides modularity, strong ecosystem support, multi-cloud flexibility, and aligns with many enterprise DevOps and platform engineering job requirements.

Consequences
Terraform state must be secured.
Modules must be reusable and clearly documented.
CI/CD workflows must include validation, planning, scanning, and approval gates.
EOF

cat > docs/architecture-decisions/ADR-003-step-functions-orchestration.md <<'EOF'

------------------------------------------------
#Why Terraform instead of CloudFormation?

Context:
Need repeatable infrastructure deployment.

Need;

AWS
Azure
Future GCP
Platform provisioning
Governance

Decision - Terraform.

Why
Multi-cloud
Larger ecosystem
Industry adoption
Module reuse
Recruiter demand

Consequence
Need:

State management
Module governance
Security validation
-----------------------------------------------

