return {
	{
		"karb94/neoscroll.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- ⏱️ Setup standard motion configurations directly via opts
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
			duration_ms = 150,
			easing = "quadratic",
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = true,
		},
		config = function(_, opts)
			local neoscroll = require("neoscroll")

			-- Load settings block
			neoscroll.setup(opts)

			-- 🚀 CUSTOM SPEED OVERRIDES (Without using deprecated set_mappings)
			-- Map keys natively using your local config structure or direct wrappers
			local map = vim.keymap.set

			map("n", "<C-u>", function()
				neoscroll.ctrl_u({ duration = 150 })
			end, { desc = "Scroll Up" })
			map("n", "<C-d>", function()
				neoscroll.ctrl_d({ duration = 150 })
			end, { desc = "Scroll Down" })
			map("n", "<C-b>", function()
				neoscroll.ctrl_b({ duration = 250 })
			end, { desc = "Page Up" })
			map("n", "<C-f>", function()
				neoscroll.ctrl_f({ duration = 250 })
			end, { desc = "Page Down" })
		end,
	},
}
