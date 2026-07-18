return {
	{
		"mfussenegger/nvim-dap",
		dependencies = {
			"rcarriga/nvim-dap-ui",
			"nvim-neotest/nvim-nio",
			"jay-babu/mason-nvim-dap.nvim",
		},
		-- ⚠️ The "keys" section has been safely removed from here!
		config = function()
			local dap = require("dap")
			local dapui = require("dapui")
			local mason_dap = require("mason-nvim-dap")

			dapui.setup()

			mason_dap.setup({
				automatic_installation = true,
				handlers = {
					function(config)
						mason_dap.default_setup(config)
					end,
					codelldb = function(config)
						config.adapters = {
							type = "server",
							port = "${port}",
							executable = {
								command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
								args = { "--port", "${port}" },
							},
						}
						mason_dap.default_setup(config)
					end,
				},
			})

			dap.configurations.cpp = {
				{
					name = "Launch Local Executable",
					type = "codelldb",
					request = "launch",
					program = function()
						return vim.fn.input("Path to binary executable: ", vim.fn.getcwd() .. "/", "file")
					end,
					cwd = "${workspaceFolder}",
					stopOnEntry = false,
					args = {},
				},
			}
			dap.configurations.c = dap.configurations.cpp

			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},
}
