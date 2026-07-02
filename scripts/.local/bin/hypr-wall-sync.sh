#!/usr/bin/env bash

# Waytrogen passes the selected wallpaper path as the second argument ($2)
WALLPAPER_PATH="$2"

# Exit early if no wallpaper path was provided
if [ -z "$WALLPAPER_PATH" ]; then
    echo "No wallpaper path provided by Waytrogen."
    exit 1
fi

# 1. Update a persistent symlink pointing to your current wallpaper
ln -sf "$WALLPAPER_PATH" "$HOME/current_wallpaper.png"

# 2. Force hyprpaper to instantly preload and display the new image live
hyprctl hyprpaper preload "$WALLPAPER_PATH"
hyprctl hyprpaper wallpaper ",$WALLPAPER_PATH"

# 3. Clear pywal cache and generate new colors using the fixed symlink path
rm -rf "$HOME/.cache/wal/"
wal -i "$HOME/current_wallpaper.png"

# 4. Reload Quickshell to apply the new pywal colors
# (Using absolute path so the script works reliably regardless of where it's invoked)
if [ -f "$HOME/.config/quickshell/reload-quickshell.sh" ]; then
    "$HOME/.config/quickshell/reload-quickshell.sh"
else
    echo "Reload script not found, attempting direct quickshell reload..."
    pkill quickshell
    quickshell & disown
fi
