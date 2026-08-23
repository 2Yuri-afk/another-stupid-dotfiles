-- ═══════════════════════════════════════════════════════════════════════════════
--  WINDOWS AND WORKSPACES
-- ═══════════════════════════════════════════════════════════════════════════════

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from apps
-- hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })

-- XWayland drag fix
-- hl.window_rule({ match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false }, no_focus = true })

-- feh (image viewer) — floating
hl.window_rule({ match = { class = "^(feh)$" }, float = true })

-- impala — floating + centered
hl.window_rule({ match = { title = "^(impala)$" }, float = true, size = "900 600", center = true })

-- bluetuith — floating + centered
hl.window_rule({ match = { title = "^(bluetuith)$" }, float = true, size = "900 600", center = true })

-- Waydroid — floating + centered
hl.window_rule({ match = { class = "^(Waydroid)$" }, float = true, size = "420 840", center = true })

-- mpv
hl.window_rule({ match = { class = "^(mpv)$" }, content = "none" })
