-- ═══════════════════════════════════════════════════════════════════════════════
--  GAMING PROFILE
-- ═══════════════════════════════════════════════════════════════════════════════

-- For CS2 / Steam games - disable compositor overhead
-- Usage: require this file manually or toggle via hyprctl

hl.config({
    decoration = {
        -- Disable blur and effects for games
        blur = {
            enabled = false,
        },

        -- Disable shadows
        shadow = {
            enabled = false,
        },

        -- Disable dimming
        dim_inactive = false,

        -- Reduce rounding for less overhead
        rounding = 0,
    },

    -- For Intel - allow tearing for less stutter
    general = {
        allow_tearing = true,
    },
})
