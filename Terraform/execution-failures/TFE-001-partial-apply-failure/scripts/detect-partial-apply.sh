#!/bin/bash

set -e

echo "========================================="
echo " Terraform Partial Apply Detection Tool"
echo "========================================="
echo

LOG_FILE="${1:-terraform.log}"

ERROR_FOUND=false

check_log_file() {
    echo "[INFO] Checking Terraform log file..."

    if [ ! -f "$LOG_FILE" ]; then
        echo "[WARN] Log file not found: $LOG_FILE"
        return
    fi

    echo "[INFO] Scanning log for failure patterns..."

    patterns=(
        "Error:"
        "Request timeout"
        "Quota exceeded"
        "Permission denied"
        "Resource creation failed"
        "Error applying plan"
    )

    for pattern in "${patterns[@]}"; do
        if grep -q "$pattern" "$LOG_FILE"; then
            echo "[ALERT] Failure pattern found: $pattern"
            ERROR_FOUND=true
        fi
    done
}

check_terraform_state() {
    echo
    echo "[INFO] Checking Terraform state accessibility..."

    if terraform state list >/dev/null 2>&1; then
        echo "[PASS] Terraform state accessible"
    else
        echo "[FAIL] Terraform state inaccessible"
        ERROR_FOUND=true
    fi
}

check_partial_apply_indicators() {
    echo
    echo "[INFO] Checking partial apply indicators..."

    if [ "$ERROR_FOUND" = true ]; then
        echo "[ALERT] Potential partial apply failure detected"
    else
        echo "[PASS] No obvious partial apply indicators found"
    fi
}

summary() {
    echo
    echo "========================================="
    echo " Detection Summary"
    echo "========================================="

    if [ "$ERROR_FOUND" = true ]; then
        echo "[CRITICAL] Partial apply failure suspected"
        echo
        echo "Recommended next steps:"
        echo "1. Review apply logs"
        echo "2. Audit infrastructure"
        echo "3. Validate Terraform state"
        echo "4. Choose recovery path"
    else
        echo "[PASS] No critical indicators detected"
    fi
}

check_log_file
check_terraform_state
check_partial_apply_indicators
summary
