## Session 002

Date:
Time Spent:

### Goal

Build and validate TITAN Terraform bootstrap module.

### Work Completed

- Created Terraform bootstrap module.
- Added KMS encryption for remote state.
- Added S3 backend storage.
- Added DynamoDB locking table.
- Enabled bucket versioning.
- Added TLS enforcement policy.
- Validated configuration successfully.

### Outcome

Terraform validation completed successfully.

Result:

Success! The configuration is valid.

This marks the first deployable infrastructure module within TITAN.

### Lessons Learned

A successful terraform validate confirms configuration integrity before deployment and helps identify syntax and dependency issues early in the development lifecycle.

### Architecture Impact

Bootstrap module establishes the foundation for all future TITAN infrastructure deployments.

--------------------------------------------------------------------

### Goal

Validate TITAN bootstrap infrastructure.

### Work Completed

- Created terraform.tfvars.
- Configured globally unique state bucket.
- Executed terraform plan.
- Verified bootstrap resource creation plan.

### Results

Terraform generated a valid execution plan.

Resources:

- KMS Key
- KMS Alias
- S3 State Bucket
- S3 Versioning
- S3 Encryption
- S3 Public Access Controls
- S3 Bucket Policy
- DynamoDB Lock Table

Plan:

8 to add
0 to change
0 to destroy

### Lessons Learned

Terraform plan serves as a validation checkpoint before infrastructure creation.

The plan confirms:

- Resource dependencies
- Variable resolution
- Provider authentication
- Infrastructure intent

before any AWS resources are created.

----------------------------------------------------------------------

## Session 004

### Goal

Deploy TITAN bootstrap infrastructure.

### Work Completed

- Executed terraform apply against bootstrap module.
- Created secure Terraform backend infrastructure.
- Validated successful deployment.

### Deployment Results

Resources Created:

- KMS Key
- KMS Alias
- S3 Remote State Bucket
- Bucket Versioning
- Bucket Encryption
- Public Access Block
- TLS Enforcement Policy
- DynamoDB State Lock Table

Terraform Result:

Apply complete! Resources: 8 added, 0 changed, 0 destroyed.

### Lessons Learned

The bootstrap module establishes the secure foundation required for all future Terraform and Terragrunt deployments.

Remote state management should be implemented before any application or platform infrastructure to ensure consistency, auditability, and recoverability.

### Architecture Impact

TITAN now has a production-grade Terraform backend capable of supporting multi-environment infrastructure deployments.

-------------------------------------------------------------------------

## Session 005

### Goal

Build governance tagging module.

### Work Completed

- Created reusable Terraform tagging module.
- Added required governance tags.
- Added validation controls for:
  - Environment
  - Data Classification
- Added support for additional tags.
- Added governance documentation.
- Successfully validated module.

### Outcome

The TITAN tagging module establishes a standardized governance metadata model for all future infrastructure.

### Lessons Learned

Governance begins before infrastructure provisioning.

Tags are not merely metadata.

They drive:

- Ownership
- Cost allocation
- Compliance reporting
- Audit evidence
- Security classification

### Architecture Impact

All future TITAN modules will consume this module to ensure governance consistency across environments.

-----------------------------------------------------------------------

## Session 006

### Goal

Build cloud cost governance controls.

### Work Completed

- Created Budget Guardrails Terraform module.
- Added monthly budget controls.
- Added configurable alert thresholds.
- Added budget notification support.
- Added governance documentation.
- Initialized AWS provider.
- Successfully validated module.

### Outcome

TITAN now includes reusable cloud cost governance controls capable of enforcing budget visibility and financial accountability.

### Lessons Learned

Cloud governance extends beyond security controls.

Cost governance is a first-class governance domain and should be implemented alongside security, compliance, and operational controls.

### Architecture Impact

Future TITAN environments will inherit standardized budget controls through reusable Terraform modules.


-----------------------------------------------------------------------

Issue: Terragrunt root.hcl parse error after updating global config paths.
Root cause suspected: malformed HCL / missing closing brace.
Next step: replace root.hcl with clean validated version.

************************************************************************

### Issue Encountered

Terragrunt root.hcl failed validation.

### Root Cause

A duplicate locals block was accidentally introduced during refactoring.

Incorrect:

