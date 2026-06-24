#!/bin/bash

set +e

echo "========================================="
echo " Terraform Resource Diff Report"
echo "========================================="
echo

STATE_RESOURCES=0

check_state_resources() {
    echo "[INFO] Checking Terraform state resources..."

    resources=$(terraform state list 2>/dev/null)
    exit_code=$?

    if [ $exit_code -ne 0 ]; then
        echo "[FAIL] Unable to access Terraform state"
        exit 1
    fi

    STATE_RESOURCES=$(echo "$resources" | wc -l)

    echo "[INFO] Resources tracked in state: $STATE_RESOURCES"
}

check_plan_diff() {
    echo
    echo "[INFO] Running Terraform plan diff..."

    terraform plan -detailed-exitcode >/dev/null 2>&1
    PLAN_EXIT=$?

    case $PLAN_EXIT in
        0)
            echo "[PASS] No infrastructure changes detected"
            ;;
        1)
            echo "[FAIL] Terraform plan failed"
            ;;
        2)
            echo "[ALERT] Infrastructure drift or pending changes detected"
            ;;
    esac
}

summary() {
    echo
    echo "========================================="
    echo " Diff Summary"
    echo "========================================="

    echo "Tracked Resources: $STATE_RESOURCES"
    echo
    echo "Review:"
    echo "- Missing resources"
    echo "- Orphan resources"
    echo "- Partial apply leftovers"
}

check_state_resources
check_plan_diff
summary
