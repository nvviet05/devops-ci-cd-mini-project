#!/usr/bin/env bash
set -euo pipefail

URL="${1:-http://localhost:3000/health}"
MAX_RETRIES="${MAX_RETRIES:-20}"
SLEEP_SECONDS="${SLEEP_SECONDS:-2}"

echo "[INFO] Waiting for app health at ${URL}"

for i in $(seq 1 "$MAX_RETRIES"); do
  if curl -fsS "$URL" >/dev/null; then
    echo "[INFO] App is healthy on attempt ${i}"
    exit 0
  fi
  echo "[INFO] Attempt ${i}/${MAX_RETRIES} failed. Retrying in ${SLEEP_SECONDS}s..."
  sleep "$SLEEP_SECONDS"
done

echo "[ERROR] App did not become healthy in time."
exit 1
