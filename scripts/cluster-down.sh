#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="titan-dev"
NODEGROUP_NAME="titan-dev-default-ng"

echo "Scaling $CLUSTER_NAME / $NODEGROUP_NAME DOWN to 0 nodes..."

aws eks update-nodegroup-config \
  --cluster-name "$CLUSTER_NAME" \
  --nodegroup-name "$NODEGROUP_NAME" \
  --scaling-config minSize=0,desiredSize=0,maxSize=5

echo "Scale-down requested."
echo "Watch with: kubectl get nodes -w"
