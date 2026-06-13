# ADR-004: Require Human Approval for AI-Assisted Actions
Status

Accepted

Context

TITAN will include AI-assisted capabilities such as request interpretation, incident summarization, documentation generation, and infrastructure recommendation.

AI-generated actions can create risk if executed without oversight.

Decision

AI may recommend actions, generate summaries, and translate intent into structured requests.

AI will not directly execute production infrastructure changes without human approval.

Rationale

This supports safe AI adoption and aligns with NIST AI RMF principles around governance, oversight, measurement, and risk management.

Consequences
Adds approval steps to AI-assisted workflows.
Reduces risk of unsafe autonomous action.
Creates clear audit trails for AI-assisted decisions.
EOF

cat > docs/architecture-decisions/ADR-005-governance-model.md <<'EOF'