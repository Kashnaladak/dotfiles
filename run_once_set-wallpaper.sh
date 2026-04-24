#!/bin/bash
WALLPAPER="$HOME/Documents/wallpapers/hellgate wallpaper.jpeg"
if [ -f "$WALLPAPER" ]; then
    osascript -e 'tell application "System Events" to set picture of every desktop to POSIX file "'"$WALLPAPER"'"'
fi
