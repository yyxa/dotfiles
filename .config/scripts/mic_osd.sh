#!/usr/bin/env bash

MUTE_STATE=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | grep -q MUTED && echo 1 || echo 0)

if [ "$MUTE_STATE" -eq 1 ]; then
    echo '{"text": "󰍭", "class": "mic-muted"}'
else
    echo '{}'
fi
