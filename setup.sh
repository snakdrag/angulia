#! /usr/bin/bash

rsync ~/.config/quickshell/angulia/setup/hyprland.lua ~/.config/hypr/
rsync ~/.config/quickshell/angulia/setup/shell.qml ~/.config/quickshell/
rsync ~/.config/quickshell/angulia/setup/angulia ~/.config/

pkill qs & pkill quickshell
qs & disown