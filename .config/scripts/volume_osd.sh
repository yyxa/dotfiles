#!/usr/bin/env bash

RAW=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
MUTED=$(echo "$RAW" | grep -q MUTED && echo 1 || echo 0)
VOLUME=$(echo "$RAW" | awk '{printf "%d", $2 * 100}')

ICON="󰖀"

if [ "$MUTED" -eq 1 ] || [ "$VOLUME" -eq 0 ]; then
    ICON="󰝟"
elif [ "$VOLUME" -le 33 ]; then
    ICON="󰕿"
elif [ "$VOLUME" -le 66 ]; then
    ICON="󰖀"
else
    ICON="󰕾"
fi

TEXT="${ICON} ${VOLUME}%"
[ "$MUTED" -eq 1 ] && TEXT="${ICON} 0%"

echo "{\"text\": \"$TEXT\", \"class\": \"volume-osd\"}"
