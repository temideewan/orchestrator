#!/usr/bin/env bash
# Add a comment to an Airtable task record
# Usage: ./airtable-comment.sh <record-id> "comment text"
# Example: ./airtable-comment.sh recXXXXXXXXXX "Spec approved. Moving to IMPLEMENTING."
set -euo pipefail

: "${AIRTABLE_TOKEN:?Error: AIRTABLE_TOKEN is not set. Add it to your .env file.}"
: "${AIRTABLE_BASE_ID:?Error: AIRTABLE_BASE_ID is not set. Add it to your .env file.}"

RECORD_ID="${1:?Usage: $0 <record-id> <comment>}"
COMMENT="${2:?Usage: $0 <record-id> <comment>}"

curl -s -X POST \
  "https://api.airtable.com/v0/${AIRTABLE_BASE_ID}/Tasks/${RECORD_ID}/comments" \
  -H "Authorization: Bearer ${AIRTABLE_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "$(jq -n --arg text "$COMMENT" '{text: $text}')" \
| jq -r '"Comment added to \(.recordId)"'
