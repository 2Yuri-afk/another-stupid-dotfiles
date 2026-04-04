# Import Current Theme
source "$HOME"/.config/rofi/applets/shared/theme.bash
theme="$type/$style"

# Theme Elements
prompt='Screenshot'
mesg="DIR: $HOME/Pictures/Screenshots"

# Vertical layout for text options
list_col='1'
list_row='4'
win_width='400px'

# Options - Text only
option_1="Whole Screen"
option_2="Select an Area"
option_3="Active Window"
option_4="Scan Text (Area)"

# Rofi CMD
rofi_cmd() {
	rofi -theme-str "window {width: $win_width;}" \
		-theme-str "listview {columns: $list_col; lines: $list_row;}" \
		-theme-str 'textbox-prompt-colon {str: "";}' \
		-dmenu \
		-p "$prompt" \
		-mesg "$mesg" \
		-markup-rows \
		-theme ${theme}
}

# Pass variables to rofi dmenu
run_rofi() {
	echo -e "$option_1\\n$option_2\\n$option_3\\n$option_4" | rofi_cmd
}

# Screenshot
time=`date +%Y-%m-%d-%H-%M-%S`
if command -v hyprctl >/dev/null 2>&1 && hyprctl monitors -j >/dev/null 2>&1; then
    geometry="$(hyprctl monitors -j | jq -r '.[0].width')x$(hyprctl monitors -j | jq -r '.[0].height')"
else
    geometry="1920x1080"  # fallback resolution
fi
dir="$HOME/Pictures/Screenshots"
file="Screenshot_${time}_${geometry}.png"

if [[ ! -d "$dir" ]]; then
	mkdir -p "$dir"
fi

# notify and view screenshot
notify_view() {
	# Prefer dunstify over notify-send
	if command -v dunstify > /dev/null 2>&1; then
		notify_cmd='dunstify -u low --replace=699'
	elif command -v notify-send > /dev/null 2>&1; then
		notify_cmd='notify-send -u normal -t 3000'
	else
		notify_cmd='echo'
	fi

	if [[ -e "$dir/$file" ]]; then
		${notify_cmd} "Screenshot Saved" "Saved to $dir/$file\nCopied to clipboard"
	else
		${notify_cmd} "Screenshot Failed" "Could not save screenshot"
	fi
}

# Copy screenshot to clipboard
copy_shot() {
	if command -v wl-copy > /dev/null 2>&1; then
		wl-copy --type image/png < "$dir/$file"
		if [[ $? -eq 0 ]]; then
			return 0
		else
			if command -v dunstify > /dev/null 2>&1; then
				dunstify -u critical --replace=699 "Clipboard Error" "Failed to copy to clipboard"
			fi
			return 1
		fi
	else
		if command -v dunstify > /dev/null 2>&1; then
			dunstify -u critical --replace=699 "Missing Package" "wl-clipboard not installed"
		fi
		return 1
	fi
}

# take shots
shotnow() {
	cd ${dir} && grim "$file"
	copy_shot
	notify_view
}

shotwin() {
	cd ${dir}
	# Add a 1 second delay to allow rofi applet to disappear
	sleep 1
	if command -v hyprctl > /dev/null 2>&1 && hyprctl activewindow -j > /dev/null 2>&1; then
		grim -g "$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')" "$file"
	else
		# Fallback to full screen if hyprctl not available
		grim "$file"
	fi
	copy_shot
	notify_view
}

shotarea() {
	cd ${dir} && grim -t png -g "$(slurp)" "$file"
	copy_shot
	notify_view
}


shotocr() {
	local tmp="/tmp/ocr_shot_$$.png"
	local selection
	selection="$(slurp)" || return 1
	grim -t png -g "$selection" "$tmp" || return 1

	if ! command -v tesseract > /dev/null 2>&1; then
		if command -v dunstify > /dev/null 2>&1; then
			dunstify -u critical --replace=699 "OCR Error" "tesseract not installed.\nRun: sudo pacman -S tesseract tesseract-data-eng"
		fi
		rm -f "$tmp"
		return 1
	fi

	local ocr_text
	ocr_text=$(tesseract "$tmp" stdout -l eng 2>/dev/null | sed '/^$/d')
	rm -f "$tmp"

	if [[ -z "$ocr_text" ]]; then
		if command -v dunstify > /dev/null 2>&1; then
			dunstify -u normal --replace=699 "OCR" "No text detected in selection."
		fi
		return 0
	fi

	echo -n "$ocr_text" | wl-copy

	local preview
	preview=$(echo "$ocr_text" | head -3)
	if command -v dunstify > /dev/null 2>&1; then
		dunstify -u low --replace=699 "OCR - Copied to Clipboard" "$preview"
	fi
}

# Execute Command
run_cmd() {
	if [[ "$1" == '--opt1' ]]; then
		shotnow
	elif [[ "$1" == '--opt2' ]]; then
		shotarea
	elif [[ "$1" == '--opt3' ]]; then
		shotwin
	elif [[ "$1" == '--opt4' ]]; then
		shotocr
	fi
}

# Actions
chosen="$(run_rofi)"

# Exit if nothing was chosen (ESC pressed or clicked away)
if [[ -z "$chosen" ]]; then
    exit 0
fi

case ${chosen} in
    $option_1)
		run_cmd --opt1
        ;;
    $option_2)
		run_cmd --opt2
        ;;
    $option_3)
		run_cmd --opt3
        ;;
    $option_4)
		run_cmd --opt4
        ;;
esac
