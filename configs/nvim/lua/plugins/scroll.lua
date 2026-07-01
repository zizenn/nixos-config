return {
	{
		"karb94/neoscroll.nvim",
		event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file to preserve fast startup
		config = function()
			local neoscroll = require("neoscroll")

			neoscroll.setup({
				-- Time (in ms) for the scrolling animation to complete
				duration_ms = 150,
				-- Smooth deceleration effect as the scroll comes to a stop
				easing = "quadratic",
				-- Hide the mouse cursor dynamically during animations to avoid visual flickering
				hide_cursor = true,
				-- Automatically halt scrolling if you press an unrelated key mid-movement
				stop_eof = true,
				-- Respect search match positions smoothly
				respect_scrolloff = true,
			})

			-- Set up keymap shortcuts using standard navigation triggers
			local mappings = {}

			-- Use your preferred styling structure to map standard motions
			-- Syntax: mappings[key] = { function_name, { arguments } }
			mappings["<C-u>"] = { "scroll", { "-vim.wo.scroll", "true", "150" } } -- Scroll half-page up
			mappings["<C-d>"] = { "scroll", { "vim.wo.scroll", "true", "150" } } -- Scroll half-page down
			mappings["<C-b>"] = { "scroll", { "-vim.api.nvim_win_get_height(0)", "true", "250" } } -- Full page up
			mappings["<C-f>"] = { "scroll", { "vim.api.nvim_win_get_height(0)", "true", "250" } } -- Full page down

			-- Connect the physics engine configuration to your native keystrokes
			require("neoscroll.config").set_mappings(mappings)
		end,
	},
}
