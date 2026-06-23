# Journal Entry – Budget Guardrails Backend Conflict Resolution

## Date

2026-06-22

## Objective

Continue hardening TITAN platform configuration by removing hardcoded notification email addresses and transitioning to environment-variable driven configuration.

## Issue Encountered

While validating the `budget-guardrails` stack using Terragrunt, Terraform initialization failed with:

```text
Error: Duplicate "backend" configuration block
```

Initial investigation suggested a Terragrunt backend generation issue. The error persisted even after clearing `.terragrunt-cache`.

## Investigation

Validated generated Terragrunt cache files:

```bash
grep -R 'backend "s3"' .
```

Results revealed:

```text
.terragrunt-cache/.../backend.tf
.terragrunt-cache/.../versions.tf
```

Further inspection showed:

```hcl
terraform {
  backend "s3" {}
}
```

was still present inside:

```text
terraform/modules/budget-guardrails/versions.tf
```

while Terragrunt was simultaneously generating:

```hcl
terraform {
  backend "s3" {
    bucket = ...
    key    = ...
  }
}
```

inside the cache directory.

## Root Cause

The reusable Terraform module contained a legacy:

```hcl
backend "s3" {}
```

block.

Because TITAN uses Terragrunt-managed remote state generation, Terragrunt automatically injected a second backend configuration during runtime, resulting in duplicate backend definitions.

## Resolution

Removed:

```hcl
backend "s3" {}
```

from:

```text
terraform/modules/budget-guardrails/versions.tf
```

Retained backend management exclusively through Terragrunt root configuration.

Cleared cache:

```bash
rm -rf .terragrunt-cache
```

Reinitialized:

```bash
tgi
```

Validated:

```bash
tgp
```

Plan completed successfully.

## Additional Security Improvement

Removed hardcoded notification email addresses from repository configuration.

Implemented:

```hcl
notification_email = get_env(
  "TITAN_NOTIFICATION_EMAIL",
  "placeholder@example.com"
)
```

Configured local environment:

```bash
export TITAN_NOTIFICATION_EMAIL="andrew@strongtowersecurity.io"
```

Verified:

```bash
git grep "andrew@strongtowersecurity.io"
```

returned no repository matches.

## Outcome

* Eliminated duplicate backend configuration error.
* Standardized backend ownership under Terragrunt.
* Removed sensitive email configuration from source control.
* Improved portability between development, testing, and production environments.
* Successfully validated budget guardrails deployment plan.

## Lessons Learned

When using Terragrunt-generated remote state, reusable Terraform modules should never define their own backend blocks. Backend ownership should exist in exactly one location to prevent initialization conflicts and configuration drift.
