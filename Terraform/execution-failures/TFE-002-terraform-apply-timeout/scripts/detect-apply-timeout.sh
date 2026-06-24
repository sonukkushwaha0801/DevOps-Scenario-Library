#!/bin/bash

set +e

echo "========================================="
echo " Terraform Apply Timeout Detection Tool"
echo "========================================="
echo

LOG_FILE="${1:-terraform.log}"
TIMEOUT_FOUND=false

check_log_file() {
    echo "[INFO] Checking Terraform log file..."

    if [ ! -f "$LOG_FILE" ]; then
        echo "[WARN] Log file not found: $LOG_FILE"
        return
    fi

    echo "[INFO] Scanning log for timeout patterns..."

    patterns=(
        "timeout"
        "context deadline exceeded"
        "request timeout"
        "operation interrupted"
        "pipeline timeout"
        "signal: killed"
    )

    for pattern in "${patterns[@]}"; do
        if grep -iq "$pattern" "$LOG_FILE"; then
            echo "[ALERT] Timeout pattern found: $pattern"
            TIMEOUT_FOUND=true
        fi
    done
}

check_timeout_status() {
    echo
    echo "[INFO] Evaluating timeout indicators..."

    if [ "$TIMEOUT_FOUND" = true ]; then
        echo "[CRITICAL] Terraform apply timeout suspected"
    else
        echo "[PASS] No timeout indicators detected"
    fi
}

summary() {
    echo
    echo "========================================="
    echo " Detection Summary"
    echo "========================================="

    if [ "$TIMEOUT_FOUND" = true ]; then
        echo "[CRITICAL] Apply timeout detected"
        echo
        echo "Recommended next steps:"
        echo "1. Stop retry attempts"
        echo "2. Check resource status"
        echo "3. Validate Terraform state"
        echo "4. Choose recovery path"
    else
        echo "[PASS] No timeout signatures found"
    fi
}

check_log_file
check_timeout_status
summary