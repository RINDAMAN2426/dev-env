DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$DIR/toggl_config.json"
API_TOKEN=$(jq -r '.api_token' "$CONFIG")
WORKSPACE_ID=$(jq -r '.workspace_id' "$CONFIG")

last_entry=$(curl -s -u "$API_TOKEN:api_token" \
  "https://api.track.toggl.com/api/v9/me/time_entries?limit=1")
DESCRIPTION=$(echo "$last_entry" | jq -r '.[0].description')
PROJECT_ID=$(echo "$last_entry" | jq -r '.[0].project_id')

START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# body
json_payload=$(jq -n \
  --arg description "$DESCRIPTION" \
  --arg start "$START_TIME" \
  --argjson pid "${PROJECT_ID:-null}" \
  --argjson wid "${WORKSPACE_ID}" \
  --arg created_with "curl" \
  '{description: $description, start: $start, pid: $pid, wid: $wid, created_with: $created_with, duration: -1}')

(curl -s -X POST "https://api.track.toggl.com/api/v9/workspaces/$WORKSPACE_ID/time_entries" \
  -H "Content-Type: application/json" \
  -u "$API_TOKEN:api_token" \
  -d "$json_payload" | echo "🚀 ${DESCRIPTION}" )