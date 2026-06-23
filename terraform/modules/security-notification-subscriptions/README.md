# Security Notification Subscriptions

Creates SNS subscriptions for TITAN security notifications.

## Purpose

Connects TITAN's security alert topic to real notification consumers.

## Current Scope

Creates an email subscription to the TITAN security alerts SNS topic.

## Validation

After deployment, confirm the SNS subscription email.

Then invoke the Security Hub investigation Lambda test event to verify end-to-end delivery.

## Flow

Security Hub  
→ Custom Action  
→ EventBridge  
→ Lambda  
→ SNS  
→ Email