locals {
locals {

Correct:

locals {

### Resolution

Removed duplicate block and revalidated configuration.

### Lesson Learned

When refactoring HCL files, validate structural blocks before troubleshooting Terragrunt inheritance logic.

************************************************************************
### Session 007

Issue Encountered

Terragrunt initialization failed due to Terraform version mismatch.

Root Cause

The TITAN modules required Terraform >= 1.6.0 while the local workstation was running Terraform 1.3.8.

Resolution

Upgraded local Terraform installation to a current supported version and reinitialized Terragrunt.

Lesson Learned

Platform tooling versions should be standardized early in the project lifecycle to prevent inconsistencies between module requirements and local development environments.

************************************************************************

## Session 008

### Goal

Validate Terragrunt remote state inheritance.

### Issues Encountered

1. Duplicate locals block in root.hcl
2. Missing backend block in Terraform module
3. Terraform version mismatch
4. Terragrunt using tfenv shim instead of Terraform executable
5. Windows path resolution issues

### Resolution

Downloaded Terraform 1.15.6 Windows AMD64 binary.

Executed Terragrunt using:

/c/terraform/terraform_1.15.6_windows_amd64/terraform.exe

Successfully initialized:

- Terragrunt
- Remote State Backend
- AWS Provider
- Module Source

### Lesson Learned

Windows Terragrunt may not properly execute tfenv shims.
Using an explicit Terraform executable path eliminated the issue.

### Result

First Terragrunt-managed TITAN module initialized successfully.

---------------------------------------------------------------------

## Milestone Reached

Successfully validated the TITAN platform foundation.

Validated:
- Terraform bootstrap
- Remote state backend
- Terragrunt hierarchy
- Environment inheritance
- Tagging governance
- Budget governance

Result:
The foundational deployment model for TITAN is operational and ready for governance module expansion.

**********************************************************

## AWS Organizations Discovery

Objective:
Validate governance foundation before implementing SCP guardrails.

Findings:
- Organization ID: o------------
- Root OU ID: r-----
- Feature Set: ALL
- SCP Status: ENABLED
- Management Account: 1-------------

Result:
AWS Organizations already existed and was configured with full features and SCP support.

Decision:
Refactored aws-organizations-core module from organization creation to organization discovery and validation.

Impact:
Confirmed governance boundary and enabled future SCP, OU, and account-governance implementations without recreating foundational services.


----------------------------------------------------------------

## SCP Guardrails Deployment

Deployed baseline AWS Organizations SCP guardrails.

Resources created:
- titan-deny-disable-cloudtrail
- titan-deny-disable-config
- titan-deny-leave-organization

Attachments:
- Attached baseline SCPs to Root OU r-----

Result:
Apply complete. Resources: 6 added, 0 changed, 0 destroyed.

Decision:
Deferred root-user activity restriction and region restriction until later governance hardening phase to reduce lockout and service-compatibility risk.

----------------------------------------------------------------
- Implemented AWS Organizations brownfield support
- Implemented SCP guardrails
- Implemented Access Analyzer module
- Resolved Terragrunt backend inheritance issues
- Resolved AWS Access Analyzer quota conflict
- Created TITAN account-level Access Analyzer

****************************************************************

## AWS Config Troubleshooting — Terragrunt EOF / Stale Terraform Metadata

### Objective

Deploy the TITAN AWS Config module using Terragrunt-managed remote state.

### Problem

Terragrunt repeatedly failed during initialization with:

```text
level=error msg=EOF
Unable to determine underlying exit code

The error occurred after Terragrunt successfully downloaded the module into .terragrunt-cache, but before Terraform produced a useful error message.

## Debugging Commands Used

cat terragrunt.hcl
cat ../../../root.hcl
cat ../../../../terraform/modules/aws-config/variables.tf
cat ../../../../terraform/modules/aws-config/main.tf

tfm
tfv
tfp

grep -R "backend \"s3\"" .
ls -la terraform/modules/aws-config
ls -la .terragrunt-cache

terragrunt init --terragrunt-no-auto-init --terragrunt-log-level debug

find .terragrunt-cache -name "backend.tf" -o -name "provider.tf" -o -name "versions.tf"

Root Cause

A stale .terraform/ directory existed inside the reusable module source:

terraform/modules/aws-config/.terraform/

Terragrunt copied this stale Terraform metadata into .terragrunt-cache, which caused backend initialization confusion and surfaced as a generic EOF error.

Resolution

1. Removed stale local Terraform metadata from the module source:

rm -rf terraform/modules/aws-config/.terraform
rm -rf live/dev/us-east-1/aws-config/.terragrunt-cache

2. Then reinitialized through Terragrunt:

cd live/dev/us-east-1/aws-config
tgi
tgv
tgp

3. Backend Modernization

Also migrated the Terragrunt backend configuration from deprecated DynamoDB locking to native S3 lockfile support.

Old:

dynamodb_table = "titan-terraform-locks"

New:

use_lockfile = true

Result

Terragrunt initialized successfully, AWS Config validated successfully, and Terraform generated a clean plan:

Plan: 8 to add, 0 to change, 0 to destroy.

### Lesson Learned

Reusable Terraform modules should not contain local .terraform/ directories. Terragrunt copies module source files into .terragrunt-cache, so stale local Terraform metadata can poison Terragrunt execution.

Terraform/Terragrunt troubleshooting should isolate:

Module validity
Live Terragrunt configuration
Root inheritance
Backend generation
Cache contents
Stale local metadata


Take away:

I debugged a Terragrunt EOF failure by isolating the module, inspecting generated cache contents, validating backend generation, and discovering stale `.terraform` metadata contaminating the Terragrunt cache.

****************************************************************

2026-06-16 — AWS Config + Security Hub Deployment

Time Spent: ~5.5 hours

Objective:
Implement governance and security foundations for TITAN Enterprise Self-Service Platform.

Completed

Fixed Terragrunt initialization failures
Corrected backend state configuration
Removed deprecated DynamoDB locking
Migrated to S3 native state locking
Debugged Terragrunt EOF errors
Identified empty provider.tf issue
Deployed AWS Config
Config Recorder operational
Delivery Channel operational
Recording Status: SUCCESS
Deployed AWS Security Hub
Default standards enabled
Git repository updated

Lessons Learned

Terragrunt EOF errors may originate from malformed or empty generated files.
Debugging with:

terragrunt init --terragrunt-log-level debug

is significantly more useful than standard output.
S3 native locking simplifies backend management versus DynamoDB.
State management mistakes are recoverable when infrastructure is modularized.
Always validate generated files inside .terragrunt-cache.

*Take away:
During development of TITAN, I encountered a backend initialization issue that blocked deployment. Rather than rebuilding from scratch, I traced the failure through Terragrunt debug logs, inspected generated cache artifacts, identified an empty provider configuration, migrated backend locking to native S3, and restored deployment capability. The experience reinforced the importance of understanding Terraform internals rather than treating IaC as a black box.

----------------------------------------------

## 2026-06-17

### GuardDuty Deployment

Implemented GuardDuty module.

Features Enabled:
- CloudTrail Monitoring
- DNS Log Analysis
- VPC Flow Log Analysis
- S3 Data Event Monitoring
- EKS Audit Log Monitoring

Verification:
aws guardduty get-detector

Status: ENABLED

Observed:
- S3 Protection enabled
- Kubernetes Audit Log monitoring enabled
- Malware Protection enabled

Outcome:
Security findings can now flow into Security Hub for centralized visibility.

----------------------------------------------------

# Journal Entry – TITAN Enterprise Self-Service Platform

**Date:** 2026-06-16  
**Session Duration:** ~8:30 PM – 10:30 PM (Current Session)  
**Environment:** dev / us-east-1  
**Project:** TITAN Enterprise Self-Service Platform  
**Focus Areas:** KMS Encryption Platform, Validation, Governance Stack Expansion

---

## Objective

Implement a customer-managed AWS KMS encryption capability for TITAN to support:

- Encryption of platform security artifacts
- Future CloudTrail log encryption
- Future Secrets Manager integration
- Governance and compliance controls
- NIST 800-53 aligned security architecture

---

## Architecture Position

```text
AWS Organizations
├── SCP Guardrails
├── IAM Access Analyzer
├── AWS Config
├── Security Hub
├── GuardDuty
└── KMS
```

---

## Resources Created

### Terraform Module

```text
terraform/modules/kms
├── main.tf
├── variables.tf
├── outputs.tf
├── versions.tf
└── README.md
```

### Terragrunt Deployment

```text
live/dev/us-east-1/kms
└── terragrunt.hcl
```

---

## Terraform Resources

### KMS Key

```hcl
resource "aws_kms_key" "this"
```

Capabilities:

- Customer Managed Key (CMK)
- Automatic Key Rotation
- Encryption / Decryption
- Tagged for Governance

### KMS Alias

```hcl
resource "aws_kms_alias" "this"
```

Alias:

```text
alias/titan-security
```

---

## Validation Results

### Terraform

```bash
tgi
tgv
tgp
tga
```

Result:

```text
Apply complete! Resources: 2 added, 0 changed, 0 destroyed.
```

---

### Alias Verification

Command:

```bash
aws kms list-aliases \
  --query "Aliases[?AliasName=='alias/titan-security']"
```

Result:

```text
alias/titan-security
```

Status:

✅ Passed

---

### Key Verification

Command:

```bash
aws kms describe-key \
  --key-id alias/titan-security
```

Important Validation Results:

```json
{
  "Enabled": true,
  "KeyManager": "CUSTOMER",
  "KeyUsage": "ENCRYPT_DECRYPT",
  "KeySpec": "SYMMETRIC_DEFAULT"
}
```

Status:

✅ Passed

---

## Security Outcome

Successfully deployed a customer-managed encryption layer that can be leveraged by:

- CloudTrail
- AWS Config
- Security Hub exports
- Future Secrets Manager integrations
- Future platform artifacts and evidence repositories

This establishes foundational encryption capabilities for the TITAN governance and security architecture.

---

## Interview Talking Points

### Platform Security

Implemented customer-managed encryption using AWS KMS with Terraform and Terragrunt. Configured automated key rotation and governance tagging standards to support enterprise security requirements and future encryption of platform services.

### Governance

Integrated KMS into a broader cloud governance architecture consisting of:

- AWS Organizations
- Service Control Policies
- IAM Access Analyzer
- AWS Config
- Security Hub
- GuardDuty

### Compliance

Supports:

- NIST 800-53
- Security logging
- Evidence retention
- Encryption-at-rest controls
- Governance guardrails

---

## Current Security Stack

### Governance

- AWS Organizations
- SCP Guardrails
- IAM Access Analyzer
- AWS Config

### Threat Detection

- Security Hub
- GuardDuty
  - CloudTrail Monitoring
  - DNS Monitoring
  - VPC Flow Log Monitoring
  - S3 Data Event Monitoring
  - EKS Audit Log Monitoring
  - Malware Protection

### Encryption

- AWS KMS
  - Customer Managed Key
  - Alias Management
  - Key Rotation Enabled

---

## Next Planned Module

### CloudTrail

Reason:

```text
CloudTrail
    ↓
AWS Config
    ↓
GuardDuty
    ↓
Security Hub
```

CloudTrail will provide the audit and activity telemetry required to complete the core governance and threat-detection pipeline.

Target Deliverables:

- Organization Trail
- Multi-Region Logging
- Log File Validation
- KMS Encryption Integration
- S3 Log Storage
- Security Hub Integration

---

## Session Outcome

### Completed

✅ AWS KMS Module Created  
✅ Terragrunt Deployment Created  
✅ Terraform Validation Passed  
✅ Deployment Successful  
✅ Alias Verification Successful  
✅ Customer Managed Key Verified  
✅ Governance Tags Applied  
✅ Encryption Layer Added To TITAN Security Platform

**Status:** COMPLETE

*****************************************************
# TITAN Journal – CloudTrail + KMS Integration & Troubleshooting

**Date:** 2026-06-16
**Duration:** ~1.5 hours
**Module(s):**
- kms
- cloudtrail

---

## Objective

Implement centralized audit logging with AWS CloudTrail and encrypt audit logs using a customer-managed AWS KMS key.

---

## Resources Created

### KMS

- Customer Managed Key (CMK)
- Alias: `alias/titan-security`
- Key Rotation Enabled
- Tagged according to TITAN governance standards

Terraform Resources:

```hcl
aws_kms_key.this
aws_kms_alias.this
```

Validation:

```bash
aws kms list-aliases \
  --query "Aliases[?AliasName=='alias/titan-security']"

aws kms describe-key \
  --key-id alias/titan-security
```

Status:

- Key Enabled
- Key Manager: CUSTOMER
- Symmetric Encryption
- Alias Created Successfully

---

## CloudTrail Implementation

Created:

- Dedicated CloudTrail S3 bucket
- Bucket Policy
- Public Access Block
- Multi-Region CloudTrail
- Log File Validation Enabled
- KMS Encryption Enabled

Terraform Resources:

```hcl
aws_s3_bucket.trail
aws_s3_bucket_policy.trail
aws_s3_bucket_public_access_block.trail
aws_cloudtrail.this
```

---

## Issue #1

### Invalid KMS Key Identifier

Initial Error:

```text
kms_key_id (alias/titan-security) is an invalid ARN
```

Root Cause:

CloudTrail requires a KMS Key ARN.

Terraform was passing:

```hcl
alias/titan-security
```

instead of:

```hcl
arn:aws:kms:...
```

Resolution:

Updated module output:

```hcl
output "key_arn" {
  value = aws_kms_key.this.arn
}
```

Updated Terragrunt dependency reference:

```hcl
kms_key_id = dependency.kms.outputs.key_arn
```

Result:

CloudTrail plan succeeded.

---

## Issue #2

### CloudTrail Creation Failed

Error:

```text
InsufficientEncryptionPolicyException
```

CloudTrail reported:

- Unable to access S3 bucket
- Unable to access KMS key

---

## Root Cause Analysis

Terraform syntax was valid.

Issue was AWS authorization.

CloudTrail requires explicit permissions in the KMS Key Policy.

The CMK policy only granted permissions to the account root principal.

CloudTrail service principal was not authorized.

---

## Resolution

Added CloudTrail service permissions:

```json
{
  "Sid": "AllowCloudTrailToEncryptLogs",
  "Effect": "Allow",
  "Principal": {
    "Service": "cloudtrail.amazonaws.com"
  },
  "Action": [
    "kms:GenerateDataKey*",
    "kms:DescribeKey"
  ],
  "Resource": "*"
}
```

Re-applied KMS:

```bash
cd live/dev/us-east-1/kms

tgp
tga
```

Re-applied CloudTrail:

```bash
cd ../cloudtrail

tgp
tga
```

Result:

```text
Apply complete!
Resources: 1 added
```

CloudTrail created successfully.

---

## Validation

Verified CloudTrail:

```bash
aws cloudtrail describe-trails
```

Verified KMS:

```bash
aws kms describe-key \
  --key-id alias/titan-security
```

Verified encryption integration:

```bash
aws cloudtrail get-trail-status \
  --name titan-cloudtrail
```

Status:

- CloudTrail Enabled
- Multi-Region
- Log Validation Enabled
- S3 Logging Enabled
- KMS Encryption Enabled

---

## Lessons Learned

1. CloudTrail requires KMS Key ARN, not alias.
2. Successful Terraform validation does not guarantee AWS authorization success.
3. KMS key policies are frequently the root cause of service integration failures.
4. CloudTrail + KMS integrations require explicit service-principal permissions.
5. Reading AWS service error messages carefully is often faster than blindly modifying Terraform.

---

## Interview Talking Point

Implemented enterprise audit logging using Terraform and Terragrunt.

Designed and deployed:

- AWS Config
- Security Hub
- GuardDuty
- Customer Managed KMS Encryption
- Multi-Region CloudTrail

Troubleshot KMS authorization failures by analyzing CloudTrail encryption errors, updating CMK policies, and validating service-principal permissions.

Outcome:

- Centralized audit logging
- Customer-managed encryption
- Governance-aligned security baseline
- Infrastructure fully codified through Terraform/Terragrunt

***************************************************

# Security Hub Standards Implementation

## Objective

Extend Security Hub beyond default enablement by subscribing to enterprise security frameworks.

## Standards Enabled

- AWS Foundational Security Best Practices v1.0.0
- CIS AWS Foundations Benchmark v1.2.0

## Issue Encountered

Terraform failed when enabling CIS benchmark.

Error:

Invalid StandardsSubscriptionRequest

## Root Cause

Incorrect ARN format.

Used:

arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/1.2.0

Correct:

arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0

## Resolution

Queried available standards:

aws securityhub describe-standards

Discovered CIS benchmark uses a ruleset ARN instead of a standards ARN.

Updated Terraform and redeployed successfully.

## Validation

aws securityhub get-enabled-standards

Confirmed:

- AWS Foundational Security Best Practices
- CIS AWS Foundations Benchmark

## Outcome

Security posture baseline now includes:

- Governance
- Compliance
- Continuous Security Monitoring
- CIS Benchmark Alignment

---------------------------------------------

# TITAN Development Journal

## Date

2026-06-17

## Session Duration

Start: 8:39 PM

End: 2:22 AM

Break: ~1 Hour

Net Development Time: ~4 Hours 43 Minutes

---

## Major Accomplishments

### AWS Config

Successfully deployed AWS Config using Terraform and Terragrunt.

Implemented:

* Configuration Recorder
* Delivery Channel
* Dedicated S3 Bucket
* IAM Service Role

Validated functionality using:

```bash
aws configservice describe-configuration-recorders
aws configservice describe-delivery-channels
aws configservice describe-configuration-recorder-status
```

Confirmed:

* Recording enabled
* Delivery channel operational
* Recorder status SUCCESS

---

### Security Hub

Successfully deployed AWS Security Hub.

Enabled:

* AWS Foundational Security Best Practices Standard
* CIS AWS Foundations Benchmark

Discovered and resolved Security Hub ARN issue.

Root Cause:

Incorrect ARN format used for CIS benchmark.

Incorrect:

arn:aws:securityhub:us-east-1::standards/cis-aws-foundations-benchmark/v/1.2.0

Correct:

arn:aws:securityhub:::ruleset/cis-aws-foundations-benchmark/v/1.2.0

Result:

* Foundational Standard enabled
* CIS Benchmark enabled
* Security Hub operational

---

### GuardDuty

Successfully deployed:

* GuardDuty Detector
* Malware Protection
* S3 Data Event Monitoring
* EKS Audit Log Monitoring

Validated deployment using:

```bash
aws guardduty get-detector --detector-id <detector-id>
```

Confirmed:

* Status ENABLED
* Malware Protection ENABLED
* S3 Monitoring ENABLED
* EKS Audit Logs ENABLED

---

### KMS

Successfully deployed TITAN customer-managed KMS key.

Created:

* CMK
* Alias: alias/titan-security

Validated using:

```bash
aws kms list-aliases
aws kms describe-key --key-id alias/titan-security
```

Confirmed:

* Key enabled
* Customer managed
* Alias operational

---

### CloudTrail

Successfully deployed:

* Multi-region CloudTrail
* Dedicated S3 log bucket
* KMS encryption

Issue Encountered:

CloudTrail creation failed due to insufficient KMS permissions.

Root Cause:

KMS key policy did not allow CloudTrail service principal access.

Resolution:

Added CloudTrail permissions to KMS policy.

Result:

CloudTrail successfully created and operational.

---

### AWS Config Rules

Successfully deployed six AWS-managed Config Rules:

* titan-s3-bucket-public-read-prohibited
* titan-s3-bucket-public-write-prohibited
* titan-encrypted-volumes
* titan-root-account-mfa-enabled
* titan-cloudtrail-enabled
* titan-iam-password-policy

Validated through:

* Terraform apply
* AWS Config console
* Compliance dashboard

---

## Governance Architecture Status

Implemented:

Backend

* S3 Remote State
* Native State Locking
* Terragrunt

Audit

* CloudTrail
* AWS Config

Threat Detection

* GuardDuty
* Malware Protection
* S3 Protection
* EKS Audit Monitoring

Governance

* Security Hub
* AWS Foundations Standard
* CIS Benchmark
* Config Rules

Encryption

* Customer Managed KMS

---

## Lessons Learned

### Terragrunt Cache Troubleshooting

Experienced significant initialization failures caused by cached Terraform artifacts and module structure issues.

Key takeaway:

Generated provider/backend files and cached Terraform content can cause difficult-to-diagnose initialization failures.

Future troubleshooting process:

1. Validate module directly
2. Inspect Terragrunt cache
3. Verify generated files
4. Confirm backend generation
5. Reinitialize Terraform

---

### CloudTrail + KMS Integration

CloudTrail requires explicit permissions within the KMS key policy.

Creating the KMS key alone is not sufficient.

Service integrations must be considered during key policy design.

---

### Security Hub Standards

Security Hub standards use different ARN formats.

Always verify standards using:

```bash
aws securityhub describe-standards
```

before implementing Terraform resources.

---

## Next Session

Planned Work:

* Security Hub Insights
* Executive Findings Dashboards
* Critical Findings Insight
* High Findings Insight
* IAM Findings Insight
* S3 Findings Insight
* Encryption Findings Insight

Goal:

Begin building executive-level governance and compliance visibility for TITAN.

---

## Session Outcome

Major Success

Governance foundation is now operational and integrated across:

AWS Config
CloudTrail
Security Hub
GuardDuty
KMS

TITAN is transitioning from infrastructure deployment into a true cloud governance and security platform.
