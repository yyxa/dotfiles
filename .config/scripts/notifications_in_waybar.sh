#!/usr/bin/env bash

# app="$SWAYNC_APP_NAME"
summary="$SWAYNC_SUMMARY"
body="$SWAYNC_BODY"

full="$summary - $body"

cleaned=$(echo "$full" | tr -d '\000-\037' | tr '\n' ' ')

if [ ${#cleaned} -gt 40 ]; then
    short="${cleaned:0:40}..."
else
    short="$cleaned"
fi

escaped_short=$(echo "$short" | sed 's/\\/\\\\/g; s/"/\\"/g')
escaped_full=$(echo "$cleaned" | sed 's/\\/\\\\/g; s/"/\\"/g')

echo "{\"text\": \"$escaped_short\", \"tooltip\": \"$escaped_full\"}" > /tmp/waybar_notifications


(sleep 15 && echo '{}' > /tmp/waybar_notifications) &