hl.config({
	general = {
		gaps_in = 4.5,
		gaps_out = 9,
		border_size = 0,
		resize_on_border = false,
		allow_tearing = false,
		layout = "scrolling",
	},

	decoration = {
		rounding = 0,
		rounding_power = 0,
		active_opacity = 0.94,
		inactive_opacity = 0.88,
		dim_inactive = 0,
		dim_strength = 0.15,
		shadow = {
			enabled = false,
			range = 7,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
		blur = {
			enabled = true,
			size = 4,
			passes = 1,
			vibrancy = 0.1696,
		},
	},

	scrolling = {
		column_width = 0.7,
		fullscreen_on_one_column = true,
		focus_fit_method = 1,
		follow_focus = true,
		direction = "right",
	},

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
		disable_splash_rendering = 1,
		focus_on_activate = 1,
		vrr = 3,
	},

	input = {
		kb_layout = "us",
		follow_mouse = 1,
		sensitivity = -0.3,
		accel_profile = "flat",
		touchpad = {
			natural_scroll = false,
		},
	},
})
