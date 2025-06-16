#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
    echo ""
    exit
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

# Trim title to max 40 characters
max_length=25
if [[ ${#title} -gt $max_length ]]; then
    title="${title:0:$max_length}…"
fi

# Escape double quotes and backslashes in text for JSON
escaped_title=$(echo "$title" | sed 's/\\/\\\\/g; s/"/\\"/g')
escaped_artist=$(echo "$artist" | sed 's/\\/\\\\/g; s/"/\\"/g')

# Set icon based on status
icon=""
if [[ "$status" == "Playing" ]]; then
    icon=""
elif [[ "$status" == "Paused" ]]; then
    icon=""
fi

# Output JSON for Waybar
echo "{\"text\": \"$icon $escaped_title - $escaped_artist\", \"tooltip\": \"$escaped_artist - $escaped_title\", \"class\": \"$status\", \"alt\": \"$status\"}"

