#!/bin/bash
# System notifications script for brightness and volume using dunst
# Notification configuration
NOTIFY_EXPIRES=2000
PROGRESS_WIDTH=50
VOLUME_STEP=5
MAX_VOLUME=150  # Maximum allowed volume with boost
VOLUME_WARNING_THRESHOLD=100  # Threshold for showing warning

# Icons (you can replace these with custom icons)
VOLUME_MUTED="audio-volume-muted"
VOLUME_LOW="audio-volume-low"
VOLUME_MEDIUM="audio-volume-medium"
VOLUME_HIGH="audio-volume-high"
VOLUME_BOOST="audio-volume-high"  # You might want a specific icon for boosted volume
BRIGHTNESS_DEVICE="intel_backlight" # Set the default brightness device
BRIGHTNESS_STEP=5                  # Percentage step for brightness adjustment
PROGRESS_WIDTH=10                   # Progress bar width
BRIGHTNESS_ICON="display-brightness" # Icon for brightness notification
NOTIFY_EXPIRES=2000                 # Notification duration (ms)
BRIGHTNESS_ICON="display-brightness"

# Volume Control
get_volume() {
    pamixer --get-volume --allow-boost
}

is_muted() {
    pamixer --get-mute
}

set_volume() {
    local volume=$1
    local current_volume=$(get_volume)
    
    if [ "$volume" -lt 0 ]; then
        pamixer --set-volume 0 --allow-boost
    elif [ "$volume" -gt "$MAX_VOLUME" ]; then
        pamixer --set-volume "$MAX_VOLUME" --allow-boost
    else
        pamixer --set-volume "$volume" --allow-boost
        # Show warning notification if crossing the normal threshold
        if [ "$current_volume" -le 100 ] && [ "$volume" -gt 100 ]; then
            show_volume_warning
        fi
    fi
}

# Show warning when enabling volume boost
show_volume_warning() {
    dunstify -a "volume" -i "dialog-warning" -t 3000 \
        -h string:x-dunst-stack-tag:volume_warning \
        "Volume Boost Enabled" \
        "Warning: High volume can damage your hearing"
}

# Create progress bar with boost indication
make_progress_bar() {
    local percent=$1
    local width=$2
    local normal_width=100
    local boost_width=$(( width * (percent - 100) / (MAX_VOLUME - 100) ))
    local normal_filled
    local boost_filled
    
    if [ "$percent" -le 100 ]; then
        normal_filled=$(( width * percent / 100 ))
        printf '█%.0s' $(seq 1 $normal_filled)
        printf '░%.0s' $(seq 1 $(( width - normal_filled )))
    else
        normal_filled=$width
        boost_filled=$(( width * (percent - 100) / (MAX_VOLUME - 100) ))
        printf '█%.0s' $(seq 1 $width)
        printf '░%.0s' $(seq 1 $boost_filled)
    fi
}

# Show volume notification
show_volume_notification() {
    local volume=$(get_volume)
    local progress=$(make_progress_bar "$volume" "$PROGRESS_WIDTH")
    local icon
    local volume_text="Volume: ${volume}%"
    
    if [ "$(is_muted)" = "true" ]; then
        icon=$VOLUME_MUTED
        progress="MUTED"
    elif [ "$volume" -gt 100 ]; then
        icon=$VOLUME_BOOST
        volume_text="Boosted Volume: ${volume}%"
    elif [ "$volume" -lt 33 ]; then
        icon=$VOLUME_LOW
    elif [ "$volume" -lt 66 ]; then
        icon=$VOLUME_MEDIUM
    else
        icon=$VOLUME_HIGH
    fi
    
    dunstify -a "volume" -i "$icon" -t "$NOTIFY_EXPIRES" \
        -h string:x-dunst-stack-tag:volume \
        "$volume_text" \
        "$progress"
}

# Get current brightness
get_brightness() {
    brightnessctl -d "$BRIGHTNESS_DEVICE" -m | cut -d',' -f4 | tr -d '%'
}

# Set brightness
set_brightness() {
    local direction=$1
    if [ "$direction" = "up" ]; then
        brightnessctl -d "$BRIGHTNESS_DEVICE" set "${BRIGHTNESS_STEP}%+" -q
    else
        brightnessctl -d "$BRIGHTNESS_DEVICE" set "${BRIGHTNESS_STEP}%-" -q
    fi
}

# # Make progress bar
# make_progress_bar() {
#     local value=$1
#     local max_width=$2
#     local filled=$((value * max_width / 100))
#     local empty=$((max_width - filled))
#     printf "%s%s" "$(printf '█%.0s' $(seq 1 $filled))" "$(printf '░%.0s' $(seq 1 $empty))"
# }

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
