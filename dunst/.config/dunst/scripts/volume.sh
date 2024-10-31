#!/bin/bash

# System notifications script for brightness and volume using dunst

# Notification configuration
NOTIFY_EXPIRES=2000
PROGRESS_WIDTH=50
VOLUME_STEP=5
BRIGHTNESS_STEP=5

# Icons (you can replace these with custom icons)
VOLUME_MUTED="audio-volume-muted"
VOLUME_LOW="audio-volume-low"
VOLUME_MEDIUM="audio-volume-medium"
VOLUME_HIGH="audio-volume-high"
BRIGHTNESS_ICON="display-brightness"

# Volume Control
get_volume() {
    pamixer --get-volume
}

is_muted() {
    pamixer --get-mute
}

set_volume() {
    local volume=$1
    if [ "$volume" -lt 0 ]; then
        pamixer --set-volume 0
    elif [ "$volume" -gt 100 ]; then
        pamixer --set-volume 100
    else
        pamixer --set-volume "$volume"
    fi
}

# Brightness Control using brightnessctl
get_brightness() {
    brightnessctl -m | cut -d',' -f4 | tr -d '%'
}

set_brightness() {
    local direction=$1
    if [ "$direction" = "up" ]; then
        brightnessctl set "${BRIGHTNESS_STEP}%+" -q
    else
        brightnessctl set "${BRIGHTNESS_STEP}%-" -q
    fi
}

# Create progress bar
make_progress_bar() {
    local percent=$1
    local width=$2
    local filled=$(( width * percent / 100 ))
    local empty=$(( width - filled ))
    
    printf '█%.0s' $(seq 1 $filled)
    printf '░%.0s' $(seq 1 $empty)
}

# Show volume notification
show_volume_notification() {
    local volume=$(get_volume)
    local progress=$(make_progress_bar "$volume" "$PROGRESS_WIDTH")
    local icon

    if [ "$(is_muted)" = "true" ]; then
        icon=$VOLUME_MUTED
        progress="MUTED"
    elif [ "$volume" -lt 33 ]; then
        icon=$VOLUME_LOW
    elif [ "$volume" -lt 66 ]; then
        icon=$VOLUME_MEDIUM
    else
        icon=$VOLUME_HIGH
    fi

    dunstify -a "volume" -i "$icon" -t "$NOTIFY_EXPIRES" \
        -h string:x-dunst-stack-tag:volume \
        "Volume: ${volume}%" \
        "$progress"
}

# Show brightness notification
show_brightness_notification() {
    local brightness=$(get_brightness)
    local progress=$(make_progress_bar "$brightness" "$PROGRESS_WIDTH")

    dunstify -a "brightness" -i "$BRIGHTNESS_ICON" -t "$NOTIFY_EXPIRES" \
        -h string:x-dunst-stack-tag:brightness \
        "Brightness: ${brightness}%" \
        "$progress"
}

# Main command handler
case "$1" in
    volume)
        case "$2" in
            up)
                set_volume $(( $(get_volume) + VOLUME_STEP ))
                show_volume_notification
                ;;
            down)
                set_volume $(( $(get_volume) - VOLUME_STEP ))
                show_volume_notification
                ;;
            mute)
                pamixer --toggle-mute
                show_volume_notification
                ;;
            *)
                echo "Usage: $0 volume [up|down|mute]"
                exit 1
                ;;
        esac
        ;;
    brightness)
        case "$2" in
            up)
                set_brightness up
                show_brightness_notification
                ;;
            down)
                set_brightness down
                show_brightness_notification
                ;;
            *)
                echo "Usage: $0 brightness [up|down]"
                exit 1
                ;;
        esac
        ;;
    *)
        echo "Usage: $0 [volume|brightness] [up|down|mute]"
        exit 1
        ;;
esac
