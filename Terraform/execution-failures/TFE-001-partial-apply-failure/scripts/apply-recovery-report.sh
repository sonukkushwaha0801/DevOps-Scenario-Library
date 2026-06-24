#!/bin/bash

TIMESTAMP=$(date)
SCENARIO="TFE-001 Partial Apply Failure"

echo "========================================="
echo " Terraform Apply Recovery Report"
echo "========================================="
echo

echo "Generating report..."

STATE_STATUS="UNKNOWN"
PLAN_STATUS="UNKNOWN"

check_state() {
    terraform state list >/dev/null 2>&1
    if [ $? -eq 0 ]; then
        STATE_STATUS="HEALTHY"
    else
        STATE_STATUS="FAILED"
    fi
}

check_plan() {
    terraform plan >/dev/null 2>&1
    exit_code=$?

    if [ $exit_code -eq 0 ] || [ $exit_code -eq 2 ]; then
        PLAN_STATUS="EXECUTABLE"
    else
        PLAN_STATUS="FAILED"
    fi
}

generate_recommendation() {
    if [[ "$STATE_STATUS" == "HEALTHY" && "$PLAN_STATUS" == "EXECUTABLE" ]]; then
        RECOMMENDATION="Safe for controlled recovery actions"
    else
        RECOMMENDATION="Escalation recommended"
    fi
}

check_state
check_plan
generate_recommendation

echo "Scenario       : $SCENARIO"
echo "Timestamp      : $TIMESTAMP"
echo "State Status   : $STATE_STATUS"
echo "Plan Status    : $PLAN_STATUS"
echo "Recommendation : $RECOMMENDATION"

echo
echo "========================================="
echo " Report Complete"
echo "========================================="
