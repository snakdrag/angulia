#! /usr/bin/bash

set -e

WALLPAPER="$1"
awww img "$WALLPAPER" \
    --transition-fps=60 \
    --transition-type=random
matugen image "$WALLPAPER" \
    --source-color-index 0 \
    --json hex > ~/.config/quickshell/angulia/settings/colors.json
hyprctl reload