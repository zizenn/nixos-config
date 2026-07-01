local map = vim.keymap.set

-- setting both leaders to space
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- neotree
map("n", "<leader>e", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

-- telescope
map("n", "<leader>ff", function() require("telescope.builtin").find_files() end, { desc = "Telescope Find Files" })
map("n", "<leader>fg", function() require("telescope.builtin").live_grep() end, { desc = "Telescope Live Grep" })
map("n", "<leader>fb", function() require("telescope.builtin").buffers() end, { desc = "Telescope Find Buffers" })
map("n", "<leader>fh", function() require("telescope.builtin").help_tags() end, { desc = "Telescope Help Tags" })
map("n", "<leader>fo", function() require("telescope.builtin").oldfiles() end, { desc = "Telescope Recent Files" })
