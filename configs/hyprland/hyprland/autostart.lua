local terminal = "kitty"
local menu = "wofi -n"
local bar = "quickshell -p /home/zizenn/.config/quickshell/shell.qml"

hl.on("hyprland.start", function ()
    -- hyprpolkitagent and pywal
    hl.exec_cmd("matugen image ~/.wallpaper --source-color-index 0")
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("xhost +si:localuser:root")

    -- xdg desktop portal
    hl.exec_cmd("killall -9 xdg-desktop-portal-hyprland xdg-desktop-portal")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
    hl.exec_cmd("/usr/lib/xdg-desktop-portal &")

    -- clipboard
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- wallpaper
    hl.exec_cmd("awww-daemon")

    -- bar
    hl.exec_cmd(bar)

end)
