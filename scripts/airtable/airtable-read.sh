#!/usr/bin/env bash
# Fetch tasks from Airtable by status and optional project
# Usage: ./airtable-read.sh [STATUS] [PROJECT]
# STATUS defaults to TO_DO
# Example: ./airtable-read.sh IMPLEMENTING ProjectAlpha
set -euo pipefail

: "${AIRTABLE_TOKEN:?Error: AIRTABLE_TOKEN is not set. Add it to your .env file.}"
: "${AIRTABLE_BASE_ID:?Error: AIRTABLE_BASE_ID is not set. Add it to your .env file.}"

STATUS="${1:-TO_DO}"
PROJECT="${2:-}"

if [[ -n "$PROJECT" ]]; then
  FORMULA=$(printf 'AND({Status}="%s",{Project}="%s")' "$STATUS" "$PROJECT")
else
  FORMULA=$(printf '{Status}="%s"' "$STATUS")
fi

ENCODED=$(python3 -c "import urllib.parse, sys; print(urllib.parse.quote(sys.argv[1]))" "$FORMULA")

curl -s \
  "https://api.airtable.com/v0/${AIRTABLE_BASE_ID}/Tasks?filterByFormula=${ENCODED}&maxRecords=10" \
  -H "Authorization: Bearer ${AIRTABLE_TOKEN}" \
  -H "Content-Type: application/json" \
| jq -r '.records[] | "ID: \(.id)\nTask: \(.fields["Task Name"])\nStatus: \(.fields.Status)\nPriority: \(.fields.Priority // "none")\nProject: \(.fields.Project // "none")\n---"'
