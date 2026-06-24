#!/bin/bash

set +e

echo "========================================="
echo " Terraform State Validation Tool"
echo "========================================="
echo

STATE_HEALTHY=true

check_state_access() {
    echo "[INFO] Checking state accessibility..."

    terraform state list >/dev/null 2>&1
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "[PASS] Terraform state accessible"
    else
        echo "[FAIL] Terraform state inaccessible"
        STATE_HEALTHY=false
    fi
}

check_state_readability() {
    echo
    echo "[INFO] Checking state readability..."

    terraform show >/dev/null 2>&1
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "[PASS] Terraform state readable"
    else
        echo "[FAIL] Terraform state unreadable"
        STATE_HEALTHY=false
    fi
}

check_plan() {
    echo
    echo "[INFO] Checking Terraform plan execution..."

    terraform plan >/dev/null 2>&1
    exit_code=$?

    if [ $exit_code -eq 0 ] || [ $exit_code -eq 2 ]; then
        echo "[PASS] Terraform plan executable"
    else
        echo "[FAIL] Terraform plan failed"
        STATE_HEALTHY=false
    fi
}

summary() {
    echo
    echo "========================================="
    echo " Validation Summary"
    echo "========================================="

    if [ "$STATE_HEALTHY" = true ]; then
        echo "[PASS] Terraform state appears healthy"
    else
        echo "[CRITICAL] Terraform state validation failed"
        echo
        echo "Recommended actions:"
        echo "1. Investigate state issues"
        echo "2. Check backend configuration"
        echo "3. Consider manual recovery"
    fi
}

check_state_access
check_state_readability
check_plan
summary
