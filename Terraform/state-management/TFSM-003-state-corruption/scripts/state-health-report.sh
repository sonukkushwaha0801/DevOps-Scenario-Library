#!/bin/bash

REPORT_FILE="state-health-report.txt"

echo "Generating state health report..."

{
    echo "========================================"
    echo "Terraform State Health Report"
    echo "========================================"
    echo ""

    echo "Timestamp:"
    date
    echo ""

    echo "State Accessibility Check:"
    terraform state list || echo "FAILED"
    echo ""

    echo "Plan Check:"
    terraform plan || echo "FAILED"

} > "$REPORT_FILE" 2>&1

echo "Report generated: $REPORT_FILE"
