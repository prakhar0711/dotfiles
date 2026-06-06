-- Global Variable Definitions (Exported globally for binds/rules)
_G.terminal    = "kitty"
_G.fileManager = "nautilus"
_G.menu        = "rofi -show drun"
_G.browser     = "firefox"

-- Environment Variables

hl.env("ZDOTDIR", os.getenv("HOME") .. "/.config/zsh")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GTK_THEME", "Material-Dark")
hl.env("QT_STYLE_OVERRIDE", "Fusion")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XCURSOR_SIZE", "25")
hl.env("HYPRCURSOR_SIZE", "25")
