#!/usr/bin/env bash
# Upload a spec file to Telegram and send an approval request message
# Usage: ./upload-spec.sh <spec-file> <spec-id> <task-name> [project]
# Example: ./upload-spec.sh runtime/specs/SPEC-042.md SPEC-042 "User Search Endpoint" ProjectAlpha
set -euo pipefail

: "${TELEGRAM_BOT_TOKEN:?Error: TELEGRAM_BOT_TOKEN is not set. Add it to your .env file.}"
: "${TELEGRAM_CHAT_ID:?Error: TELEGRAM_CHAT_ID is not set. Add it to your .env file.}"

SPEC_FILE="${1:?Usage: $0 <spec-file> <spec-id> <task-name> [project]}"
SPEC_ID="${2:?Usage: $0 <spec-file> <spec-id> <task-name>}"
TASK_NAME="${3:?Usage: $0 <spec-file> <spec-id> <task-name>}"
PROJECT="${4:-}"

if [[ ! -f "$SPEC_FILE" ]]; then
  echo "Error: spec file not found: $SPEC_FILE" >&2
  exit 1
fi

# Upload the file as a document
curl -s -X POST \
  "https://api.telegram.org/bot${TELEGRAM_BOT_TOKEN}/sendDocument" \
  -F "chat_id=${TELEGRAM_CHAT_ID}" \
  -F "document=@${SPEC_FILE}" \
  -F "caption=Spec ready for review: ${SPEC_ID}" \
> /dev/null

# Send approval request message
PROJECT_LABEL=""
[[ -n "$PROJECT" ]] && PROJECT_LABEL=" for ${PROJECT}"

MESSAGE="Please review *${SPEC_ID}*${PROJECT_LABEL}: ${TASK_NAME}

Reply with:
• \`${SPEC_ID}:approved\` to proceed
• \`${SPEC_ID}:rejected <reason>\` to request changes"

bash "$(dirname "$0")/telegram-send.sh" "$MESSAGE"
echo "Spec ${SPEC_ID} uploaded and approval requested."
