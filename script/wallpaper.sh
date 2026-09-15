#! /usr/bin/bash
WALLPAPER="$1"
matugen image "$WALLPAPER" \
    --source-color-index 0 \
    --json hex > ~/.config/quickshell/angulia/theme/colors.json
awww img "$WALLPAPER" \
    --transition-fps=60 \
    --transition-type=random
hyprctl reload