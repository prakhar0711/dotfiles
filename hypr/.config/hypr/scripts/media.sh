#!/usr/bin/env bash

playerctl --follow metadata --format \
  '{{playerName}}|{{status}}|{{title}}|{{artist}}|{{mpris:artUrl}}' 2>/dev/null |
while IFS='|' read -r player status title artist art; do
  [[ -z "$title" ]] && continue

  icon="multimedia-player-symbolic"
  artfile=""
  if [[ "$art" == file://* ]]; then
    artfile="${art#file://}"
  fi

  body="${artist:-Unknown Artist}"
  case "$status" in
    Playing) header="Playing: ${title}" ;;
    Paused)  header="Paused: ${title}" ;;
    *)       continue ;;
  esac

  if [[ -n "$artfile" && -f "$artfile" ]]; then
    notify-send -e -a "${player}" \
      -h string:x-canonical-private-synchronous:media_osd \
      -i "$artfile" "$header" "$body"
  else
    notify-send -e -a "${player}" \
      -h string:x-canonical-private-synchronous:media_osd \
      -i "$icon" "$header" "$body"
  fi
done
