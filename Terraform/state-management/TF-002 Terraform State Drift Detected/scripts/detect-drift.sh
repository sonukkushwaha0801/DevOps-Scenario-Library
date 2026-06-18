#!/bin/bash

set -e

echo "========================================"
echo "Terraform Drift Detection"
echo "========================================"

echo ""
echo "Running terraform plan..."

terraform plan -out=tfplan

echo ""
echo "Plan completed."
echo "Review output carefully for drift."

