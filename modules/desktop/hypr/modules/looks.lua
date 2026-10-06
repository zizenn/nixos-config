-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 15,

		border_size = 1,

		col = {
			inactive_border = "rgba(595959aa)",
			active_border = "rgba(232159aa)",
		},

		-- Set to true to enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = true,

		-- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
		allow_tearing = false,

		layout = "scrolling",
	},

	decoration = {
		rounding = 30,
		rounding_power = 10,

		active_opacity = 0.9,
		inactive_opacity = 0.8,

		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},

		blur = {
			enabled = true,
			size = 5,
			passes = 2,
			vibrancy = 0.1696,
		},
	},

	animations = {
		enabled = true,
	},
})
