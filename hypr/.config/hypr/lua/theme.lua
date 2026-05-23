-- Monitors
hl.monitor({ output = "eDP-1", mode = "2560x1600@240", position = "0x0", scale = "1.25" })
hl.monitor({ output = "eDP-2", mode = "2560x1600@240", position = "0x0", scale = "1.6" })

-- General Look, Decoration & Hardware Configs
hl.config({
        general    = {
                gaps_in = 2,
                gaps_out = 0,
                border_size = 1,
                col = { active_border = "rgba(33ccffee)", inactive_border = "rgba(595959aa)" },
                resize_on_border = true,
                allow_tearing = false,
                layout = "dwindle",
        },
        decoration = {
                rounding = 5,
                rounding_power = 10,
                active_opacity = 1.0,
                inactive_opacity = 0.8,
                shadow = { enabled = false, range = 4, render_power = 3, color = "rgba(1a1a1aee)" },
                blur = { enabled = true, size = 6, passes = 3, vibrancy = 0.1696 },
        },
        input      = {
                kb_layout = "us",
                follow_mouse = 1,
                sensitivity = 0,
                touchpad = { natural_scroll = true },
        },
        dwindle    = { preserve_split = true },
        master     = { new_status = "master" },
        misc       = { force_default_wallpaper = 0, disable_hyprland_logo = true },
})

hl.device({ name = "epic-mouse-v1", sensitivity = -0.5 })

-- Animation Bezier Curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- Active Animations
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
