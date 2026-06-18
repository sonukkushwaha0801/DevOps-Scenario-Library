#!/bin/bash

set -e

echo "========================================"
echo "Accept Drift Workflow"
echo "========================================"

echo ""
echo "Checklist:"
echo "1. Confirm manual change is approved"
echo "2. Update Terraform code manually"
echo "3. Validate configuration"
echo ""

read -p "Type YES after updating Terraform code: " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    echo "Operation cancelled."
    exit 1
fi

echo ""
echo "Running terraform fmt..."
terraform fmt

echo ""
echo "Running terraform validate..."
terraform validate

echo ""
echo "Running terraform plan..."
terraform plan

echo ""
echo "Review plan output carefully."
