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

  -- Treesitter Highlights
  vim.api.nvim_set_hl(0, "@keyword", { fg = "#957FB8", bold = true })
  vim.api.nvim_set_hl(0, "@function", { fg = "#7E9CD8" })
  vim.api.nvim_set_hl(0, "@string", { fg = "#98BB6C" })
  vim.api.nvim_set_hl(0, "@comment", { fg = "#727169", italic = true })
  vim.api.nvim_set_hl(0, "@type", { fg = "#E46876" })
  vim.api.nvim_set_hl(0, "@number", { fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "@constant", { fg = "#DCD7BA", bold = true })
  vim.api.nvim_set_hl(0, "@variable", { fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "@parameter", { fg = "#DCD7BA", italic = true })
  vim.api.nvim_set_hl(0, "@operator", { fg = "#957FB8" })
  vim.api.nvim_set_hl(0, "@field", { fg = "#7E9CD8" })
  vim.api.nvim_set_hl(0, "@property", { fg = "#7E9CD8" })
  vim.api.nvim_set_hl(0, "@boolean", { fg = "#E46876" })
  vim.api.nvim_set_hl(0, "@namespace", { fg = "#7E9CD8" })
  vim.api.nvim_set_hl(0, "@label", { fg = "#957FB8" })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = "#575279" })
  vim.api.nvim_set_hl(0, "@punctuation.bracket", { fg = "#575279" })

  -- GitSigns Highlights
  vim.api.nvim_set_hl(0, "GitSignsAdd", { fg = "#98BB6C", bg = "NONE" })
  vim.api.nvim_set_hl(0, "GitSignsChange", { fg = "#7E9CD8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "GitSignsDelete", { fg = "#E46876", bg = "NONE" })

  -- BufferLine Highlights (transparent)
  vim.api.nvim_set_hl(0, "BufferLineBackground", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineBufferVisible", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineBufferSelected", { bg = "NONE", bold = true, fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "BufferLineTab", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineTabSelected", { bg = "NONE", fg = "#957FB8" })

  -- IndentBlankline
  vim.api.nvim_set_hl(0, "IblIndent", { fg = "#2D4F67" })
  vim.api.nvim_set_hl(0, "IblScope", { fg = "#575279" })

  -- WhichKey
  vim.api.nvim_set_hl(0, "WhichKey", { fg = "#7E9CD8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyGroup", { fg = "#957FB8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyDesc", { fg = "#DCD7BA", bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = "#575279", bg = "NONE" })

  -- TodoComments
  vim.api.nvim_set_hl(0, "TodoFgTODO", { fg = "#7E9CD8" })
  vim.api.nvim_set_hl(0, "TodoFgFIX", { fg = "#E46876" })
  vim.api.nvim_set_hl(0, "TodoFgHACK", { fg = "#E46876" })
  vim.api.nvim_set_hl(0, "TodoFgNOTE", { fg = "#98BB6C" })
  vim.api.nvim_set_hl(0, "TodoFgWARN", { fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "TodoFgPERF", { fg = "#957FB8" })

  -- Cmp (Autocomplete)
  vim.api.nvim_set_hl(0, "CmpItemAbbr", { fg = "#DCD7BA", bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch", { fg = "#7E9CD8", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatchFuzzy", { fg = "#7E9CD8", bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemKind", { fg = "#957FB8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpItemMenu", { fg = "#575279", bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpPmenu", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpPmenuBorder", { fg = "#575279", bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpSel", { bg = "#2D4F67", fg = "#DCD7BA" })
  vim.api.nvim_set_hl(0, "CmpDocBorder", { fg = "#575279", bg = "NONE" })

  -- Fidget
  vim.api.nvim_set_hl(0, "FidgetTitle", { fg = "#7E9CD8", bg = "NONE" })
  vim.api.nvim_set_hl(0, "FidgetTask", { fg = "#DCD7BA", bg = "NONE" })

  -- Syntax Highlighting
  vim.api.nvim_set_hl(0, "Keyword", { fg = "#957FB8", bold = true })
  vim.api.nvim_set_hl(0, "Function", { fg = "#7E9CD8" })
  vim.api.nvim_set_hl(0, "String", { fg = "#98BB6C" })
  vim.api.nvim_set_hl(0, "Comment", { fg = "#727169", italic = true })
end

M.setup()
