-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Global editor settings
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.mouse = "a"
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.expandtab = true
vim.opt.wrap = false
vim.opt.cursorline = true
vim.opt.updatetime = 50
vim.opt.timeoutlen = 500
vim.opt.undofile = true
vim.opt.signcolumn = "yes"

-- Show diagnostic messages inline
vim.diagnostic.config({ virtual_text = true })

-- Scrolloff: keep minimum 5 lines visible above/below cursor
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- Session management (mini.sessions)
vim.keymap.set("n", "<leader>qj", function()
  require("mini.sessions").write(".session")
  vim.cmd("wqa")
end, { desc = "Save session and quit" })

vim.keymap.set("n", "<leader>qd", function()
  require("mini.sessions").delete(".session")
  vim.cmd("wqa")
end, { desc = "Delete session and quit" })

-- Lazy plugin setup
require("lazy").setup({
  spec = {
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
})
