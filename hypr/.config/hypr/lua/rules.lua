local workspace_assignments = {
    [1] = "^(kitty|Alacritty|foot|wezterm)$",
    [2] = "^([Ff]irefox|[Tt]horium)$",
    [3] = "^(org.gnome.Nautilus|org.kde.dolphin)$",
    [4] = "^([Ss]potify)$"
}

for ws, regex in pairs(workspace_assignments) do
    hl.window_rule({
        name      = "assign-workspace-" .. ws,
        match     = { class = regex },
        workspace = ws
    })
end

-- Core System Layout Behavior Rules
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = { class = "^$", title = "^$", xwayland = true, float = true },
    no_focus = true,
})

-- Terminal-specific opacity rules (Active: 0.9, Inactive: 0.5)
hl.window_rule({
    name    = "terminal-opacity-rules",
    match   = { class = "^(kitty|Alacritty|foot|wezterm)$" },
    opacity = "0.8 0.5"
})

hl.workspace_rule({ workspace = "1", monitor = "eDP-1", persistent = true, default_name = "terminal" })
hl.workspace_rule({ workspace = "2", monitor = "eDP-1", persistent = true, default_name = "browser" })
hl.workspace_rule({ workspace = "3", monitor = "eDP-1", persistent = true, default_name = "code" })
hl.workspace_rule({ workspace = "4", monitor = "eDP-1", persistent = true, default_name = "misc" })

hl.layer_rule({
    name = "noctalia",
    match = {
        namespace = "^noctalia-(bar-.+|notification|dock|panel|attached-panel|osd|window-switcher)$",
    },
    no_anim = true,
    ignore_alpha = 0.5,
    blur = true,
    blur_popups = true,
})
