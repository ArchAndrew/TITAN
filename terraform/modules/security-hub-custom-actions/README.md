# Security Hub Custom Actions

Creates custom AWS Security Hub action targets for TITAN.

## Purpose

Custom actions allow analysts to initiate downstream workflows from selected Security Hub findings.

## Actions

- TITAN Investigate Finding
- TITAN Escalate Finding
- TITAN Suppress Finding

## Architecture

Security Hub Finding  
→ Custom Action  
→ EventBridge Event  
→ Future TITAN Response Workflow

## Value

This module prepares TITAN for event-driven security response and SOAR-style automation.