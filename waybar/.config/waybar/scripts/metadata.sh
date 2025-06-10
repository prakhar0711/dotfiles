
#!/bin/bash

status=$(playerctl status 2>/dev/null)

if [[ "$status" != "Playing" && "$status" != "Paused" ]]; then
    echo ""
    exit
fi

artist=$(playerctl metadata artist 2>/dev/null)
title=$(playerctl metadata title 2>/dev/null)

# Set icon based on status
icon=""  # Default Spotify icon

if [[ "$status" == "Playing" ]]; then
    icon=""
elif [[ "$status" == "Paused" ]]; then
    icon=""
fi

# Output JSON for Waybar
echo "{\"text\": \"$icon $title - $artist\", \"tooltip\": \"$artist - $title\", \"class\": \"$status\", \"alt\": \"$status\"}"

