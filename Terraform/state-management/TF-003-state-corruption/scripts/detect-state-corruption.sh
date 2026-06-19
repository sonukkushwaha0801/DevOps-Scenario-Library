#!/bin/bash

echo "========================================"
echo "Terraform State Corruption Detection"
echo "========================================"

echo ""
echo "Checking state accessibility..."

if terraform state list > /dev/null 2>&1; then
    echo "State readable."
else
    echo "Potential state corruption detected."
fi
