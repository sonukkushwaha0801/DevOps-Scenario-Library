#!/bin/bash

set +e

echo "========================================="
echo " Terraform Resource Status Checker"
echo "========================================="
echo

STATE_OK=true
PLAN_STATUS="UNKNOWN"

check_state() {
    echo "[INFO] Checking Terraform state..."

    terraform state list >/dev/null 2>&1
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "[PASS] Terraform state accessible"
    else
        echo "[FAIL] Terraform state inaccessible"
        STATE_OK=false
    fi
}

inspect_state() {
    echo
    echo "[INFO] Inspecting Terraform state..."

    terraform show >/dev/null 2>&1
    exit_code=$?

    if [ $exit_code -eq 0 ]; then
        echo "[PASS] Terraform state readable"
    else
        echo "[FAIL] Terraform state unreadable"
        STATE_OK=false
    fi
}

check_plan() {
    echo
    echo "[INFO] Running Terraform plan..."

    terraform plan -detailed-exitcode >/dev/null 2>&1
    exit_code=$?

    case $exit_code in
        0)
            PLAN_STATUS="NO_CHANGES"
            echo "[PASS] No infrastructure changes detected"
            ;;
        1)
            PLAN_STATUS="PLAN_FAILED"
            echo "[FAIL] Terraform plan failed"
            ;;
        2)
            PLAN_STATUS="CHANGES_DETECTED"
            echo "[ALERT] Infrastructure changes or drift detected"
            ;;
    esac
}

summary() {
    echo
    echo "========================================="
    echo " Status Summary"
    echo "========================================="

    echo "State Healthy : $STATE_OK"
    echo "Plan Status   : $PLAN_STATUS"

    echo
    echo "Recommended next steps:"
    echo "1. Verify provider-side resource status"
    echo "2. Check infrastructure health"
    echo "3. Select recovery path"
}

check_state
inspect_state
check_plan
summary
