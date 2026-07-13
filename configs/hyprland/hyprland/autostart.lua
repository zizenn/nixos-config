local bar = "waybar"

hl.on("hyprland.start", function()
	-- wallpaper daemon
	hl.exec_cmd("QSG_RHI_BACKEND=opengl skwd-daemon")
	hl.exec_cmd("generate-matugen-vars")

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
	hl.exec_cmd("ollama serve")
end)
