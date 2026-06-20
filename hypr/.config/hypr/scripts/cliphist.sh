#!/usr/bin/env bash

# Step A: If an argument ($1) is present, it means the user clicked an item.
# Decode it and pass it directly to wl-copy.
if [ -n "$1" ]; then
    echo "$1" | cliphist decode | wl-copy
    exit 0
fi

# Step B: If no argument is passed, Rofi is requesting data.
# Simply dump the raw history lines directly into the window.
cliphist list
