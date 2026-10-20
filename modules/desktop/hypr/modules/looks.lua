-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 5,

		border_size = 1,

		resize_on_border = true,
		allow_tearing = false,

		layout = "scrolling",
	},

	decoration = {
		rounding = 0,
		rounding_power = 1,

		active_opacity = 0.85,
		inactive_opacity = 0.76,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 4,
			passes = 3,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})
