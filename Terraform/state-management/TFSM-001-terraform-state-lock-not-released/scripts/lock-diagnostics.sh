#!/bin/bash

echo "========================================"
echo "Terraform Lock Diagnostics"
echo "========================================"

echo ""
echo "[1] Terraform Version"
terraform version

echo ""
echo "[2] Current Workspace"
terraform workspace show

echo ""
echo "[3] State Accessibility Check"
terraform state list >/dev/null 2>&1

if [ $? -eq 0 ]; then
    echo "State accessible."
else
    echo "State inaccessible or backend issue."
fi

echo ""
echo "Diagnostics completed."
