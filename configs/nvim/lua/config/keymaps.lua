local map = vim.keymap.set

-- setting both leaders to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

-- neoscroll
map("n", "<C-u>", function()
	require("neoscroll").ctrl_u({ duration = 150 })
end, { desc = "Scroll Up" })
map("n", "<C-d>", function()
	require("neoscroll").ctrl_d({ duration = 150 })
end, { desc = "Scroll Down" })
map("n", "<C-b>", function()
	require("neoscroll").ctrl_b({ duration = 250 })
end, { desc = "Page Up" })
map("n", "<C-f>", function()
	require("neoscroll").ctrl_f({ duration = 250 })
end, { desc = "Page Down" })

-- scroll
-- Next search match: Jump, center the screen, and trigger smooth animation
map("n", "n", function()
	-- Use pcall to prevent error sounds/popups if no more matches exist
	pcall(function()
		vim.cmd("normal! nzz")
		require("neoscroll").zz({ duration_ms = 100 })
	end)
end, { silent = true, desc = "Search: Next match (Centered)" })

-- Previous search match: Jump backward, center the screen, and trigger smooth animation
map("n", "N", function()
	pcall(function()
		vim.cmd("normal! Nzz")
		require("neoscroll").zz({ duration_ms = 100 })
	end)
end, { silent = true, desc = "Search: Previous match (Centered)" })

-- window management
map("n", "<leader>sv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>sh", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>se", "<C-w>=", { desc = "Equalize splits" })
map("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close split" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Close buffer" })

-- move lines in visual mode
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move line down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move line up" })
