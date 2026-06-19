#!/usr/bin/env bash
set -euo pipefail

BATTERY=$(upower -e | grep -i 'BAT' | head -n1)

if [[ -z "$BATTERY" ]]; then
  echo "No battery found" >&2
  exit 1
fi

LOW_NOTIFIED=0
CRIT_NOTIFIED=0
LAST_STATE=""

make_bar() {
  local pct=$1 width=16
  local filled=$(( pct * width / 100 ))
  local empty=$(( width - filled ))
  printf '█%.0s' $(seq 1 $filled) 2>/dev/null
  printf '░%.0s' $(seq 1 $empty) 2>/dev/null
}

notify_battery() {
  local urgency=$1 icon=$2 title=$3 body=$4
  notify-send -e -a "Battery" -u "$urgency" \
    -h string:x-canonical-private-synchronous:battery_osd \
    -i "$icon" "$title" "$body"
}

check_state() {
  local info pct state icon bar

  info=$(upower -i "$BATTERY")
  pct=$(echo "$info" | awk '/percentage/ {gsub("%","",$2); print $2}')
  state=$(echo "$info" | awk '/state/ {print $2}')
  bar=$(make_bar "$pct")

  case "$state" in
    charging)
      icon="battery-charging-symbolic"
      if [[ "$LAST_STATE" != "charging" ]]; then
        notify_battery normal "$icon" "Charging" "${pct}%
${bar}"
      fi
      LOW_NOTIFIED=0
      CRIT_NOTIFIED=0
      ;;
    discharging)
      icon="battery-good-symbolic"
      if [[ "$LAST_STATE" == "charging" ]]; then
        notify_battery normal "battery-good-symbolic" "Unplugged" "${pct}%
${bar}"
      fi

      if (( pct <= 10 )) && [[ "$CRIT_NOTIFIED" -eq 0 ]]; then
        notify_battery critical "battery-caution-symbolic" "Battery Critical" "${pct}% remaining — plug in now
${bar}"
        CRIT_NOTIFIED=1
      elif (( pct <= 20 )) && [[ "$LOW_NOTIFIED" -eq 0 ]]; then
        notify_battery normal "battery-low-symbolic" "Battery Low" "${pct}% remaining
${bar}"
        LOW_NOTIFIED=1
      fi

      if (( pct > 20 )); then
        LOW_NOTIFIED=0
      fi
      if (( pct > 10 )); then
        CRIT_NOTIFIED=0
      fi
      ;;
    fully-charged)
      if [[ "$LAST_STATE" != "fully-charged" ]]; then
        notify_battery normal "battery-full-charged-symbolic" "Fully Charged" "${pct}%"
      fi
      ;;
  esac

  LAST_STATE="$state"
}

# Initial check on startup
check_state

# Listen for property changes
upower --monitor-detail | while read -r line; do
  if echo "$line" | grep -qE 'state|percentage'; then
    check_state
  fi
done
