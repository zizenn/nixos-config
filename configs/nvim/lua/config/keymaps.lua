local map = vim.keymap.set

-- setting both leaders to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- neotree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

-- telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { desc = "Telescope Find Files" })
map("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", { desc = "Telescope Live Grep" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { desc = "Telescope Find Buffers" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { desc = "Telescope Help Tags" })
map("n", "<leader>fo", "<cmd>Telescope oldfiles<CR>", { desc = "Telescope Recent Files" })

