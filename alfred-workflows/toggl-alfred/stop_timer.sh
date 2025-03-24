DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$DIR/toggl_config.json"
API_TOKEN=$(jq -r '.api_token' "$CONFIG")
WORKSPACE_ID=$(jq -r '.workspace_id' "$CONFIG")

current_timer=$(curl -s -u "$API_TOKEN:api_token" \
  "https://api.track.toggl.com/api/v9/me/time_entries/current")

TIME_ENTRY_ID=$(echo "$current_timer" | jq -r '.id')
DESCRIPTION=$(echo "$current_timer" | jq -r ".description")

if [ "$TIME_ENTRY_ID" != "null" ]; then
  (curl -s -X PATCH "https://api.track.toggl.com/api/v9/workspaces/$WORKSPACE_ID/time_entries/$TIME_ENTRY_ID/stop" \
    -H "Content-Type: application/json" \
    -u "$API_TOKEN:api_token" | echo "🛑 ${DESCRIPTION}")
else
  echo "timer is not running"
fi