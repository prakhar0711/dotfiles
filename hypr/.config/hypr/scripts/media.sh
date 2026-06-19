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
  
  # --- Filter State Handling ---
  case "$status" in
    Playing) 
      header="Playing: ${title}" 
      ;;
    *)       
      # Skips notify-send completely for 'Paused' or any other state
      continue 
      ;;
  esac

  # --- Fire Notification Only on True Playback ---
  if [[ -n "$artfile" && -f "$artfile" ]]; then
    notify-send -e -a "${player}" -i "$artfile" "$header" "$body"
  else
    notify-send -e -a "${player}" -i "$icon" "$header" "$body"
  fi
done
