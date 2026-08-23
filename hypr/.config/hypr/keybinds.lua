-- ═══════════════════════════════════════════════════════════════════════════════
--  KEYBINDINGS
-- ═══════════════════════════════════════════════════════════════════════════════

-- See https://wiki.hypr.land/Configuring/Basics/Binds/

local mainMod = "SUPER"

-- App launchers
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd(menu))

-- Window management
hl.bind(mainMod .. " + C",       hl.dsp.window.close())
hl.bind(mainMod .. " + M",       hl.dsp.exit())
hl.bind(mainMod .. " + F",       hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + D",       hl.dsp.window.pseudo())          -- dwindle
hl.bind(mainMod .. " + J",       hl.dsp.layout("togglesplit"))    -- dwindle

-- Utilities
hl.bind(mainMod .. " + W",       hl.dsp.exec_cmd("pkill waybar && waybar &"))  -- reload waybar
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.exec_cmd("zeditor dotfiles"))
hl.bind(mainMod .. " + SHIFT + A", function()
    local animationsEnabled = hl.get_config("animations.enabled")

    hl.config({
        animations = {
            enabled = not animationsEnabled,
        },
    })
end)

-- Move focus with arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "d" }))


-- ═══════════════════════════════════════════════════════════════════════════════
--  WORKSPACES & MONITORS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Laptop screen (eDP-1)
hl.workspace_rule({ workspace = 1, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 2, monitor = "eDP-1" })
hl.workspace_rule({ workspace = 3, monitor = "eDP-1" })

-- External monitor (HDMI-A-1)
hl.workspace_rule({ workspace = 4, monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 5, monitor = "HDMI-A-1" })
hl.workspace_rule({ workspace = 6, monitor = "HDMI-A-1" })

-- Switch workspaces
for i = 1, 6 do
    hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Navigate workspaces with arrows
hl.bind(mainMod .. " + up",   hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ workspace = "e+1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


-- ═══════════════════════════════════════════════════════════════════════════════
--  MULTIMEDIA KEYS
-- ═══════════════════════════════════════════════════════════════════════════════

-- Knob rotation (volume or brightness based on mode)
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/knob-mode.sh up"),   { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("~/.config/hypr/scripts/knob-mode.sh down"), { locked = true, repeating = true })

-- Knob click (double-click to toggle mode)
hl.bind("XF86AudioMute",    hl.dsp.exec_cmd("~/.config/hypr/scripts/knob-action.sh"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true, repeating = true })

-- Brightness (separate keys if your keyboard has them)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Media controls (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


-- ═══════════════════════════════════════════════════════════════════════════════
--  ROFI & EXTRAS
-- ═══════════════════════════════════════════════════════════════════════════════

hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.config/rofi/applets/bin/powermenu.sh"))
hl.bind(mainMod .. " + L",      hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + O",      hl.dsp.exec_cmd("hyprpicker -a"))
hl.bind(mainMod .. " + backslash",     hl.dsp.exec_cmd("~/.config/rofi/applets/bin/clipboard-manager.sh"))
hl.bind("PRINT",                hl.dsp.exec_cmd("~/.config/rofi/applets/bin/screenshot.sh"))
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd("~/.config/rofi/applets/bin/screenshot.sh"))

-- TUI apps in floating windows
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("kitty --title impala    -e impala"))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd("kitty --title bluetuith -e bluetuith"))
