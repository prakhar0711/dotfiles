-- Environment Variables
hl.env("ZDOTDIR", os.getenv("HOME") .. "/.config/zsh")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GTK_THEME", "Nordic")
hl.env("QT_STYLE_OVERRIDE", "Fusion")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XCURSOR_SIZE", "25")
hl.env("HYPRCURSOR_SIZE", "25")

-- Global Variable Definitions (Exported globally for binds/rules)
_G.terminal    = "kitty"
_G.fileManager = "dolphin"
_G.menu        = "rofi -show drun"
_G.browser     = "firefox"

-- Background Autostarts
hl.on("hyprland.start", function()
        hl.exec_cmd("hyprpaper &")
        hl.exec_cmd("nm-applet &")
        hl.exec_cmd("waybar &")
        hl.exec_cmd("cliphist daemon")
        hl.exec_cmd("blueman-applet")
        hl.exec_cmd("/home/prakhar/.local/bin/battery-notify.sh")
        hl.exec_cmd("mako &")
        hl.exec_cmd("wl-paste --type text --watch cliphist store")
        hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)
