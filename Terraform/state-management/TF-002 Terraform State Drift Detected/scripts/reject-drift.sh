#!/bin/bash

set -e

echo "========================================"
echo "Reject Drift Workflow"
echo "========================================"

echo ""
echo "WARNING:"
echo "This operation may modify infrastructure."
echo ""

echo "Checklist:"
echo "1. Confirm manual change is unauthorized"
echo "2. Review terraform plan carefully"
echo "3. Ensure no risky destroy operations"
echo ""

read -p "Type YES to continue: " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    echo "Operation cancelled."
    exit 1
fi

echo ""
echo "Running terraform plan..."
terraform plan

echo ""
echo "Review plan carefully before applying."
echo "Run terraform apply manually if safe."
