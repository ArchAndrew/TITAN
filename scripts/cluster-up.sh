#!/usr/bin/env bash
set -euo pipefail

CLUSTER_NAME="titan-dev"
NODEGROUP_NAME="titan-dev-default-ng"

echo "Scaling $CLUSTER_NAME / $NODEGROUP_NAME UP..."

aws eks update-nodegroup-config \
  --cluster-name "$CLUSTER_NAME" \
  --nodegroup-name "$NODEGROUP_NAME" \
  --scaling-config minSize=7,desiredSize=7,maxSize=8

echo "Scale-up requested."
echo "Watch recovery with:"
echo "kubectl get nodes -w"
echo "kubectl get pods -A"
