#!/bin/bash

echo "========================================"
echo "Terraform State Validation"
echo "========================================"

echo ""
echo "Checking Terraform state..."

terraform state list
terraform show

echo ""
echo "Validation completed."

