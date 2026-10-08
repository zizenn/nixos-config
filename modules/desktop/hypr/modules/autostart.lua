hl.on("hyprland.start", function()
	hl.exec_cmd("noctalia")
	-- pre-warm kitty single-instance daemon (hidden, no session) so SUPER+T opens instantly
	hl.exec_cmd("kitty --single-instance --listen-on unix:/tmp/kitty-zizenn --start-as hidden --detach --session none")
end)
