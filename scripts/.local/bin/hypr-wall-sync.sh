#!/usr/bin/env bash

# Waytrogen passes the selected wallpaper path as the second argument ($2)
WALLPAPER_PATH="$2"

# 1. Update a persistent symlink pointing to your current wallpaper
ln -sf "$WALLPAPER_PATH" $HOME/current_wallpaper.png 

# 2. Force hyprpaper to instantly preload and display the new image live
hyprctl hyprpaper preload "$WALLPAPER_PATH"
hyprctl hyprpaper wallpaper ",$WALLPAPER_PATH"
