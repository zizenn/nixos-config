-- vim.pack setup (built-in Neovim 0.12 plugin manager, replaces lazy.nvim).
-- Design: ONE vim.pack.add() call with every plugin (most robust pattern, also
-- bootstraps clean machines), then each lua/plugins/<name>.lua runs its setup.
-- Update with `:lua vim.pack.update()` (:write to confirm, :quit to discard).
-- To drop a plugin: remove its line here + delete its lua/plugins file.

-- Build steps lazy.nvim used to run (parsers / fzf-native / jsregexp).
vim.api.nvim_create_autocmd("PackChanged", {
  callback = function(ev)
    if ev.data.kind ~= "install" and ev.data.kind ~= "update" then
      return
    end
    if ev.data.spec.name == "nvim-treesitter" then
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      pcall(vim.cmd, "TSUpdate")
    elseif
      (ev.data.spec.name == "telescope-fzf-native.nvim" or ev.data.spec.name == "LuaSnip")
      and ev.data.path
    then
      local cmd = ev.data.spec.name == "LuaSnip" and { "make", "install_jsregexp" } or { "make" }
      local result = vim.system(cmd, { cwd = ev.data.path }):wait()
      if result.code ~= 0 then
        vim.notify(
          ("vim.pack: build failed for %s:\n%s"):format(ev.data.spec.name, result.stderr),
          vim.log.levels.ERROR
        )
      end
    end
  end,
})

local gh = function(x)
  return "https://github.com/" .. x
end

vim.pack.add({
  -- theme + icons first: everything below assumes these exist
  gh("Senal-D-A-Gunaratna/matugen.nvim"),
  gh("echasnovski/mini.icons"),

  -- core: lsp, completion, syntax, format, lint
  gh("neovim/nvim-lspconfig"),
  { src = gh("saghen/blink.cmp"), version = vim.version.range("*") },
  gh("onsails/lspkind.nvim"),
  gh("L3MON4D3/LuaSnip"),
  gh("rafamadriz/friendly-snippets"),
  gh("nvim-treesitter/nvim-treesitter"),
  gh("nvim-treesitter/nvim-treesitter-context"),
  gh("stevearc/conform.nvim"),
  gh("mfussenegger/nvim-lint"),

  -- editing
  gh("windwp/nvim-autopairs"),
  { src = gh("kylechui/nvim-surround"), version = vim.version.range("*") },
  gh("folke/flash.nvim"),
  gh("folke/trouble.nvim"),
  gh("folke/todo-comments.nvim"),
  gh("lukas-reineke/indent-blankline.nvim"),
  gh("nvim-lua/plenary.nvim"),

  -- finder / files / git
  { src = gh("nvim-telescope/telescope.nvim"), version = "master" },
  gh("nvim-telescope/telescope-fzf-native.nvim"),
  gh("lewis6991/gitsigns.nvim"),
  { src = gh("mikavilpas/yazi.nvim"), version = vim.version.range("*") },

  -- ui (kept per your picks: noice, notify, dashboard, bufferline,
  -- centered scrolling, treesitter-context)
  gh("nvim-lualine/lualine.nvim"),
  { src = gh("akinsho/bufferline.nvim"), version = vim.version.range("*") },
  gh("folke/snacks.nvim"),
  gh("MunifTanjim/nui.nvim"),
  gh("rcarriga/nvim-notify"),
  gh("folke/noice.nvim"),
  gh("folke/which-key.nvim"),
  gh("arnamak/stay-centered.nvim"),

  -- debug / ai
  gh("mfussenegger/nvim-dap"),
  gh("rcarriga/nvim-dap-ui"),
  gh("nvim-neotest/nvim-nio"),
  gh("github/copilot.vim"),
  { src = gh("nickjvandyke/opencode.nvim"), version = vim.version.range("*") },
})

-- Each module runs its own setup() on require. Order matters only where one
-- setup reads another (icons mock + theme first, notify before noice,
-- luasnip + blink before lsp).
require("plugins.mini")
require("plugins.matugen")
require("plugins.notify")
require("plugins.luasnip")
require("plugins.blink")
require("plugins.lsp")
require("plugins.treesitter")
require("plugins.treesitter-context")
require("plugins.conform")
require("plugins.lint")
require("plugins.autopairs")
require("plugins.surround")
require("plugins.flash")
require("plugins.trouble")
require("plugins.todo-comments")
require("plugins.indent-blankline")
require("plugins.telescope")
require("plugins.gitsigns")
require("plugins.yazi")
require("plugins.lualine")
require("plugins.bufferline")
require("plugins.dashboard")
require("plugins.noice")
require("plugins.whichkey")
require("plugins.stay-centered")
require("plugins.dap")
require("plugins.copilot")
require("plugins.opencode")
