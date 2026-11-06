#! /usr/bin/bash

set -e

WALLPAPER="$1"
matugen image "$WALLPAPER" \
    --source-color-index 0 \
    --json hex > ~/.config/angulia/colors.json
hyprctl reload