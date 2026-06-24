#!/usr/bin/env bash

set -euo pipefail

error_exit() {
    echo "[ERROR] $1"
    exit 1
}

if ! command -v docker >/dev/null 2>&1; then
    error_exit "Docker is not installed or not available in PATH."
fi

echo "=========================================="
echo " Docker Auto Root Cause Hint Engine"
echo "=========================================="
echo

echo "[INFO] Available Containers:"
docker ps -a
echo

read -rp "Enter Container ID or Name: " CONTAINER

if [[ -z "$CONTAINER" ]]; then
    error_exit "Container ID or Name cannot be empty."
fi

if ! docker inspect "$CONTAINER" >/dev/null 2>&1; then
    error_exit "Container '$CONTAINER' not found."
fi

EXIT_CODE=$(docker inspect "$CONTAINER" --format='{{.State.ExitCode}}')
LOGS=$(docker logs "$CONTAINER" 2>&1 | tail -n 50 || true)

echo
echo "=========================================="
echo " Analysis Result"
echo "=========================================="
echo "Container: $CONTAINER"
echo "Exit Code: $EXIT_CODE"
echo

ROOT_CAUSE="Unknown"
NEXT_ACTION="Inspect logs manually"

# Exit-code based analysis
case "$EXIT_CODE" in
    126)
        ROOT_CAUSE="Permission Issue"
        NEXT_ACTION="Check file permissions and executable flags"
        ;;
    127)
        ROOT_CAUSE="Command Not Found"
        NEXT_ACTION="Validate CMD, ENTRYPOINT, and installed binaries"
        ;;
    137)
        ROOT_CAUSE="OOM Kill or Forced Kill"
        NEXT_ACTION="Inspect memory usage and host resources"
        ;;
    139)
        ROOT_CAUSE="Segmentation Fault"
        NEXT_ACTION="Inspect application crash and native dependencies"
        ;;
esac

# Log pattern analysis
if echo "$LOGS" | grep -qi "permission denied"; then
    ROOT_CAUSE="Permission Denied"
    NEXT_ACTION="Fix file permissions or startup script permissions"
elif echo "$LOGS" | grep -qi "command not found"; then
    ROOT_CAUSE="Missing Command / Dependency"
    NEXT_ACTION="Validate binary paths and dependencies"
elif echo "$LOGS" | grep -qi "no such file or directory"; then
    ROOT_CAUSE="Missing File / Invalid Path"
    NEXT_ACTION="Validate mount paths, startup scripts, and file existence"
elif echo "$LOGS" | grep -qi "exec format error"; then
    ROOT_CAUSE="Architecture Mismatch"
    NEXT_ACTION="Validate image architecture vs host architecture"
elif echo "$LOGS" | grep -qi "connection refused"; then
    ROOT_CAUSE="Dependency Service Unavailable"
    NEXT_ACTION="Check database, cache, or external service connectivity"
elif echo "$LOGS" | grep -qi "out of memory"; then
    ROOT_CAUSE="Memory Exhaustion"
    NEXT_ACTION="Increase memory or optimize workload"
fi

echo "[LIKELY ROOT CAUSE]"
echo "$ROOT_CAUSE"
echo

echo "[RECOMMENDED NEXT ACTION]"
echo "$NEXT_ACTION"
echo

echo "[LAST 10 LOG LINES]"
echo "------------------------------------------"
echo "$LOGS" | tail -n 10
echo "------------------------------------------"
