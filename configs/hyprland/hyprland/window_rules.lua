hl.window_rule({
	match = { class = ".*" },
	suppress_event = "maximize",
})

hl.window_rule({
	match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
	no_focus = true,
})

hl.window_rule({
	match = { class = "hyprland-run" },
	move = "20 monitor_h-120",
	float = true,
})

hl.window_rule({
	match = { initial_class = "^(com.github.martenad.dragon)$" },
	float = true,
	pin = true,
	size = "200 200",
	center = true,
})

hl.window_rule({
	match = { class = "yazi-float" },
	float = true,
	size = "1280 720",
	center = true,
})

hl.window_rule({
	match = { class = "wlctl-float" },
	float = true,
	size = "1280 720",
	center = true,
})

hl.window_rule({
	match = { class = "wiremix-float" },
	float = true,
	size = "1280 720",
	center = true,
})

hl.window_rule({
	match = { title = "quickshell-launcher" },
	float = true,
	pin = true,
})
