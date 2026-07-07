# Control Tower Landing Zone Module

## Purpose

Configures the AWS Control Tower landing zone for the TITAN Enterprise Self-Service Platform.

## Responsibilities

- Create the Control Tower landing zone
- Configure governed AWS regions
- Configure the Audit account
- Configure the Log Archive account
- Enable centralized logging
- Establish the baseline governance structure for multi-account operations

## Managed Resources

- AWS Control Tower Landing Zone
- AWSControlTowerAdmin IAM role
- AWS Control Tower service role policy attachment

## Required Accounts

- Management Account
- Audit Account
- Log Archive Account

## TITAN Governance Role

This module extends the AWS Organizations foundation by enabling Control Tower governance across the TITAN multi-account environment.

It supports:

- Account governance
- Centralized logging
- Security account separation
- Guardrail readiness
- Enterprise landing zone alignment

## Notes

- This module should be deployed after AWS Organizations member accounts exist.
- The Audit and Log Archive account IDs must be supplied from the Organizations core module outputs.
- Control Tower deployment can take several minutes.
- Do not destroy this module casually; Control Tower affects the entire AWS Organization.