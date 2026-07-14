-- --- UI & Layout ---
vim.opt.number = true -- Show absolute line number for current line
vim.opt.relativenumber = true -- Show relative line numbers for easy jumping
vim.opt.termguicolors = true -- Enable 24-bit RGB colors in terminal
vim.opt.signcolumn = "yes" -- Keep sign column open to prevent text shifting
vim.opt.cursorline = true -- Highlight the current cursor line
vim.opt.scrolloff = 8

-- --- 6-Space Indentation ---
vim.opt.expandtab = true -- Convert tabs into spaces
vim.opt.shiftwidth = 6 -- Number of spaces for auto-indenting
vim.opt.tabstop = 6 -- Number of spaces a tab counts for
vim.opt.softtabstop = 6 -- Number of spaces a tab counts for while editing
vim.opt.wrap = true -- Enable text wrapping
vim.opt.breakindent = true -- Wrapped lines keep the original indentation

-- --- Search Optimization ---
vim.opt.ignorecase = true -- Case-insensitive searching
vim.opt.smartcase = true -- Case-sensitive if search contains uppercase
vim.opt.hlsearch = true -- Highlight all matches of previous search
vim.opt.incsearch = true -- Show search matches dynamically while typing

-- --- Windows & Splits ---
vim.opt.splitbelow = true -- Force horizontal splits to open below
vim.opt.splitright = true -- Force vertical splits to open right

-- --- System & Backup ---
vim.opt.clipboard = "unnamedplus" -- Sync Neovim with system clipboard
vim.opt.swapfile = false -- Disable creation of swap files
vim.opt.updatetime = 250 -- Faster completion and diagnostic updates

-- --- Autocompletion Setup ---
vim.opt.completeopt = "menu,menuone,noselect" -- Standard options for LSP completion

-- --- Diagnostics (Inline Lint/Error Display) ---
vim.diagnostic.config({
	virtual_text = { prefix = "▎", spacing = 2 },
	signs = true,
	underline = true,
	update_in_insert = false,
	float = { border = "single" },
})
