return {
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp" }, -- Ensure autocomplete engine loads first
		config = function()
			local lspconfig = require("lspconfig")

			-- 1. Fetch autocomplete engine structural features
			local capabilities = require("blink.cmp").get_lsp_capabilities()

			-- 2. Define the servers you want to configure (matching your Mason list)
			local servers = { "lua_ls", "tsserver", "html", "cssls", "pyright", "clangd" }

			-- 3. Loop through them and inject the autocomplete capabilities
			for _, server in ipairs(servers) do
				lspconfig[server].setup({
					capabilities = capabilities,
				})
			end
		end,
	},
}
