#!/usr/bin/env bash

source ~/.cache/wal/colors.sh

swaylock \
  --clock \
  --font 'JetBrainsMono Nerd Font' \
  --font-size 24 \
  --indicator \
  --indicator-radius 100 \
  --indicator-thickness 10 \
  --image "$wallpaper" \
  --ring-color "$color4" \
  --key-hl-color "$color2" \
  --inside-color "$background" \
  --line-color 00000000 \
  --separator-color 00000000 \
  --text-color "$foreground" \
  --text-clear-color "$color10" \
  --text-ver-color "$color3" \
  --text-wrong-color "$color1" \
  --fade-in 0.3