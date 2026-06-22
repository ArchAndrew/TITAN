# Security Hub Investigation Lambda

Creates a TITAN Lambda function that receives Security Hub custom action events from EventBridge.

## Purpose

This module starts the automated investigation layer for TITAN.

## Flow

Security Hub Finding  
→ TITAN Custom Action  
→ EventBridge  
→ Lambda  
→ CloudWatch Logs  

## Current Behavior

The Lambda logs the full event payload and generates a structured investigation summary.

## Future Enhancements

- Enrich findings with AWS API context
- Route escalations to SNS or Slack
- Create tickets
- Trigger Step Functions
- Generate executive summaries