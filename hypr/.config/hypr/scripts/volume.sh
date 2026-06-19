#!/usr/bin/env bash
set -euo pipefail

make_bar() {
  local pct=$1 width=16
  local filled=$(( pct * width / 100 ))
  local empty=$(( width - filled ))
  printf '█%.0s' $(seq 1 $filled) 2>/dev/null
  printf '░%.0s' $(seq 1 $empty) 2>/dev/null
}

case "$1" in
  up)      wpctl set-volume -l 1.0 @DEFAULT_AUDIO_SINK@ 5%+ ;;
  down)    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%- ;;
  mute)    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle ;;
  micmute) wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle ;;
esac

if [[ "$1" == "micmute" ]]; then
  mic_raw=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@)
  muted=$(echo "$mic_raw" | grep -o MUTED || true)

  if [[ -n "$muted" ]]; then
    notify-send -e -a "Microphone" \
      -h string:x-canonical-private-synchronous:mic_osd \
      -h int:value:0 \
      -i "microphone-sensitivity-muted-symbolic" \
      "Microphone: Muted"
  else
    notify-send -e -a "Microphone" \
      -h string:x-canonical-private-synchronous:mic_osd \
      -h int:value:100 \
      -i "microphone-sensitivity-high-symbolic" \
      "Microphone: Unmuted"
  fi
  exit 0
fi

vol_raw=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
muted=$(echo "$vol_raw" | grep -o MUTED || true)
vol=$(echo "$vol_raw" | awk '{print int($2*100)}')

if [[ -n "$muted" ]]; then
  icon="audio-volume-muted-symbolic"
  vol=0
elif (( vol >= 70 )); then
  icon="audio-volume-high-symbolic"
elif (( vol >= 30 )); then
  icon="audio-volume-medium-symbolic"
else
  icon="audio-volume-low-symbolic"
fi

# bar=$(make_bar "$vol")

notify-send -e -a "Volume" \
  -h string:x-canonical-private-synchronous:volume_osd \
  -h int:value:"$vol" \
  -i "$icon" \
  "Volume: ${vol}%" 
