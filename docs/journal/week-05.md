************************************************************
Build Journal – DevSecOps Pipeline Completion

Date: July 6–7, 2026

Objective

Complete the enterprise DevSecOps security pipeline for TITAN by integrating automated security scanning, policy validation, and secret detection into GitHub Actions while keeping AWS infrastructure costs under control.

Work Completed
GitLeaks Secret Scanning

Implemented automated secret detection within GitHub Actions.

Features:

Secret scanning on every push
SARIF artifact generation
Successful GitHub Actions execution
Validated no exposed credentials within repository

Challenges encountered:

GitLeaks workflow was initially stored outside .github/workflows
Placeholder workflows with invalid on: definitions caused every workflow to fail
Hidden .github directory caused path confusion during troubleshooting
Corrected workflow placement and disabled placeholder workflows

Result:

✅ GitLeaks operational

Checkov Infrastructure-as-Code Security

Implemented Checkov scanning across Terraform modules.

Validated:

Terraform modules
AWS security best practices
Infrastructure policy violations

Initial issue:

SARIF upload permissions generated GitHub integration errors.

Resolution:

Removed SARIF upload temporarily to prioritize successful pipeline execution while preserving IaC scanning functionality.

Result:

✅ Checkov operational

Trivy Filesystem + IaC Security

Integrated Trivy into GitHub Actions.

Coverage includes:

Filesystem scanning
Terraform configuration scanning
Dependency vulnerability detection

Result:

✅ Trivy operational

OPA / Conftest Policy Validation

Integrated Conftest for policy-as-code validation.

Challenges:

Incorrect GitHub release download URL
404 release path
Installation failure

Resolution:

Updated installation path to the current Conftest release.

Result:

✅ Conftest operational

Snyk Security Scanning

Integrated Snyk CLI into GitHub Actions.

Implemented:

Repository authentication
GitHub Actions secret management
Secure token storage
Automated vulnerability scanning

Result:

✅ Snyk operational

GitHub Branch Protection

Configured branch protection strategy.

Implemented:

Pull Request requirement
Required status checks
Branch protection configuration

Limitation discovered:

GitHub Free does not enforce branch protection rules on private repositories.

Decision:

Document configuration while acknowledging GitHub licensing limitation.

Result:

✅ Branch protection configured

Workflow Modernization

Updated GitHub Actions workflows to current supported runtime versions.

Updated:

actions/checkout
Workflow dependencies

Observation:

GitLeaks currently emits a Node.js 20 deprecation warning originating from the upstream GitLeaks GitHub Action rather than the TITAN workflow.

Decision:

Accepted as a non-blocking upstream issue.

Technical Lessons Learned

This implementation reinforced several enterprise DevSecOps concepts:

GitHub Actions workflow troubleshooting
Hidden directory behavior (.github)
SARIF integration considerations
Secret management using GitHub Secrets
Third-party action lifecycle management
Policy-as-code validation
Security gate orchestration
CI/CD debugging techniques
Enterprise branch protection strategy
Tool interoperability within GitHub Actions
Current Platform Status
DevSecOps Security Gates
✅ GitLeaks
✅ Checkov
✅ Trivy
✅ OPA / Conftest
✅ Snyk
Platform
✅ AWS Organizations
✅ IAM Identity Center
✅ GitOps (ArgoCD)
✅ Cilium
✅ Hubble
✅ Gatekeeper
✅ Observability Stack
✅ GitHub Actions CI/CD Security Pipeline
Cost Management

Current AWS spend remains approximately $118.55, significantly below the previous month's cost of approximately $132, while continuing development of enterprise platform capabilities.

Next Phase

Focus shifts from platform implementation to project completion.

Remaining work:

Executive documentation
Architecture documentation updates
Platform runbooks
Demonstration scenarios
Final GitHub repository cleanup
Resume/project portfolio updates