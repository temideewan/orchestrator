#!/usr/bin/env bash
# Poll Telegram for new messages (single poll, not a loop)
# Usage: ./telegram-receive.sh [timeout_seconds]
# Reads offset from runtime/telegram_offset.txt, advances it after receiving
# Used by wait-for-approval.sh as a building block
set -euo pipefail

: "${TELEGRAM_BOT_TOKEN:?Error: TELEGRAM_BOT_TOKEN is not set. Add it to your .env file.}"

TIMEOUT="${1:-0}"
OFFSET_FILE="runtime/telegram_offset.txt"

OFFSET=0
if [[ -f "$OFFSET_FILE" ]]; then
  OFFSET=$(cat "$OFFSET_FILE")
fi

RESPONSE=$(curl -s \
  "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/getUpdates?timeout=${TIMEOUT}&offset=${OFFSET}")

# Advance offset if there are updates
UPDATE_COUNT=$(echo "$RESPONSE" | jq '.result | length')
if [[ "$UPDATE_COUNT" -gt 0 ]]; then
  LAST_ID=$(echo "$RESPONSE" | jq '.result[-1].update_id')
  echo "$((LAST_ID + 1))" > "$OFFSET_FILE"
fi

# Output messages as lines: "update_id|text"
echo "$RESPONSE" | jq -r '.result[] | "\(.update_id)|\(.message.text // "")"'
