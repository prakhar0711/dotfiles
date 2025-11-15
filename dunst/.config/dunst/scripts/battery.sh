#!/bin/bash
LOCKFILE="/tmp/dunst-battery.lock"
LOGFILE="/tmp/dunst-battery-debug.log"

echo "$(date) - Script started" >> "$LOGFILE"

# If process is running and PID is valid, do not start a new one
if [ -f "$LOCKFILE" ] && kill -0 "$(cat "$LOCKFILE")" 2>/dev/null; then
    echo "$(date) - Lockfile exists and process is running. Exiting." >> "$LOGFILE"
    exit 0
fi

# Save current PID
echo $$ > "$LOCKFILE"
trap "rm -f $LOCKFILE" EXIT

BATTERY_LOW=10
BATTERY_CRITICAL=5

NOTIFY_EXPIRES=8000
SOUND_CRITICAL="/usr/share/sounds/freedesktop/stereo/suspend-error.oga"
SOUND_LOW="/usr/share/sounds/freedesktop/stereo/suspend-error.oga"

BATTERY_PATH="/sys/class/power_supply/BAT1"

while true; do
    if [ ! -d "$BATTERY_PATH" ]; then
        echo "$(date) - Battery path $BATTERY_PATH does not exist" >> "$LOGFILE"
        break
    fi

    BATTERY_LEVEL=$(cat "$BATTERY_PATH/capacity")
    CHARGING=$(grep -c "Charging" "$BATTERY_PATH/status")

    echo "$(date) - Battery level: $BATTERY_LEVEL | Charging: $CHARGING" >> "$LOGFILE"

    if [ "$CHARGING" -eq 0 ]; then
        if [ "$BATTERY_LEVEL" -le "$BATTERY_CRITICAL" ]; then
            echo "$(date) - Critical battery warning triggered" >> "$LOGFILE"
            dunstify -u critical -t "$NOTIFY_EXPIRES" \
                "Battery Critical!" "Battery is at ${BATTERY_LEVEL}% – Plug in now!" \
                -h string:x-dunst-stack-tag:battery
            [ -f "$SOUND_CRITICAL" ] && paplay "$SOUND_CRITICAL"
        elif [ "$BATTERY_LEVEL" -le "$BATTERY_LOW" ]; then
            echo "$(date) - Low battery warning triggered" >> "$LOGFILE"
            dunstify -u normal -t "$NOTIFY_EXPIRES" \
                "Battery Low" "Battery is at ${BATTERY_LEVEL}%." \
                -h string:x-dunst-stack-tag:battery
            [ -f "$SOUND_LOW" ] && paplay "$SOUND_LOW"
        else
            echo "$(date) - Battery level OK" >> "$LOGFILE"
        fi
    else
        echo "$(date) - Charging, skipping warning" >> "$LOGFILE"
    fi

    sleep 300
done

