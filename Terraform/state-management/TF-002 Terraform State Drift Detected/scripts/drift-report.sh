
#!/bin/bash

set -e

REPORT_FILE="drift-report.txt"

echo "========================================"
echo "Terraform Drift Report Generator"
echo "========================================"

echo ""
echo "Generating terraform plan..."

terraform plan > "$REPORT_FILE" 2>&1

echo ""
echo "Plan saved to $REPORT_FILE"

echo ""
echo "========================================"
echo "Drift Summary"
echo "========================================"

if grep -q "No changes" "$REPORT_FILE"; then
    echo "No drift detected."
else
    echo "Potential drift detected."
fi

echo ""
echo "Key indicators:"

grep -E "will be updated|must be replaced|will be destroyed|will be created" "$REPORT_FILE" || true

echo ""
echo "Full report available at: $REPORT_FILE"
