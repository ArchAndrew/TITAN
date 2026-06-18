# ADR-006: Use AWS Step Functions for Workflow Orchestration
Status

Accepted

Context

TITAN requires orchestration for multi-step workflows such as environment creation, namespace provisioning, secrets management, access requests, and application deployment.

Decision

AWS Step Functions will be used to orchestrate platform workflows.

Rationale

Step Functions provides visibility, retry logic, state management, and integration with Lambda, EventBridge, DynamoDB, and other AWS services.

Consequences
Workflow definitions must be version controlled.
Failure handling must be intentionally designed.
Workflow execution history can serve as audit evidence.
EOF

cat > docs/architecture-decisions/ADR-004-ai-human-approval-model.md <<'EOF'

------------------------------------------------
Why Step Functions instead of:
Lambda calling Lambda calling Lambda...

Answer;

Because TITAN is a workflow platform.

Example:

Developer Requests Environment
            ↓
Approval
            ↓
Terraform
            ↓
Validation
            ↓
Notification

That's orchestration.. Step Functions were literally built for this.

-----------------------------------------------

ADR-006 Security Findings Prioritization Strategy

Security Hub serves as TITAN's centralized findings repository.

Custom Security Hub Insights are used to aggregate and prioritize
security findings for executive reporting and operational triage.

Insights focus on:

- Critical Findings
- High Findings
- IAM Risks
- Encryption Risks
- Public Exposure Risks
- S3 Risks

