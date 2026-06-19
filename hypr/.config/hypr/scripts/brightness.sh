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
  up)   brightnessctl set 5%+ -q ;;
  down) brightnessctl set 5%- -q ;;
esac

current=$(brightnessctl get)
max=$(brightnessctl max)
pct=$(( current * 100 / max ))
bar=$(make_bar "$pct")

notify-send -e -a "Brightness" \
  -h string:x-canonical-private-synchronous:brightness_osd \
  -h int:value:"$pct" \
  -i "display-brightness-symbolic" \
  "Brightness: ${pct}%" "${bar}"
