if status is-interactive
# Commands to run in interactive sessions can go here
end

set -g fish_greeting ""

abbr i "paru -S"
abbr ui "paru -Rns"
abbr update "paru -Syyu"
abbr ff "fastfetch"
abbr cls "clear"
abbr ports "ss -tulpn"
abbr myip "curl ifconfig.me"
abbr weather "curl wttr.in"


# hypr
abbr keybinds "zeditor .config/hypr/keybinds.conf"
abbr autostart "zeditor .config/hypr/autostart.conf"
abbr monitors "zeditor .config/hypr/monitors.conf"
abbr programs "zeditor .config/hypr/programs.conf"
abbr input "zeditor .config/hypr/input.conf"
abbr environment "zeditor .config/hypr/environment.conf"
abbr keybinds "zeditor .config/hypr/keybinds.conf"
abbr windowrules "zeditor .config/hypr/windowrules.conf"
abbr appearance "zeditor .config/hypr/appearance.conf"


# Starship
starship init fish | source
