return {
	-- Main mason plugin
	{
		"williamboman/mason.nvim",
		lazy = false,
		dependencies = {
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
		},
		config = function()
			local mason = require("mason")
			local mason_lspconfig = require("mason-lspconfig")
			local mason_tool_installer = require("mason-tool-installer")

			mason.setup({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			mason_lspconfig.setup({
				ensure_installed = {
					"lua_ls",
					"html",
					"cssls",
					"pyright",
				},
				automatic_installation = true,
			})

			mason_tool_installer.setup({
				ensure_installed = {
					"stylua",
					"prettier",
					"eslint_d",
					"black",
					"debugpy",
					"clang-format",
					"codelldb",
				},
				auto_update = true,
				run_on_start = true,
			})

			vim.cmd("MasonToolsInstall")
		end,
	},
}
