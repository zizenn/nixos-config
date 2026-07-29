return {
	"github/copilot.vim",
	cmd = "Copilot",
	event = "InsertEnter",
	config = function()
		vim.g.copilot_filetypes = {
			yaml = false,
			markdown = false,
			help = false,
			gitcommit = false,
			gitrebase = false,
			hgcommit = false,
			svn = false,
			cvs = false,
			["."] = false,
		}
		vim.g.copilot_no_tab_map = true
		vim.keymap.set("i", "<M-l>", 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
		vim.keymap.set("i", "<M-]>", "<Cmd>call copilot#Next()<CR>")
		vim.keymap.set("i", "<M-[>", "<Cmd>call copilot#Previous()<CR>")
		vim.keymap.set("i", "<C-]>", "<Cmd>call copilot#Dismiss()<CR>")
	end,
}
