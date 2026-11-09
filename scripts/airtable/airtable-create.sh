#!/usr/bin/env bash
# Create a new task in Airtable
# Usage: ./airtable-create.sh <task-name> <project> [priority] [description]
# Priority: Low | Medium | High | Urgent (default: Medium)
# Example: ./airtable-create.sh "Implement user search endpoint" ProjectAlpha High "Add GET /users/search with query params"
set -euo pipefail

: "${AIRTABLE_TOKEN:?Error: AIRTABLE_TOKEN is not set. Add it to your .env file.}"
: "${AIRTABLE_BASE_ID:?Error: AIRTABLE_BASE_ID is not set. Add it to your .env file.}"

TASK_NAME="${1:?Usage: $0 <task-name> <project> [priority] [description]}"
PROJECT="${2:?Usage: $0 <task-name> <project>}"
PRIORITY="${3:-Medium}"
DESCRIPTION="${4:-}"

PAYLOAD=$(jq -n \
  --arg name "$TASK_NAME" \
  --arg project "$PROJECT" \
  --arg priority "$PRIORITY" \
  --arg desc "$DESCRIPTION" \
  '{
    fields: {
      "Task Name": $name,
      Project: $project,
      Priority: $priority,
      Status: "TO_DO",
      Description: (if $desc != "" then $desc else null end)
    }
  }')

curl -s -X POST \
  "https://api.airtable.com/v0/${AIRTABLE_BASE_ID}/Tasks" \
  -H "Authorization: Bearer ${AIRTABLE_TOKEN}" \
  -H "Content-Type: application/json" \
  -d "$PAYLOAD" \
| jq -r '"Created: \(.fields["Task Name"]) (ID: \(.id))"'
