-- ═══════════════════════════════════════════════════════════════════════════════
--  MONITORS
-- ═══════════════════════════════════════════════════════════════════════════════

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

-- laptop at left, external monitor at right
-- hl.monitor({ output = "eDP-1",    mode = "1920x1080@60",  position = "0x0",    scale = "1" })
-- hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@120", position = "1920x0", scale = "1" })

-- laptop at right, external monitor at left
hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@120", position = "auto-left", scale = "1" })
hl.monitor({ output = "eDP-1",    mode = "1920x1080@60",  position = "auto",      scale = "1" })
