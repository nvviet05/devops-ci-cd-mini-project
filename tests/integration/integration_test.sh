#!/usr/bin/env bash
set -euo pipefail

BASE_URL="${BASE_URL:-http://localhost:3000}"

echo "[INFO] Running integration tests against: ${BASE_URL}"

echo "[TEST] GET /health"
health_response=$(curl -sS "${BASE_URL}/health")
echo "${health_response}" | grep -q '"status":"ok"' || {
  echo "[ERROR] /health response invalid: ${health_response}"
  exit 1
}
echo "[PASS] GET /health"

echo "[TEST] GET /api/version"
version_response=$(curl -sS "${BASE_URL}/api/version")
echo "${version_response}" | grep -q '"version"' || {
  echo "[ERROR] /api/version response invalid: ${version_response}"
  exit 1
}
echo "[PASS] GET /api/version"

echo "[TEST] POST /api/echo"
echo_response=$(curl -sS -X POST "${BASE_URL}/api/echo" \
  -H "Content-Type: application/json" \
  -d '{"message":"hello-ci"}')
echo "${echo_response}" | grep -q '"message":"hello-ci"' || {
  echo "[ERROR] /api/echo response invalid: ${echo_response}"
  exit 1
}
echo "[PASS] POST /api/echo"

echo "[SUCCESS] All integration tests passed."
