#!/bin/sh

while true; do
    vxwm
    echo "vxwm exited with code $? Restarting in 1 second..."
    sleep 1
done
