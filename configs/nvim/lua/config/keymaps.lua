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
