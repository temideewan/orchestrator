#!/usr/bin/env bash
# Update a task's status (and optionally spec link) in Airtable
# Usage: ./airtable-write.sh <record-id> <status> [spec-link] [assigned-to] [completion-pct]
# Example: ./airtable-write.sh recXXXXXXXXXX IMPLEMENTING runtime/specs/SPEC-001.md "projectalpha-backend" 0
set -euo pipefail

: "${AIRTABLE_TOKEN:?Error: AIRTABLE_TOKEN is not set. Add it to your .env file.}"
: "${AIRTABLE_BASE_ID:?Error: AIRTABLE_BASE_ID is not set. Add it to your .env file.}"

RECORD_ID="${1:?Usage: $0 <record-id> <status> [spec-link] [assigned-to] [completion-pct]}"
STATUS="${2:?Usage: $0 <record-id> <status>}"
SPEC_LINK="${3:-}"
ASSIGNED_TO="${4:-}"
COMPLETION="${5:-}"

PAYLOAD=$(jq -n \
  --arg status "$STATUS" \
  --arg spec "$SPEC_LINK" \
  --arg assigned "$ASSIGNED_TO" \
  --argjson pct "${COMPLETION:-null}" \
  '{
    fields: {
      Status: $status,
      "Spec Link": (if $spec != "" then $spec else null end),
      "Assigned To": (if $assigned != "" then $assigned else null end),
      "Completion (%)": $pct
    }
  }')

curl -s -X PATCH \
  "https://api.airtable.com/v0/${AIRTABLE_BASE_ID}/Tasks/${RECORD_ID}" \
  -H "Authorization: Bearer ${AIRTABLE_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
| jq -r '"Updated: \(.fields["Task Name"]) → \(.fields.Status)"'
