#!/bin/bash

REPORT_FILE="state-recovery-report.txt"

echo "Generating state recovery report..."

{
    echo "========================================"
    echo "Terraform State Recovery Report"
    echo "========================================"
    echo ""

    echo "Timestamp:"
    date
    echo ""

    echo "State Check:"
    terraform state list || echo "FAILED"
    echo ""

    echo "Plan Check:"
    terraform plan || echo "FAILED"

} > "$REPORT_FILE" 2>&1

echo "Report generated: $REPORT_FILE"
