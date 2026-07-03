return {
	{
		"kylechui/nvim-surround",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("nvim-surround").setup({
				keymaps = {
					visual = "S", -- Forces Shift+S in visual mode
				},
			})
		end,
	},
}
