-- ═══════════════════════════════════════════════════════════════════════════════
--  INPUT
-- ═══════════════════════════════════════════════════════════════════════════════

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0.45,  -- -1.0 to 1.0, 0 = no modification

        touchpad = {
            natural_scroll = true,
        },
    },
})

-- Gestures
-- hl.gesture({
--     fingers = 3,
--     direction = "horizontal",
--     action = "workspace"
-- })

-- Per-device configs
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})

hl.device({
    name        = "tpps/2-elan-trackpoint",
    sensitivity = -0.5,  -- Disable TrackPoint (buttons handled by touchpad device)
})
