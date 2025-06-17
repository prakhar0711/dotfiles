#!/bin/bash
LOCKFILE="/tmp/dunst-battery.lock"

# If process is running and PID is valid, do not start a new one
if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    exit 0
fi

# Save current PID
echo $$ > "$LOCKFILE"

# Clean up on script exit
trap "rm -f $LOCKFILE" EXIT
# Battery notification script using dunst

# Battery status constants
BATTERY_LOW=20
BATTERY_CRITICAL=5
BATTERY_CHARGING=1

# Notification settings
NOTIFY_EXPIRES=8000
SOUND_CRITICAL="/usr/share/sounds/freedesktop/stereo/suspend-error.oga"
SOUND_LOW="/usr/share/sounds/freedesktop/stereo/suspend-error.oga"

# Path to battery - modify if needed
BATTERY_PATH="/sys/class/power_supply/BAT1"

while true; do
    # Get battery percentage
    BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
    # Get charging status (1 if charging, 0 if discharging)
    CHARGING=$(cat "$BATTERY_PATH/status" | grep -c "Charging")

    # Check if battery is charging
    if [ "$CHARGING" -eq 0 ]; then
        if [ "$BATTERY_LEVEL" -le "$BATTERY_CRITICAL" ]; then
            # Critical battery notification
            dunstify -u critical -t "$NOTIFY_EXPIRES" \
                "Battery Critical!" \
                "Battery level is ${BATTERY_LEVEL}%\nPlug in your charger now!" \
                -h string:x-dunst-stack-tag:battery
            
            # Play critical sound if available
            [ -f "$SOUND_CRITICAL" ] && paplay "$SOUND_CRITICAL"
            
        elif [ "$BATTERY_LEVEL" -le "$BATTERY_LOW" ]; then
            # Low battery notification
            dunstify -u normal -t "$NOTIFY_EXPIRES" \
                "Battery Low" \
                "Battery level is ${BATTERY_LEVEL}%" \
                -h string:x-dunst-stack-tag:battery
            
            # Play low battery sound if available
            [ -f "$SOUND_LOW" ] && paplay "$SOUND_LOW"
        fi
    fi

    # Sleep for 5 minutes before checking again
    sleep 300
done
