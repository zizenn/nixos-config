return {
	{
		"saghen/blink.cmp",
		lazy = false, -- Force-load on boot to instantly pipe capabilities into Mason LSPs
		dependencies = {
			-- Provides a massive library of ready-to-use boilerplate code snippets
			"rafamadriz/friendly-snippets",
		},
		-- Use specific release tags for absolute stability
		version = "*",

		opts = {
			-- Set up the default VS-Code style keyboard control triggers
			keymap = {
				preset = "default",
				-- Optional tweak: Make Enter accept the suggestion explicitly
				["<CR>"] = { "accept", "fallback" },
			},

			-- Visual UI formatting layout elements
			appearance = {
				use_nvim_cmp_as_default = true, -- Inherits your colorscheme's traditional CMP design groups
				nerd_font_variant = "mono", -- Aligns icons nicely if you use Nerd Fonts
			},

			-- Define data pools for autocomplete suggestions
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			-- Experimental feature: automatically adds closing brackets when completing functions
			completion = {
				accept = { auto_brackets = { enabled = true } },
				menu = { draw = { treesitter = { "lsp" } } },
			},
		},
		opts_extend = { "sources.default" },
	},
}
