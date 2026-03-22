# Dotfiles

Personal configuration files for Linux desktop setup.

![Screenshot](screenshot.png)

## Contents

This repository contains configuration files for:
- Hyprland (window manager)
- Waybar (status bar)
- Rofi (application launcher)
- Kitty (terminal emulator)
- Fish (shell)
- Starship (prompt)
- Dunst (notifications)
- Btop (system monitor)
- Fastfetch (system info)
- MPV (media player)
- GTK themes (2.0, 3.0, 4.0)
- PipeWire and WirePlumber (audio)

## Installation

To install these dotfiles:

1. Clone this repository:
```bash
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles
```

2. Copy the configuration files to your home directory:
```bash
# For each directory, copy its contents to ~/.config/
cp -r hypr/* ~/.config/hypr/
cp -r waybar/* ~/.config/waybar/
cp -r rofi/* ~/.config/rofi/
cp -r kitty/* ~/.config/kitty/
cp -r fish/* ~/.config/fish/
cp -r starship/* ~/.config/starship/
cp -r dunst/* ~/.config/dunst/
cp -r btop/* ~/.config/btop/
cp -r fastfetch/* ~/.config/fastfetch/
cp -r mpv/* ~/.config/mpv/
cp -r gtk-* ~/.config/
cp -r pipewire/* ~/.config/pipewire/
cp -r wireplumber/* ~/.config/wireplumber/
```

3. Install required dependencies (example for Arch Linux):
```bash
sudo pacman -S hyprland waybar rofi kitty fish starship dunst btop fastfetch mpv pipewire wireplumber gtk3 gtk4
```

4. Set Fish as your default shell:
```bash
chsh -s /usr/bin/fish
```

5. Restart your session or reboot for changes to take effect.

## Customization

Feel free to modify any of the configuration files to suit your preferences. The screenshot shows the default appearance after installation.
