#!/usr/bin/env bash
set -euo pipefail

OUTPUT_DIR="${1:-artifacts}"
mkdir -p "${OUTPUT_DIR}"

echo "[INFO] Collecting docker compose logs..."
docker compose logs > "${OUTPUT_DIR}/docker-compose.log" || true

echo "[INFO] Collecting container list..."
docker ps -a > "${OUTPUT_DIR}/docker-ps.txt" || true

echo "[INFO] Artifacts saved to ${OUTPUT_DIR}"
