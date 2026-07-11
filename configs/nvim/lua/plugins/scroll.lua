return {
	{
		"karb94/neoscroll.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			-- ⏱️ Setup standard motion configurations directly via opts
			mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zb" },
			duration_ms = 150,
			easing = "quadratic",
			hide_cursor = true,
			stop_eof = true,
			respect_scrolloff = true,
		},
		config = function(_, opts)
			require("neoscroll").setup(opts)
		end,
	},
}
