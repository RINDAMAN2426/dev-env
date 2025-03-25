INPUT="$*"
ACTION=$(echo "$INPUT" | awk '{print $1}')
ARGUMENT=$(echo "$INPUT" | cut -d' ' -f2-)
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ "$ACTION" = "start" ]; then
  output=$("$DIR/start_timer.sh" "$ARGUMENT")
elif [ "$ACTION" = "stop" ]; then
  output=$("$DIR/stop_timer.sh")
elif [ "$ACTION" = "continue" ]; then
  output=$("$DIR/continue_timer.sh")
else
  output="❌ Invalid command: $ACTION"
fi

echo "$output"