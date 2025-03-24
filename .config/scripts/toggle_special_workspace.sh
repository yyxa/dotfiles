#!/usr/bin/env bash

LAST_WS_FILE="/tmp/hypr_last_ws"
CURRENT_WS=$(hyprctl activeworkspace | grep -oP 'workspace ID \K\d+')

if [[ "$CURRENT_WS" == "100" ]]; then
    if [[ -f "$LAST_WS_FILE" ]]; then
        LAST_WS=$(cat "$LAST_WS_FILE")
        hyprctl dispatch workspace "$LAST_WS"
    else
        hyprctl dispatch workspace 100
    fi
else
    echo "$CURRENT_WS" > "$LAST_WS_FILE"
    hyprctl dispatch workspace 100
fi
