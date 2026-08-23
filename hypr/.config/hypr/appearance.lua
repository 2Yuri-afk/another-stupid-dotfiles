-- ═══════════════════════════════════════════════════════════════════════════════
--  LOOK AND FEEL
-- ═══════════════════════════════════════════════════════════════════════════════

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in  = 6,
        gaps_out = 12,

        border_size = 0,

        -- Use color variables from colors.lua
        col = {
            active_border   = active_border,
            inactive_border = inactive_border,
        },

        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding = 3,

        -- Window transparency
        active_opacity     = 0.98,
        inactive_opacity   = 0.93,
        fullscreen_opacity = 1.0,

        -- Shadows
        shadow = {
            enabled      = true,
            range        = 20,
            render_power = 3,
            color        = "rgba(0a0f1499)",
            offset       = "0 4",
            scale        = 1,
        },

        -- Blur
        blur = {
            enabled            = true,
            size               = 6,
            passes             = 3,
            new_optimizations  = true,
            xray               = false,
            ignore_opacity     = false,
            noise              = 0.02,
            contrast           = 1.1,
            brightness         = 1.0,
            vibrancy           = 0.3,
            vibrancy_darkness  = 0.2,
            popups             = true,
            popups_ignorealpha = 0.6,
        },

        -- Dim inactive windows
        dim_inactive = true,
        dim_strength = 0.1,
        dim_special  = 0.4,
    },

    animations = {
        enabled = false,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = true,
    },
})

-- Animation curves and definitions
hl.curve("fast", { type = "bezier", points = { {0.5, 0.9}, {0.3, 1.0} } })

hl.animation({ leaf = "windows",    enabled = true, speed = 1, bezier = "fast" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1, bezier = "fast" })
hl.animation({ leaf = "fade",       enabled = true, speed = 1, bezier = "fast" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, bezier = "fast" })

-- Uncomment for "smart gaps" (no gaps when only one window)
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({ match = { float = false, workspace = "w[tv1]" }, border_size = 0, rounding = 0 })
-- hl.window_rule({ match = { float = false, workspace = "f[1]" },   border_size = 0, rounding = 0 })
