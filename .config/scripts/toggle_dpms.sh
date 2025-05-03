#!/usr/bin/env bash

state=$(hyprctl monitors | grep "DPMS: on")

if [ -n "$state" ]; then
    hyprctl dispatch dpms off
else
    hyprctl dispatch dpms on
fi
