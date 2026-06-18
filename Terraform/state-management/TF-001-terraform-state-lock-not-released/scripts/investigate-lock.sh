#!/bin/bash

echo "========================================"
echo "Terraform Lock Investigation"
echo "========================================"

echo ""
echo "[1] Checking active Terraform processes..."
ps aux | grep terraform | grep -v grep

echo ""
echo "[2] Checking lock files..."
find . -name "*.lock*" 2>/dev/null

echo ""
echo "[3] Checking Terraform directories..."
find . -name ".terraform" -type d 2>/dev/null

echo ""
echo "Investigation complete."

