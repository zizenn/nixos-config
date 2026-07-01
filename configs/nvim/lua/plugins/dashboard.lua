return {
	{
		"folke/snacks.nvim",
		priority = 1000,
		lazy = false,
		opts = {
			dashboard = {
				enabled = true,
				sections = {
					{ section = "header" }, -- Renders the default epic Neovim ASCII graphic logo
					{ icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
					{ icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
					{ icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
					{ section = "startup" }, -- Displays a clean render of your exact load times
				},
			},
		},
		keys = {
			{
				"<leader>th",
				function()
					Snacks.dashboard.open()
				end,
				desc = "Dashboard: Open Home Screen",
			},
		},
	},
}
