-- ═══════════════════════════════════════════════════════════════════════════════
--  AUTOSTART
-- ═══════════════════════════════════════════════════════════════════════════════

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
    -- Status bar & wallpaper
    hl.exec_cmd("waybar &")
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd("hypridle")

    -- Clipboard manager (stores clipboard events in cliphist db)
    -- Two watchers: one for text, one for images
    hl.exec_cmd("wl-paste --watch cliphist store &")
    hl.exec_cmd("wl-paste --type image/png --watch cliphist store &")

    -- Cursor & icon theme (for GTK/XWayland apps)
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'Material Light Cursors'")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-size 24")
    hl.exec_cmd("gsettings set org.gnome.desktop.interface icon-theme NightElf-Icons")

    -- Authentication & secrets
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("gnome-keyring-daemon --start --components=secrets")
end)
