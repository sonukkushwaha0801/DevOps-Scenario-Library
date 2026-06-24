#!/usr/bin/env bash

set -euo pipefail

LOG_DIR="./docker-diagnostics"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

mkdir -p "$LOG_DIR"

error_exit() {
    echo "[ERROR] $1"
    exit 1
}

if ! command -v docker >/dev/null 2>&1; then
    error_exit "Docker is not installed or not available in PATH."
fi

echo "=============================================="
echo " Docker Container Diagnostics Collector"
echo "=============================================="
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

OUTPUT_FILE="${LOG_DIR}/${CONTAINER}_${TIMESTAMP}.log"

echo
echo "[INFO] Collecting diagnostics for container: $CONTAINER"
echo "[INFO] Please wait..."
echo

{
    echo "=================================================="
    echo "Docker Container Diagnostics Report"
    echo "Container: $CONTAINER"
    echo "Timestamp: $(date)"
    echo "=================================================="

    echo
    echo "===== Container Status ====="
    docker ps -a | grep "$CONTAINER" || true

    echo
    echo "===== Container Inspect ====="
    docker inspect "$CONTAINER"

    echo
    echo "===== Container Logs ====="
    docker logs "$CONTAINER" 2>&1 || true

    echo
    echo "===== Exit Code ====="
    docker inspect "$CONTAINER" --format='{{.State.ExitCode}}' || true

    echo
    echo "===== Resource Stats ====="
    docker stats --no-stream "$CONTAINER" || true

    echo
    echo "===== Docker Info ====="
    docker info

    echo
    echo "===== Host Disk Usage ====="
    df -h

    echo
    echo "===== Host Memory Usage ====="
    free -h || true

} > "$OUTPUT_FILE"

echo "[SUCCESS] Diagnostics collected successfully."
echo "[INFO] Report saved at: $OUTPUT_FILE"
