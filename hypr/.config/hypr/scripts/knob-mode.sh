#!/bin/bash
STATE_FILE="/tmp/knob_mode"
[ ! -f "$STATE_FILE" ] && echo "volume" > "$STATE_FILE"

MODE=$(cat "$STATE_FILE")

if [ "$1" = "toggle" ]; then
    if [ "$MODE" = "volume" ]; then
        echo "brightness" > "$STATE_FILE"
        notify-send "Knob mode: Brightness"
    else
        echo "volume" > "$STATE_FILE"
        notify-send "Knob mode: Volume"
    fi
    exit 0
fi

if [ "$1" = "get" ]; then
    echo "$MODE"
    exit 0
fi

if [ "$1" = "up" ]; then
    if [ "$MODE" = "volume" ]; then
        wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
    else
        brightnessctl -e4 -n2 set 5%+
    fi
    exit 0
fi

if [ "$1" = "down" ]; then
    if [ "$MODE" = "volume" ]; then
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    else
        brightnessctl -e4 -n2 set 5%-
    fi
    exit 0
fi
