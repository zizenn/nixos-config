vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "matugen"

local M = {}

-- Matugen palette reference:
--   #DCD7BA  main text      #957FB8  purple/keywords
--   #7E9CD8  blue/functions  #98BB6C  green/strings
--   #727169  gray/comments   #575279  dim purple/borders
--   #2D4F67  dark blue       #E46876  red/types/errors

local c = {
  fg      = "#DCD7BA",
  purple  = "#957FB8",
  blue    = "#7E9CD8",
  green   = "#98BB6C",
  gray    = "#727169",
  border  = "#575279",
  dark    = "#2D4F67",
  red     = "#E46876",
}

function M.setup()
  -- Global Backgrounds
  vim.api.nvim_set_hl(0, "Normal",      { bg = "NONE", fg = c.fg })
  vim.api.nvim_set_hl(0, "NormalNC",    { bg = "NONE", fg = c.fg })
  vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
  vim.api.nvim_set_hl(0, "FloatBorder", { fg = c.border, bg = "NONE" })
  vim.api.nvim_set_hl(0, "CursorLine",  { bg = c.dark })

  -- Neo-tree
  vim.api.nvim_set_hl(0, "NeoTreeNormal",         { bg = "NONE", fg = c.fg })
  vim.api.nvim_set_hl(0, "NeoTreeFloatNormal",    { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeNormalNC",       { bg = "NONE" })
  vim.api.nvim_set_hl(0, "NeoTreeWinSeparator",   { fg = c.dark, bg = "NONE" })

  -- Treesitter
  vim.api.nvim_set_hl(0, "@keyword",              { fg = c.purple, bold = true })
  vim.api.nvim_set_hl(0, "@function",             { fg = c.blue })
  vim.api.nvim_set_hl(0, "@string",               { fg = c.green })
  vim.api.nvim_set_hl(0, "@comment",              { fg = c.gray, italic = true })
  vim.api.nvim_set_hl(0, "@type",                 { fg = c.red })
  vim.api.nvim_set_hl(0, "@number",               { fg = c.fg })
  vim.api.nvim_set_hl(0, "@constant",             { fg = c.fg, bold = true })
  vim.api.nvim_set_hl(0, "@variable",             { fg = c.fg })
  vim.api.nvim_set_hl(0, "@parameter",            { fg = c.fg, italic = true })
  vim.api.nvim_set_hl(0, "@operator",             { fg = c.purple })
  vim.api.nvim_set_hl(0, "@field",                { fg = c.blue })
  vim.api.nvim_set_hl(0, "@property",             { fg = c.blue })
  vim.api.nvim_set_hl(0, "@boolean",              { fg = c.red })
  vim.api.nvim_set_hl(0, "@namespace",            { fg = c.blue })
  vim.api.nvim_set_hl(0, "@label",                { fg = c.purple })
  vim.api.nvim_set_hl(0, "@punctuation.delimiter", { fg = c.border })
  vim.api.nvim_set_hl(0, "@punctuation.bracket",  { fg = c.border })

  -- GitSigns
  vim.api.nvim_set_hl(0, "GitSignsAdd",           { fg = c.green, bg = "NONE" })
  vim.api.nvim_set_hl(0, "GitSignsChange",        { fg = c.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "GitSignsDelete",        { fg = c.red, bg = "NONE" })

  -- BufferLine
  vim.api.nvim_set_hl(0, "BufferLineBackground",       { bg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineBufferVisible",    { bg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineBufferSelected",   { bg = "NONE", bold = true, fg = c.fg })
  vim.api.nvim_set_hl(0, "BufferLineTab",              { bg = "NONE" })
  vim.api.nvim_set_hl(0, "BufferLineTabSelected",      { bg = "NONE", fg = c.purple })

  -- IndentBlankline
  vim.api.nvim_set_hl(0, "IblIndent", { fg = c.dark })
  vim.api.nvim_set_hl(0, "IblScope",  { fg = c.border })

  -- WhichKey
  vim.api.nvim_set_hl(0, "WhichKey",       { fg = c.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyGroup",  { fg = c.purple, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyDesc",   { fg = c.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "WhichKeyBorder", { fg = c.border, bg = "NONE" })

  -- TodoComments
  vim.api.nvim_set_hl(0, "TodoFgTODO", { fg = c.blue })
  vim.api.nvim_set_hl(0, "TodoFgFIX",  { fg = c.red })
  vim.api.nvim_set_hl(0, "TodoFgHACK", { fg = c.red })
  vim.api.nvim_set_hl(0, "TodoFgNOTE", { fg = c.green })
  vim.api.nvim_set_hl(0, "TodoFgWARN", { fg = c.fg })
  vim.api.nvim_set_hl(0, "TodoFgPERF", { fg = c.purple })

  -- Cmp (autocomplete menu)
  vim.api.nvim_set_hl(0, "CmpItemAbbr",        { fg = c.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpItemAbbrMatch",   { fg = c.blue, bg = "NONE", bold = true })
  vim.api.nvim_set_hl(0, "CmpItemKind",        { fg = c.purple, bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpItemMenu",        { fg = c.gray, bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpPmenu",           { bg = "NONE" })
  vim.api.nvim_set_hl(0, "CmpSel",             { bg = c.dark })
  vim.api.nvim_set_hl(0, "Pmenu",              { bg = "NONE" })
  vim.api.nvim_set_hl(0, "PmenuSel",           { bg = c.dark })

  -- LSP Diagnostics
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", { fg = c.red, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextWarn",  { fg = c.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextInfo",  { fg = c.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint",  { fg = c.purple, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineError",   { sp = c.red, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn",    { sp = c.fg, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo",    { sp = c.blue, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint",    { sp = c.purple, undercurl = true })
  vim.api.nvim_set_hl(0, "DiagnosticSignError",        { fg = c.red, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignWarn",         { fg = c.fg, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignInfo",         { fg = c.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "DiagnosticSignHint",         { fg = c.purple, bg = "NONE" })

  -- LSP Reference highlights
  vim.api.nvim_set_hl(0, "LspReferenceText",  { bg = c.dark })
  vim.api.nvim_set_hl(0, "LspReferenceRead",  { bg = c.dark })
  vim.api.nvim_set_hl(0, "LspReferenceWrite", { bg = c.dark })
  vim.api.nvim_set_hl(0, "LspInlayHint",      { fg = c.gray, bg = "NONE" })

  -- Fidget
  vim.api.nvim_set_hl(0, "FidgetTitle", { fg = c.blue, bg = "NONE" })
  vim.api.nvim_set_hl(0, "FidgetTask",  { fg = c.fg, bg = "NONE" })

  -- Syntax
  vim.api.nvim_set_hl(0, "Keyword",  { fg = c.purple, bold = true })
  vim.api.nvim_set_hl(0, "Function", { fg = c.blue })
  vim.api.nvim_set_hl(0, "String",   { fg = c.green })
  vim.api.nvim_set_hl(0, "Comment",  { fg = c.gray, italic = true })
end

M.setup()
