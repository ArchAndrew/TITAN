import json
import logging
import os
from datetime import datetime, timezone

import boto3

logger = logging.getLogger()
logger.setLevel(logging.INFO)

sns = boto3.client("sns")
SNS_TOPIC_ARN = os.environ.get("SNS_TOPIC_ARN")


def classify_route(severity):
    severity = (severity or "UNKNOWN").upper()

    if severity == "CRITICAL":
        return {
            "priority": "P1",
            "route": "PagerDuty/ServiceNow",
            "recommended_action": "Immediate escalation required. Investigate exposure, containment, and business impact."
        }

    if severity == "HIGH":
        return {
            "priority": "P2",
            "route": "Jira/Slack",
            "recommended_action": "Prioritized remediation required. Assign ownership and track to closure."
        }

    if severity == "MEDIUM":
        return {
            "priority": "P3",
            "route": "Slack",
            "recommended_action": "Security review required. Validate risk and remediation path."
        }

    return {
        "priority": "P4",
        "route": "LogOnly",
        "recommended_action": "Monitor and review during normal governance cycle."
    }


def extract_resources(finding):
    resources = []

    for resource in finding.get("Resources", []):
        resources.append({
            "id": resource.get("Id"),
            "type": resource.get("Type"),
            "partition": resource.get("Partition"),
            "region": resource.get("Region")
        })

    return resources


def build_investigation_summary(event):
    detail = event.get("detail", {})
    findings = detail.get("findings", [])

    routed_findings = []

    for finding in findings:
        severity = finding.get("Severity", {}).get("Label", "UNKNOWN")
        routing = classify_route(severity)

        routed_findings.append({
            "finding_id": finding.get("Id"),
            "generator_id": finding.get("GeneratorId"),
            "aws_account_id": finding.get("AwsAccountId"),
            "region": finding.get("Region"),
            "title": finding.get("Title"),
            "description": finding.get("Description"),
            "severity": severity,
            "compliance_status": finding.get("Compliance", {}).get("Status"),
            "workflow_status": finding.get("Workflow", {}).get("Status"),
            "record_state": finding.get("RecordState"),
            "resources": extract_resources(finding),
            "priority": routing["priority"],
            "route": routing["route"],
            "recommended_action": routing["recommended_action"]
        })

    return {
        "platform": "TITAN",
        "workflow": "securityhub-investigation-routing",
        "received_at": datetime.now(timezone.utc).isoformat(),
        "action_name": detail.get("actionName"),
        "action_description": detail.get("actionDescription"),
        "finding_count": len(findings),
        "routed_findings": routed_findings
    }


def publish_notification(summary):
    if not SNS_TOPIC_ARN:
        logger.warning("SNS_TOPIC_ARN is not configured. Skipping SNS publish.")
        return

    if summary["finding_count"] == 0:
        logger.info("No findings found in event. Skipping SNS publish.")
        return

    subject = "TITAN Security Finding Routed"

    message = json.dumps(summary, indent=2, default=str)

    sns.publish(
        TopicArn=SNS_TOPIC_ARN,
        Subject=subject,
        Message=message
    )

    logger.info("Published TITAN security notification to SNS.")


def lambda_handler(event, context):
    logger.info("TITAN Security Hub investigation event received")
    logger.info(json.dumps(event, default=str))

    summary = build_investigation_summary(event)

    logger.info("TITAN investigation routing summary")
    logger.info(json.dumps(summary, default=str))

    publish_notification(summary)

    return {
        "statusCode": 200,
        "body": json.dumps(summary, default=str)
    }