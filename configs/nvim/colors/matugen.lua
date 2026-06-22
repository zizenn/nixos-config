vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "matugen"

local M = {}

function M.setup()
  -- Global Backgrounds (Transparent)
  vim.api.nvim_set_hl(0, "Normal", { bg = "NONE", fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "NormalNC", { bg = "NONE", fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#575279", bg = "NONE" })
  
  -- Neo-tree Highlights
  vim.api.nvim_set_hl(0, "NeoTreeNormal", { bg = "NONE", fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "NeoTreeFloatNormal", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeWinSeparator", { fg = "#2D4F67", bg = "NONE" })

  -- Syntax Highlighting
  vim.api.nvim_set_hl(0, "Keyword", { fg = "#957FB8", bold = true })
  vim.api.nvim_set_hl(0, "Function", { fg = "#7E9CD8" })
  vim.api.nvim_set_hl(0, "String", { fg = "#98BB6C" })
  vim.api.nvim_set_hl(0, "Comment", { fg = "#727169", italic = true })
end

M.setup()
