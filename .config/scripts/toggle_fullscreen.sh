#!/usr/bin/env bash

STATE=$(hyprctl activewindow | grep "fullscreen:" | awk '{print $2}')
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

WINDOW_COUNT=$(hyprctl clients | grep -c "workspace: [^ ]\+ ($CURRENT_WORKSPACE_NAME)")

if [ "$STATE" -eq 0 ]; then
    if [ "$WINDOW_COUNT" -gt 1 ]; then
        hyprctl dispatch fullscreen 1
    else
        hyprctl dispatch fullscreen 2
    fi
elif [ "$STATE" -eq 1 ]; then
    hyprctl dispatch fullscreen 2
else
    hyprctl dispatch fullscreen 0
fi