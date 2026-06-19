hl.on("hyprland.start", function()
        hl.exec_cmd("swaync &")

        -- Other Independent System Components
        hl.exec_cmd("hyprpaper &")
        hl.exec_cmd("nm-applet &")
        hl.exec_cmd("blueman-applet &")
        hl.exec_cmd("/home/prakhar/.local/bin/battery-notify.sh &")

        -- Clipboard Stack
        hl.exec_cmd("cliphist daemon &")
        hl.exec_cmd("wl-paste --type text --watch cliphist store &")
        hl.exec_cmd("wl-paste --type image --watch cliphist store &")
        hl.exec_cmd("waybar &")
end)
