local bar = "waybar"

hl.on("hyprland.start", function()
	-- wallpaper daemon
	hl.exec_cmd("awww-daemon")

	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("xhost +si:localuser:root")

	-- xdg desktop portal
	hl.exec_cmd("killall -9 xdg-desktop-portal-hyprland xdg-desktop-portal")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal-hyprland &")
	hl.exec_cmd("/usr/lib/xdg-desktop-portal &")

	-- clipboard
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- idle daemon
	hl.exec_cmd("hypridle")

	-- bar
	hl.exec_cmd(bar)

	-- session restore on login + install autosave timer
	hl.exec_cmd("hyprflow restore --max-age 24h")
	hl.exec_cmd("hyprflow autosave --install")

	-- ollama
	hl.exec_cmd("ollama serve")

	-- wleave service
	hl.exec_cmd("wleave -s")
end)
