
#!/usr/bin/env bash

# ==============================================================================
# Script Name : terraform-lock-investigator.sh
# Scenario    : TF-001 State Lock Not Released
# Purpose     : Investigate Terraform state lock issues safely
# Risk Level  : SAFE (Read Only)
# Version     : 1.0
# ==============================================================================

set -euo pipefail

SCRIPT_NAME=$(basename "$0")
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_FILE="terraform-lock-investigation-${TIMESTAMP}.log"

LOCK_TABLE="${LOCK_TABLE:-terraform-state-locks}"

log() {
    echo "[$(date '+%F %T')] $*" | tee -a "$REPORT_FILE"
}

section() {
    echo "" | tee -a "$REPORT_FILE"
    echo "====================================================" | tee -a "$REPORT_FILE"
    echo "$*" | tee -a "$REPORT_FILE"
    echo "====================================================" | tee -a "$REPORT_FILE"
}

check_dependency() {
    local binary="$1"

    if ! command -v "$binary" >/dev/null 2>&1; then
        log "ERROR: Required dependency not found: $binary"
        exit 1
    fi
}

section "TF-001 TERRAFORM LOCK INVESTIGATION"

log "Report File: $REPORT_FILE"

# ------------------------------------------------------------------------------
# Dependency Validation
# ------------------------------------------------------------------------------

section "DEPENDENCY VALIDATION"

check_dependency terraform

if command -v aws >/dev/null 2>&1; then
    AWS_AVAILABLE=true
    log "AWS CLI detected."
else
    AWS_AVAILABLE=false
    log "AWS CLI not detected."
fi

# ------------------------------------------------------------------------------
# Terraform Version
# ------------------------------------------------------------------------------

section "TERRAFORM VERSION"

terraform version | tee -a "$REPORT_FILE"

# ------------------------------------------------------------------------------
# Active Terraform Processes
# ------------------------------------------------------------------------------

section "ACTIVE TERRAFORM PROCESS CHECK"

if pgrep -fa terraform >/tmp/tf_processes.$$; then

    log "WARNING: Active Terraform processes detected."

    cat /tmp/tf_processes.$$ | tee -a "$REPORT_FILE"

    ACTIVE_PROCESS=true
else

    log "No active Terraform process detected."

    ACTIVE_PROCESS=false
fi

rm -f /tmp/tf_processes.$$ || true

# ------------------------------------------------------------------------------
# Workspace Information
# ------------------------------------------------------------------------------

section "WORKSPACE INFORMATION"

terraform workspace show 2>&1 | tee -a "$REPORT_FILE" || true

# ------------------------------------------------------------------------------
# State Accessibility Check
# ------------------------------------------------------------------------------

section "STATE ACCESSIBILITY CHECK"

if terraform state list >/tmp/tf_state.$$ 2>/tmp/tf_error.$$; then

    log "State accessible."

    RESOURCE_COUNT=$(wc -l < /tmp/tf_state.$$)

    log "Managed Resources: $RESOURCE_COUNT"

else

    log "State access failed."

    cat /tmp/tf_error.$$ | tee -a "$REPORT_FILE"

fi

rm -f /tmp/tf_state.$$ /tmp/tf_error.$$ || true

# ------------------------------------------------------------------------------
# Lock Acquisition Test
# ------------------------------------------------------------------------------

section "LOCK ACQUISITION TEST"

if terraform plan -lock-timeout=10s -refresh=false >/tmp/tf_plan.$$ 2>/tmp/tf_plan_err.$$; then

    log "Terraform lock acquisition succeeded."

    LOCK_STATUS="HEALTHY"

else

    log "Terraform plan failed."

    cat /tmp/tf_plan_err.$$ | tee -a "$REPORT_FILE"

    if grep -qi "state lock" /tmp/tf_plan_err.$$; then

        LOCK_STATUS="LOCK_DETECTED"

    else

        LOCK_STATUS="UNKNOWN"

    fi

fi

rm -f /tmp/tf_plan.$$ /tmp/tf_plan_err.$$ || true

# ------------------------------------------------------------------------------
# DynamoDB Investigation
# ------------------------------------------------------------------------------

if [ "$AWS_AVAILABLE" = true ]; then

    section "DYNAMODB LOCK INSPECTION"

    aws dynamodb scan \
        --table-name "$LOCK_TABLE" \
        --max-items 20 \
        2>&1 | tee -a "$REPORT_FILE" || true

fi

# ------------------------------------------------------------------------------
# Findings
# ------------------------------------------------------------------------------

section "FINDINGS"

log "Active Terraform Process : $ACTIVE_PROCESS"
log "Lock Status              : $LOCK_STATUS"

# ------------------------------------------------------------------------------
# Recommendation Engine
# ------------------------------------------------------------------------------

section "RECOMMENDATIONS"

if [ "$ACTIVE_PROCESS" = true ]; then

    cat <<EOF | tee -a "$REPORT_FILE"

ACTION:
Do NOT execute force-unlock.

Reason:
Active Terraform process detected.

Recommended Scenario Step:
Investigate lock ownership first.

EOF

elif [ "$LOCK_STATUS" = "LOCK_DETECTED" ]; then

    cat <<EOF | tee -a "$REPORT_FILE"

ACTION:
Potential stale lock detected.

Recommended Next Step:
Review TF-001 Recovery Procedure.

Validate:
1. No active Terraform process exists.
2. No CI/CD pipeline is running.
3. Lock ownership is understood.

Only then consider:
terraform force-unlock <LOCK_ID>

EOF

else

    cat <<EOF | tee -a "$REPORT_FILE"

No lock issue detected.

Further investigation required.

EOF

fi

section "INVESTIGATION COMPLETE"

log "Report saved to: $REPORT_FILE"
