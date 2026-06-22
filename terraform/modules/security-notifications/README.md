# Security Notifications

Creates an SNS topic for TITAN security alerts.

## Purpose

Provides a centralized notification target for future security workflows.

## Architecture

Security Hub  
→ EventBridge  
→ Lambda  
→ SNS Topic  

## Current Scope

Creates:

- titan-security-alerts SNS topic

## Future Enhancements

- Email subscription
- Slack webhook integration
- PagerDuty integration
- ServiceNow/Jira ticket routing