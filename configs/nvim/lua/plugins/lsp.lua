return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" },
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local lspconfig = require("lspconfig")

			local capabilities = require("blink.cmp").get_lsp_capabilities()

			local servers = { "lua_ls", "ts_ls", "html", "cssls", "pyright" }

			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end

			local nix_clangd = vim.fn.expand("~/.nix-profile/bin/clangd")
			local clangd_cmd = vim.fn.executable(nix_clangd) == 1
				and { nix_clangd }
				or { "clangd" }

			lspconfig.clangd.setup({
				capabilities = capabilities,
				cmd = vim.list_extend(clangd_cmd, {
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
					"--completion-style=detailed",
					"--function-arg-placeholders",
				}),
				init_options = {
					usePlaceholders = true,
					completeUnimported = true,
					clangdFileStatus = true,
				},
			})
		end,
	},
}
