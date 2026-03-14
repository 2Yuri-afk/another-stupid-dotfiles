#!/bin/bash
# Apps Launcher - Only main applications (browsers, editors, games, etc.)

rofi -show drun \
    -no-show-icons \
    -drun-display-format "{name}" \
    -p "Run" \
    -theme ~/.config/rofi/applets/styles/launcher.rasi