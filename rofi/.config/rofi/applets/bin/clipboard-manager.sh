#!/bin/bash

source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

prompt='Clipboard'

list_col='1'
list_row='6'
win_width='600px'

option_clear="<span color='#555e6b'> Clear History</span>"

rofi_cmd() {
    rofi -theme-str "window {width: $win_width;}" \
        -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -theme-str 'textbox-prompt-colon {str: "󰅌";}' \
        -theme-str 'element-text {horizontal-align: 0.0;}' \
        -dmenu \
        -markup-rows \
        -p "$prompt" \
        -theme "${theme}" \
        "$@"
}

clear_history() {
    cliphist wipe
    wl-copy -c
    if command -v dunstify > /dev/null 2>&1; then
        dunstify -u low --replace=700 "Clipboard" "History cleared"
    fi
}

run_rofi() {
    local history_ids=()
    local history_display=()

    history_ids+=("")
    history_display+=("${option_clear}")

    local cliphist_out
    cliphist_out=$(cliphist list 2>/dev/null)

    if [[ -n "$cliphist_out" ]]; then
        while IFS=$'\t' read -r entry_id entry_preview; do
            history_ids+=("$entry_id")
            history_display+=("${entry_preview//\x00/}")
        done <<< "$cliphist_out"
    else
        history_ids+=("")
        history_display+=("(No clipboard history)")
    fi

    local chosen_idx
    chosen_idx=$(printf '%s\n' "${history_display[@]}" | rofi_cmd -format i)

    [[ -z "$chosen_idx" ]] && exit 0

    local chosen_id="${history_ids[$chosen_idx]}"
    local chosen_display="${history_display[$chosen_idx]}"

    if [[ "$chosen_id" == "" && "$chosen_display" == "${option_clear}" ]]; then
        clear_history
    elif [[ -z "$chosen_id" || "$chosen_display" == "(No clipboard history)" ]]; then
        :
    else
        local tmpfile
        tmpfile=$(mktemp --suffix=.clip)

        cliphist list | awk -v id="$chosen_id" -F'\t' '$1 == id { print; exit }' \
            | cliphist decode > "$tmpfile"

        local mime_type
        mime_type=$(file --mime-type -b "$tmpfile")

        wl-copy -t "$mime_type" < "$tmpfile"
        rm -f "$tmpfile"

        if command -v dunstify > /dev/null 2>&1; then
            dunstify -u low --replace=700 "Clipboard" "Copied to clipboard"
        fi
    fi
}

run_rofi
