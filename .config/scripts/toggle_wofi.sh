#!/usr/bin/env bash

if pgrep -fx "wofi -n" > /dev/null; then
    pkill -fx "wofi -n"
else
    env GTK_THEME=$(cat ~/.cache/wal/colors.css | grep 'gtk-theme-name' | cut -d '=' -f2) \
    XDG_CONFIG_HOME=$HOME/.config \
    wofi -n &
fi
