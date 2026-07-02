-- Layer shell animations (for popups, notifications, etc.)
hl.layer_rule({
    name = "quickshell-base",
    match = { namespace = "^(quickshell.*)$" },
    blur = true,
    ignore_alpha = 0.3,
})

-- Smooth animations for layer surfaces
hl.animation({
    leaf = "layersIn",
    enabled = true,
    speed = 4,
    bezier = "default", -- Changed 'curve' to 'bezier'
    style = "popin 80%"
})
hl.animation({
    leaf = "layersOut",
    enabled = true,
    speed = 3,
    bezier = "default", -- Fixed from 'curve'
    style = "popin 80%"
})
-- Specific layer rules for notification popups
-- hl.layer_rule({
--     name = "quickshell-notifications-noanim",
--     match = { namespace = "notifications" },
--     no_anim = true
-- })

-- Window rules for QuickShell windows
hl.window_rule({
    name = "quickshell-float",
    match = { class = "^(quickshell)$" },
    float = true,
})

hl.window_rule({
    name = "quickshell-noblur",
    match = {
        class = "^(quickshell)$",
        title = "^(quickshell)$"
    },
    no_blur = true,
})

-- Alternative: Disable animations only for notification layer
-- hl.layer_rule({
--     name = "quickshell-popups-noanim",
--     match = { namespace = "^(.*NotificationPopups.*)$" },
--     no_anim = true
-- })
