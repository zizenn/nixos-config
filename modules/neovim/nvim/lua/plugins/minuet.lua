return {
	"milanglacier/minuet-ai.nvim",
	event = "InsertEnter",
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("minuet").setup({
			provider = "openai_fim_compatible",
			n_completions = 1,
			context_window = 1024,
			throttle = 300,
			debounce = 100,
			virtualtext = {
				keymap = {
					accept = "<C-l>",
					accept_line = "<M-;>",
					accept_n_lines = "<M-z>",
					prev = "<M-k>",
					next = "<M-j>",
					dismiss = "<M-e>",
				},
			},
			provider_options = {
				openai_fim_compatible = {
					api_key = "TERM",
					name = "Ollama",
					end_point = "http://localhost:11434/v1/completions",
					model = "qwen2.5-coder:1.5b",
					optional = {
						max_tokens = 256,
						top_p = 0.9,
					},
				},
			},
		})
	end,
}
