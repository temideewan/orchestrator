#!/usr/bin/env bash
# Wait for spec approval via Telegram with progressive backoff
# Usage: ./wait-for-approval.sh <spec-id> [timeout_minutes]
# Exits 0 with "approved" on stdout if approved
# Exits 1 with rejection reason on stdout if rejected
# Exits 2 if overall timeout is reached (default: 60 min)
#
# Example: ./wait-for-approval.sh SPEC-042 30
set -euo pipefail

: "${TELEGRAM_BOT_TOKEN:?Error: TELEGRAM_BOT_TOKEN is not set. Add it to your .env file.}"

SPEC_ID="${1:?Usage: $0 <spec-id> [timeout_minutes]}"
TIMEOUT_MINUTES="${2:-60}"
TIMEOUT_SECONDS=$((TIMEOUT_MINUTES * 60))

SCRIPT_DIR="$(dirname "$0")"
START_TIME=$(date +%s)

echo "Waiting for ${SPEC_ID} approval (timeout: ${TIMEOUT_MINUTES}min)..."

poll_once() {
  local poll_timeout="${1:-0}"
  bash "$SCRIPT_DIR/telegram-receive.sh" "$poll_timeout"
}

check_messages() {
  while IFS='|' read -r update_id text; do
    [[ -z "$text" ]] && continue

    if echo "$text" | grep -q "^${SPEC_ID}:approved"; then
      echo "approved"
      return 0
    fi

    if echo "$text" | grep -q "^${SPEC_ID}:rejected"; then
      REASON=$(echo "$text" | sed "s/^${SPEC_ID}:rejected *//")
      echo "rejected: ${REASON}"
      return 1
    fi
  done
}

while true; do
  ELAPSED=$(( $(date +%s) - START_TIME ))

  if [[ $ELAPSED -ge $TIMEOUT_SECONDS ]]; then
    echo "timeout: No response received within ${TIMEOUT_MINUTES} minutes" >&2
    exit 2
  fi

  # Progressive backoff based on elapsed time
  if [[ $ELAPSED -lt 60 ]]; then
    POLL_INTERVAL=1
  elif [[ $ELAPSED -lt 300 ]]; then
    POLL_INTERVAL=60
  elif [[ $ELAPSED -lt 600 ]]; then
    POLL_INTERVAL=300
  else
    POLL_INTERVAL=600
  fi

  RESULT=$(poll_once 0) || true

  if [[ -n "$RESULT" ]]; then
    OUTCOME=$(echo "$RESULT" | check_messages) && STATUS=$? || STATUS=$?
    if [[ -n "$OUTCOME" ]]; then
      echo "$OUTCOME"
      exit $STATUS
    fi
  fi

  sleep "$POLL_INTERVAL"
done
