return {
	"nickjvandyke/opencode.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		vim.o.autoread = true
		vim.g.opencode_opts = {}

		local map = vim.keymap.set
		map({ "n", "x" }, "<leader>oa", function()
			require("opencode").ask("@this: ")
		end, { desc = "Ask OpenCode" })
		map({ "n", "x" }, "<leader>os", function()
			require("opencode").select()
		end, { desc = "OpenCode actions" })
	end,
}
