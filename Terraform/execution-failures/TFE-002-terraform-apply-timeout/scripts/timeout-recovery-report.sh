#!/bin/bash

TIMESTAMP=$(date)
SCENARIO="TFE-002 Terraform Apply Timeout"

echo "========================================="
echo " Terraform Timeout Recovery Report"
echo "========================================="
echo

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

    if [ $exit_code -eq 0 ]; then
        PLAN_STATUS="NO_CHANGES"
    elif [ $exit_code -eq 2 ]; then
        PLAN_STATUS="CHANGES_DETECTED"
    else
        PLAN_STATUS="FAILED"
    fi
}

generate_recommendation() {
    if [[ "$STATE_STATUS" == "HEALTHY" && "$PLAN_STATUS" == "NO_CHANGES" ]]; then
        RECOMMENDATION="Infrastructure likely stable"
    elif [[ "$STATE_STATUS" == "HEALTHY" && "$PLAN_STATUS" == "CHANGES_DETECTED" ]]; then
        RECOMMENDATION="Investigate resource status before recovery"
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
