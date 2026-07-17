#!/usr/bin/env bash
# Toggle gaming mode - disable compositor effects for max performance

GAMING_STATE_FILE="/tmp/hypr-gaming-mode"

if [ -f "$GAMING_STATE_FILE" ]; then
    # Disable gaming mode
    rm "$GAMING_STATE_FILE"
    hyprctl keyword decoration:blur true
    hyprctl keyword decoration:shadow true
    hyprctl keyword general:allow_tearing false
    hyprctl keyword animations:enabled true
    notify-send "Gaming Mode" "Disabled - compositor effects restored"
else
    # Enable gaming mode
    touch "$GAMING_STATE_FILE"
    hyprctl keyword decoration:blur false
    hyprctl keyword decoration:shadow false
    hyprctl keyword general:allow_tearing true
    hyprctl keyword animations:enabled false
    notify-send "Gaming Mode" "Enabled - compositor disabled for max FPS"
fi