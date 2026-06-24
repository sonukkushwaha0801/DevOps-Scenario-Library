#!/usr/bin/env bash

set -euo pipefail

error_exit() {
    echo "[ERROR] $1"
    exit 1
}

if ! command -v docker >/dev/null 2>&1; then
    error_exit "Docker is not installed or not available in PATH."
fi

echo "========================================="
echo " Docker Container Exit Code Analyzer"
echo "========================================="
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

echo
echo "[INFO] Container: $CONTAINER"
echo "[INFO] Exit Code: $EXIT_CODE"
echo

case "$EXIT_CODE" in
    0)
        echo "[ANALYSIS] Container exited successfully."
        echo "Possible Causes:"
        echo "- Main process completed normally"
        echo "- Application is designed to run as one-time task"
        ;;
    1)
        echo "[ANALYSIS] General application/runtime failure."
        echo "Possible Causes:"
        echo "- Application crash"
        echo "- Invalid startup command"
        echo "- Missing configuration"
        ;;
    125)
        echo "[ANALYSIS] Docker daemon failed to run container."
        echo "Possible Causes:"
        echo "- Invalid docker run command"
        echo "- Docker runtime issue"
        ;;
    126)
        echo "[ANALYSIS] Command invoked cannot execute."
        echo "Possible Causes:"
        echo "- Permission denied"
        echo "- Binary not executable"
        ;;
    127)
        echo "[ANALYSIS] Command not found."
        echo "Possible Causes:"
        echo "- Invalid CMD"
        echo "- Missing executable"
        echo "- Missing dependency"
        ;;
    130)
        echo "[ANALYSIS] Container terminated by SIGINT."
        echo "Possible Causes:"
        echo "- Manual interruption"
        ;;
    137)
        echo "[ANALYSIS] Container killed (SIGKILL)."
        echo "Possible Causes:"
        echo "- Out of Memory (OOM)"
        echo "- Forced termination"
        ;;
    139)
        echo "[ANALYSIS] Segmentation fault."
        echo "Possible Causes:"
        echo "- Application crash"
        echo "- Native library issue"
        ;;
    143)
        echo "[ANALYSIS] Container terminated by SIGTERM."
        echo "Possible Causes:"
        echo "- Graceful shutdown"
        echo "- Orchestrator stopped container"
        ;;
    *)
        echo "[ANALYSIS] Unknown exit code."
        echo "Recommended Actions:"
        echo "- Inspect logs"
        echo "- Inspect container config"
        echo "- Validate runtime behavior"
        ;;
esac

echo
echo "[NEXT STEPS]"
echo "1. Check container logs"
echo "2. Inspect container config"
echo "3. Validate startup command"
echo "4. Investigate root cause"
