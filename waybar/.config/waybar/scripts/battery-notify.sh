#!/bin/bash

# Battery notification script for Waybar
# Sends notifications at critical battery levels

STATE_FILE="/tmp/battery-notify-state"
BATTERY_PATH="/sys/class/power_supply/BAT0"

# Check if battery exists
if [[ ! -d "$BATTERY_PATH" ]]; then
    # Try BAT1 if BAT0 doesn't exist
    BATTERY_PATH="/sys/class/power_supply/BAT1"
    if [[ ! -d "$BATTERY_PATH" ]]; then
        exit 0
    fi
fi

# Get battery info
CAPACITY=$(cat "$BATTERY_PATH/capacity" 2>/dev/null || echo "0")
STATUS=$(cat "$BATTERY_PATH/status" 2>/dev/null || echo "Unknown")

# Initialize state file if it doesn't exist
if [[ ! -f "$STATE_FILE" ]]; then
    echo "LAST_LEVEL=0" > "$STATE_FILE"
    echo "LAST_STATUS=Unknown" >> "$STATE_FILE"
    echo "NOTIFIED_10=false" >> "$STATE_FILE"
    echo "NOTIFIED_20=false" >> "$STATE_FILE"
    echo "NOTIFIED_100=false" >> "$STATE_FILE"
fi

# Load previous state
source "$STATE_FILE"

# Function to send notification
send_notification() {
    local urgency="$1"
    local title="$2"
    local message="$3"
    local icon="$4"
    local action="$5"
    local action_label="$6"
    
    if command -v dunstify > /dev/null 2>&1; then
        if [[ -n "$action" ]]; then
            # Send notification with action and execute command on click
            dunstify -u "$urgency" -i "$icon" -r 9991 \
                -A "default,$action_label" "$title" "$message" | while read -r response; do
                if [[ "$response" == "default" ]]; then
                    eval "$action" &
                fi
            done &
        else
            dunstify -u "$urgency" -i "$icon" -r 9991 "$title" "$message"
        fi
    elif command -v notify-send > /dev/null 2>&1; then
        notify-send -u "$urgency" -i "$icon" "$title" "$message"
    fi
}

# Reset notifications when charging or battery level increases significantly
if [[ "$STATUS" == "Charging" ]] || [[ "$CAPACITY" -gt "$LAST_LEVEL" ]]; then
    if [[ "$CAPACITY" -gt 20 ]]; then
        NOTIFIED_10=false
        NOTIFIED_20=false
    fi
    if [[ "$CAPACITY" -lt 100 ]]; then
        NOTIFIED_100=false
    fi
fi

# Check for critical battery (10%)
if [[ "$CAPACITY" -le 10 ]] && [[ "$STATUS" != "Charging" ]] && [[ "$NOTIFIED_10" == "false" ]]; then
    send_notification "critical" "Battery Critical" "Battery at ${CAPACITY}%! Click to switch to power-saver mode." "battery-caution" \
        "powerprofilesctl set power-saver && dunstify -u low 'Power Profile Changed' 'Switched to power-saver mode'" "Switch to Power-Saver"
    NOTIFIED_10=true
    NOTIFIED_20=true  # Don't show 20% notification if we already showed 10%
fi

# Check for low battery (20%)
if [[ "$CAPACITY" -le 20 ]] && [[ "$CAPACITY" -gt 10 ]] && [[ "$STATUS" != "Charging" ]] && [[ "$NOTIFIED_20" == "false" ]]; then
    send_notification "normal" "Battery Low" "Battery at ${CAPACITY}%. Click to switch to balanced mode." "battery-low" \
        "powerprofilesctl set balanced && dunstify -u low 'Power Profile Changed' 'Switched to balanced mode'" "Switch to Balanced"
    NOTIFIED_20=true
fi

# Check for full charge (100%)
if [[ "$CAPACITY" -eq 100 ]] && [[ "$STATUS" == "Charging" || "$STATUS" == "Full" ]] && [[ "$NOTIFIED_100" == "false" ]]; then
    send_notification "low" "Battery Full" "Battery fully charged at 100%." "battery-full-charged"
    NOTIFIED_100=true
fi

# Save current state
cat > "$STATE_FILE" << EOF
LAST_LEVEL=$CAPACITY
LAST_STATUS=$STATUS
NOTIFIED_10=$NOTIFIED_10
NOTIFIED_20=$NOTIFIED_20
NOTIFIED_100=$NOTIFIED_100
EOF
