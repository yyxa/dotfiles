#!/usr/bin/env bash

LAST_WS_FILE="/tmp/hypr_last_ws"

if [ -f "$LAST_WS_FILE" ]; then
    rm "$LAST_WS_FILE"
fi

TARGET_WS="$1"

ACTIVE_WINDOW_ID=$(hyprctl activewindow | grep -oP '(?<=Window\s)[^\s]+')
CURRENT_WORKSPACE_NAME=$(hyprctl clients | awk -v id="$ACTIVE_WINDOW_ID" '
    $2 == id {
        in_window = 1
    }
    in_window && /workspace:/ {
        match($0, /\(.*\)/)
        print substr($0, RSTART+1, RLENGTH-2)
        exit
    }')

if [[ ! "$CURRENT_WORKSPACE_NAME" =~ ^[0-9]+$ ]]; then
    hyprctl dispatch togglespecialworkspace $CURRENT_WORKSPACE_NAME
fi

hyprctl dispatch workspace $TARGET_WS
