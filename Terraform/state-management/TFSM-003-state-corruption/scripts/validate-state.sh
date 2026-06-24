#!/bin/bash

echo "========================================"
echo "Terraform State Validation"
echo "========================================"

echo ""
echo "Checking terraform state..."

terraform state list
terraform show

echo ""
echo "State validation completed."

