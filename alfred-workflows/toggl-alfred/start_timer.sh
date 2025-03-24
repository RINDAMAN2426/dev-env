DESCRIPTION="$1"

if [ -z "$DESCRIPTION" ]; then
  echo "❌ Description required"
  exit 1
fi

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$DIR/toggl_config.json"
API_TOKEN=$(jq -r '.api_token' "$CONFIG")
WORKSPACE_ID=$(jq -r '.workspace_id' "$CONFIG")

START_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# check running timer
current_timer=$(curl -s -u "$API_TOKEN:api_token" \
  "https://api.track.toggl.com/api/v9/me/time_entries/current")

current_id=$(echo "$current_timer" | jq -r '.id')

if [ "$current_id" != "null" ]; then
  current_desc=$(echo "$current_timer" | jq -r '.description')
  echo "timer is already running"
  exit 1
fi


## body
json_payload=$(jq -n \
  --arg description "$DESCRIPTION" \
  --arg start "$START_TIME" \
  --arg wid "$WORKSPACE_ID" \
  --arg created_with "alfred" \
  '{description: $description, start: $start, wid: ($wid|tonumber), created_with: $created_with, duration: -1}')

# 요청
response=$(curl -s -X POST "https://api.track.toggl.com/api/v9/workspaces/$WORKSPACE_ID/time_entries" \
  -H "Content-Type: application/json" \
  -u "$API_TOKEN:api_token" \
  -d "$json_payload")

# 결과 출력
desc=$(echo "$response" | jq -r '.description')
echo "🚀 Started: $desc"