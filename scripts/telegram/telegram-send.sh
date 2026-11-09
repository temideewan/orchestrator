#!/usr/bin/env bash
# Send a message to your Telegram chat
# Usage: ./telegram-send.sh "message text"
# Example: ./telegram-send.sh "SPEC-042 is ready for review"
set -euo pipefail

: "${TELEGRAM_BOT_TOKEN:?Error: TELEGRAM_BOT_TOKEN is not set. Add it to your .env file.}"
: "${TELEGRAM_CHAT_ID:?Error: TELEGRAM_CHAT_ID is not set. Add it to your .env file.}"

MESSAGE="${1:?Usage: $0 <message>}"

curl -s -X POST \
  "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendMessage" \
  -H "Content-Type: application/json" \
  -d "$(jq -n \
    --arg chat "$TELEGRAM_CHAT_ID" \
    --arg text "$MESSAGE" \
    '{chat_id: $chat, text: $text, parse_mode: "Markdown"}')" \
| jq -r 'if .ok then "Sent: \(.result.message_id)" else "Error: \(.description)" end'
