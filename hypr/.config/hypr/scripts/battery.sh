#!/usr/bin/env bash
set -euo pipefail
export WAYLAND_DISPLAY="wayland-0"
export XDG_RUNTIME_DIR="/run/user/$(id -u)"

BATTERY=$(upower -e | grep -i 'BAT' | head -n1)

if [[ -z "$BATTERY" ]]; then
  echo "No battery found" >&2
  exit 1
fi

LOW_NOTIFIED=0
CRIT_NOTIFIED=0
LAST_STATE=""

notify_battery() {
  local urgency=$1 icon=$2 title=$3 body=$4
  notify-send -e -a "Battery" -u "$urgency" -i "$icon" "$title" "$body"
}

check_state() {
  local info pct state icon

  info=$(upower -i "$BATTERY")
  pct=$(echo "$info" | awk '/percentage/ {gsub("%","",$2); print int($2)}')
  state=$(echo "$info" | awk '/state/ {print $2}')

  case "$state" in
    charging)
      icon="battery-charging-symbolic"
      if [[ "$LAST_STATE" != "charging" ]]; then
        notify_battery normal "$icon" "Charger Connected" "Now charging (${pct}%)"
      fi
      LOW_NOTIFIED=0
      CRIT_NOTIFIED=0
      ;;
    discharging)
      icon="battery-good-symbolic"
      if [[ "$LAST_STATE" == "charging" || "$LAST_STATE" == "fully-charged" ]]; then
        notify_battery normal "battery-good-symbolic" "Charger Disconnected" "Discharging (${pct}%)"
      fi

      if (( pct <= 10 )) && [[ "$CRIT_NOTIFIED" -eq 0 ]]; then
        notify_battery critical "battery-caution-symbolic" "Battery Critical" "${pct}% remaining — plug in now"
        CRIT_NOTIFIED=1
      elif (( pct <= 20 )) && [[ "$LOW_NOTIFIED" -eq 0 ]]; then
        notify_battery normal "battery-low-symbolic" "Battery Low" "${pct}% remaining"
        LOW_NOTIFIED=1
      fi

      if (( pct > 20 )); then LOW_NOTIFIED=0; fi
      if (( pct > 10 )); then CRIT_NOTIFIED=0; fi
      ;;
    fully-charged)
      if [[ "$LAST_STATE" != "fully-charged" ]]; then
        notify_battery normal "battery-full-charged-symbolic" "Fully Charged" "Battery is at ${pct}%. You can unplug the charger."
      fi
      ;;
  esac

  LAST_STATE="$state"
}

# Run first evaluation check immediately on startup
check_state

# Monitor daemon/device triggers smoothly using standard output line streaming
stdbuf -oL upower --monitor | while read -r line; do
  if echo "$line" | grep -qE "device changed|daemon changed"; then
    check_state
  fi
done
