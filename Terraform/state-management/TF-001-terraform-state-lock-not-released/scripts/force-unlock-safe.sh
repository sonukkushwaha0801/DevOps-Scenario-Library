#!/bin/bash

echo "========================================"
echo "Terraform Safe Force Unlock Utility"
echo "========================================"

# Check terraform installation
if ! command -v terraform &> /dev/null; then
    echo "ERROR: Terraform CLI not installed."
    exit 1
fi

# Read lock ID
read -p "Enter the lock ID to force unlock: " LOCK_ID

if [ -z "$LOCK_ID" ]; then
    echo "ERROR: Lock ID cannot be empty."
    exit 1
fi

echo ""
echo "WARNING: Terraform Force Unlock"
echo "This action can be dangerous if an active operation exists."
echo ""
echo "Before continuing, verify:"
echo "1. No active terraform process exists"
echo "2. No CI/CD job is running"
echo "3. No engineer is executing terraform apply"
echo ""

read -p "Type YES to continue: " CONFIRM

if [ "$CONFIRM" != "YES" ]; then
    echo "Operation cancelled."
    exit 1
fi

echo ""
echo "Attempting force unlock..."

if terraform force-unlock "$LOCK_ID " ; then
    echo ""
    echo "SUCCESS: Lock removed successfully."
else
    echo ""
    echo "ERROR: Force unlock failed."
    exit 1
fi

echo ""
echo "Recommended next step:"
echo "Run: terraform plan"
