-- Bootstrap lazy.nvim (auto-download if missing)
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

-- Remap space as leader key (must happen before lazy setup)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set basic options so Neovim looks right immediately
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true

-- Initialize Lazy and point it to your plugins folder
require("lazy").setup({
  spec = {
    -- This imports everything mapped into lua/plugins/
    { import = "plugins" },
  },
  install = { colorscheme = { "habamax" } },
  checker = { enabled = false },
})
