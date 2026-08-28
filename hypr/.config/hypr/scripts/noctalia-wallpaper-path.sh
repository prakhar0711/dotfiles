#!/usr/bin/env bash

STATE_FILE="$HOME/.local/state/noctalia/settings.toml"
TARGET_LINK="$HOME/.cache/current_wallpaper"

if [[ -f "$STATE_FILE" ]]; then
    # Extract the first path = "..." entry from settings.toml
    WALLPAPER_PATH=$(sed -nE 's/^[[:space:]]*path[[:space:]]*=[[:space:]]*"([^"]+)".*/\1/p' "$STATE_FILE" | head -n 1)

    if [[ -n "$WALLPAPER_PATH" && -f "$WALLPAPER_PATH" ]]; then
        ln -sf "$WALLPAPER_PATH" "$TARGET_LINK"
    fi
fi

