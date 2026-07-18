return {
	{
		"obsidian-nvim/obsidian.nvim",
		version = "*",
		event = { "BufReadPre", "BufNewFile" },
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope.nvim",
		},
		keys = {
			{ "<leader>oo", "<cmd>Obsidian open<CR>", desc = "Open in Obsidian" },
			{ "<leader>oq", "<cmd>Obsidian quick_switch<CR>", desc = "Obsidian quick switch" },
			{ "<leader>os", "<cmd>Obsidian search<CR>", desc = "Search Obsidian notes" },
			{ "<leader>ol", "<cmd>Obsidian link<CR>", desc = "Insert link to note" },
			{ "<leader>oL", "<cmd>Obsidian link_new<CR>", desc = "Create note and insert link" },
			{ "<leader>ob", "<cmd>Obsidian backlinks<CR>", desc = "Obsidian backlinks" },
			{ "<leader>od", "<cmd>Obsidian today<CR>", desc = "Obsidian daily note" },
			{ "<leader>ot", "<cmd>Obsidian template<CR>", desc = "Insert Obsidian template" },
		},
		opts = {
			legacy_commands = false,
			workspaces = {
				{
					name = "vault",
					path = vim.fn.expand("~/Documents/vault"),
				},
			},
			daily_notes = {
				folder = "05_daily",
				date_format = "%Y-%m-%d",
				default_tags = { "daily" },
			},
			templates = {
				subdir = "01_templates",
			},
			link = { style = "wiki" },
			ui = { enable = false },
		},
	},
}
