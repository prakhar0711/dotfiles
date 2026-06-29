hl.on("hyprland.start", function()
    hl.exec_cmd("~/.config/hypr/scripts/battery.sh &")
    -- hl.exec_cmd("~/.config/hypr/scripts/network.sh &")
    -- hl.exec_cmd("~/.config/hypr/scripts/media.sh &")
    hl.exec_cmd("swaync &")

    -- Other Independent System Components
    hl.exec_cmd("hyprpaper &")
    hl.exec_cmd("nm-applet &")
    hl.exec_cmd("blueman-applet &")

    -- Clipboard Stack
    hl.exec_cmd("cliphist daemon &")
    hl.exec_cmd("wl-paste --type text --watch cliphist store &")
    hl.exec_cmd("wl-paste --type image --watch cliphist store &")
    hl.exec_cmd("waybar &")
end)
