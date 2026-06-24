#!/bin/bash

echo "========================================"
echo "Terraform Missing State Detection"
echo "========================================"

echo ""
echo "Checking Terraform state..."

if terraform state list > /dev/null 2>&1; then
    echo "State exists."
else
    echo "State missing or inaccessible."
fi
