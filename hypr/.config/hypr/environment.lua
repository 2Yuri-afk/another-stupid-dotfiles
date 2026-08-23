-- ═══════════════════════════════════════════════════════════════════════════════
--  ENVIRONMENT VARIABLES
-- ═══════════════════════════════════════════════════════════════════════════════

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("HYPRCURSOR_THEME", "Material Light Cursors")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XCURSOR_THEME", "Material Light Cursors")
hl.env("XCURSOR_SIZE", "24")

hl.env("GTK_THEME", "NightElf")

hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")


-- ═══════════════════════════════════════════════════════════════════════════════
--  PERMISSIONS
-- ═══════════════════════════════════════════════════════════════════════════════

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Uncomment to enforce permissions (requires restart)

-- hl.config({
--     ecosystem = {
--         enforce_permissions = true,
--     },
-- })
-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")
