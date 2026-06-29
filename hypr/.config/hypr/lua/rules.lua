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
