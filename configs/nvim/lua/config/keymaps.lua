local map = vim.keymap.set

-- setting both leaders to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- move by visual line (wrapped text) + center
map("n", "j", "gjzz", { desc = "Move down (visual line)" })
map("n", "k", "gkzz", { desc = "Move up (visual line)" })

-- neotree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

-- telescope
map("n", "<leader>ff", function()
	require("telescope.builtin").find_files()
end, { desc = "Telescope Find Files" })
map("n", "<leader>fg", function()
	require("telescope.builtin").live_grep()
end, { desc = "Telescope Live Grep" })
map("n", "<leader>fb", function()
	require("telescope.builtin").buffers()
end, { desc = "Telescope Find Buffers" })
map("n", "<leader>fh", function()
	require("telescope.builtin").help_tags()
end, { desc = "Telescope Help Tags" })
map("n", "<leader>fo", function()
	require("telescope.builtin").oldfiles()
end, { desc = "Telescope Recent Files" })

-- DAP
-- Toggle visual break marker positions in the code gutter
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { silent = true, desc = "Debug: Toggle Breakpoint" })
-- Initialize a debugging workspace or advance code to next hit milestone
map("n", "<leader>dc", function()
	require("dap").continue()
end, { silent = true, desc = "Debug: Start/Continue" })
-- Dive downwards deep directly into a highlighted loop/function scope block
map("n", "<leader>di", function()
	require("dap").step_into()
end, { silent = true, desc = "Debug: Step Into" })
-- Skip smoothly over evaluated lines without jumping down down into sub-calls
map("n", "<leader>do", function()
	require("dap").step_over()
end, { silent = true, desc = "Debug: Step Over" })
-- Hard kill the debugging threads and clean trailing run environments
map("n", "<leader>dt", function()
	require("dap").terminate()
end, { silent = true, desc = "Debug: Terminate Session" })
-- Pop lookups windows and watch-variable layouts open/shut on demand
map("n", "<leader>du", function()
	require("dapui").toggle()
end, { silent = true, desc = "Debug: Toggle UI Panel" })

-- yazi
map("n", "<leader>y", "<cmd>Yazi<cr>", { desc = "Open Yazi" })

-- dashboard
map("n", "<leader>th", function()
	Snacks.dashboard.open()
end, { desc = "Dashboard: Open Home Screen" })

-- which-key
map("n", "<leader>?", function()
	require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps" })

-- trouble
map("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
map("n", "<leader>xw", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", { desc = "Buffer Diagnostics (Trouble)" })
map("n", "<leader>cs", "<cmd>Trouble symbols toggle<cr>", { desc = "Symbols (Trouble)" })
map("n", "<leader>cl", "<cmd>Trouble lsp toggle<cr>", { desc = "LSP References (Trouble)" })
map("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- lsp
map("n", "<leader>li", function()
	local clients = vim.lsp.get_clients()
	if #clients == 0 then
		vim.notify("No active LSP clients")
		return
	end
	local names = {}
	for _, cl in ipairs(clients) do
		table.insert(names, cl.name)
	end
	vim.notify("LSP: " .. table.concat(names, ", "))
end, { desc = "LSP Info" })

-- scroll
-- search: jump + center
map("n", "n", function()
	pcall(function() vim.cmd("normal! nzz") end)
end, { silent = true, desc = "Search: Next match (Centered)" })

map("n", "N", function()
	pcall(function() vim.cmd("normal! Nzz") end)
end, { silent = true, desc = "Search: Previous match (Centered)" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
-- buffer management
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })
map("n", "<leader>bo", function()
	vim.cmd("%bd|e#|bd#")
end, { desc = "Close other buffers" })
map("n", "<leader>bO", function()
	vim.cmd("%bd!")
end, { desc = "Close all buffers" })
map("n", "<leader>bl", "<C-^>", { desc = "Last buffer" })
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<leader>bf", "<cmd>bfirst<CR>", { desc = "First buffer" })
map("n", "<leader>bq", "<cmd>blast<CR>", { desc = "Last buffer" })
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Previous buffer" })
map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next buffer" })

-- move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
