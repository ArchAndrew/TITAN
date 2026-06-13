# ADR-005: Embed Governance Into Platform Workflows
Status

Accepted

Context

Cloud governance is often treated as documentation or after-the-fact review.

TITAN will treat governance as an architectural feature.

Decision

Governance controls will be embedded into the platform using AWS Organizations, SCPs, IAM boundaries, budget guardrails, tagging standards, policy checks, and approval workflows.

Rationale

Embedding governance directly into provisioning workflows ensures consistency, reduces manual review burden, and supports compliance alignment with NIST 800-53.

Consequences
Platform workflows must enforce guardrails automatically.
Developers receive self-service capabilities within controlled boundaries.
Governance evidence can be generated continuously.
EOF

echo ""
echo "==============================================="
echo " TITAN Journal + ADR Scaffold Created "
echo "==============================================="
echo ""