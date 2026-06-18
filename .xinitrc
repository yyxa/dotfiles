#!/bin/sh

feh --bg-scale /home/yyxa/dotfiles/images/1.jpg

while true; do
    vxwm
    echo "vxwm exited with code $? Restarting in 1 second..."
    sleep 1
done
