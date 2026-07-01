return {
	{
		"saghen/blink.cmp",
		lazy = false,
		dependencies = {
			"rafamadriz/friendly-snippets",
		},
		version = "*",

		opts = {
			keymap = {
				preset = "none",

				["<CR>"] = { "accept", "fallback" },

				["<Tab>"] = {
					"snippet_forward",
					"select_next",
					"fallback",
				},

				["<S-Tab>"] = {
					"snippet_backward",
					"select_prev",
					"fallback",
				},

				["<C-space>"] = { "show", "hide" },
				["<C-e>"] = { "hide" },
			},

			completion = {
				min_keyword_length = 2,

				keyword = {
					delay = 250, -- Keeps your custom 250ms delay intact
				},

				accept = { auto_brackets = { enabled = true } },

				-- 📐 Lock the visual popups positioning behavior
				menu = {
					direction_priority = { "s", "se", "sw" }, -- Forces South (below), South-East, South-West directions
					draw = { treesitter = { "lsp" } },
				},
			},

			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},
		},
		opts_extend = { "sources.default" },
	},
}
