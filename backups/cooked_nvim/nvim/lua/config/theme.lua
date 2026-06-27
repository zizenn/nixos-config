local function read_json(path)
	local f = io.open(path, "r")
	if not f then
		return nil
	end
	local content = f:read("*a")
	f:close()
	return content
end

-- Minimal JSON value extractor — no dependencies
local function extract(json, key)
	local pattern = '"' .. key .. '":%s*"(#%x+)"'
	return json:match(pattern)
end

local json = read_json(vim.fn.expand("~/.cache/matugen/colors.json"))
if not json then
	vim.notify("matugen: colors.json not found", vim.log.levels.WARN)
	return
end

local c = {
	bg = extract(json, "surface"),
	bg2 = extract(json, "surface_variant"),
	fg = extract(json, "on_surface"),
	fg_muted = extract(json, "on_surface_variant"),
	primary = extract(json, "primary"),
	on_primary = extract(json, "on_primary"),
	secondary = extract(json, "secondary"),
	tertiary = extract(json, "tertiary"),
	error = extract(json, "error"),
	outline = extract(json, "outline"),
	bg_hl = extract(json, "surface_container_high"),
	bg_sel = extract(json, "primary_container"),
	fg_sel = extract(json, "on_primary_container"),
}

vim.cmd("highlight clear")
vim.o.background = "dark"
vim.g.colors_name = "matugen"

local function hi(group, opts)
	vim.api.nvim_set_hl(0, group, opts)
end

-- Editor base
hi("Normal", { fg = c.fg, bg = c.bg })
hi("NormalFloat", { fg = c.fg, bg = c.bg2 })
hi("FloatBorder", { fg = c.outline, bg = c.bg2 })
hi("CursorLine", { bg = c.bg_hl })
hi("CursorLineNr", { fg = c.primary, bold = true })
hi("LineNr", { fg = c.fg_muted })
hi("SignColumn", { bg = c.bg })
hi("ColorColumn", { bg = c.bg_hl })
hi("VertSplit", { fg = c.outline })
hi("WinSeparator", { fg = c.outline })
hi("StatusLine", { fg = c.fg, bg = c.bg2 })
hi("StatusLineNC", { fg = c.fg_muted, bg = c.bg2 })
hi("TabLine", { fg = c.fg_muted, bg = c.bg2 })
hi("TabLineSel", { fg = c.fg, bg = c.bg, bold = true })
hi("TabLineFill", { bg = c.bg2 })
hi("Pmenu", { fg = c.fg, bg = c.bg2 })
hi("PmenuSel", { fg = c.fg_sel, bg = c.bg_sel })
hi("PmenuSbar", { bg = c.bg2 })
hi("PmenuThumb", { bg = c.outline })
hi("Visual", { bg = c.bg_sel })
hi("Search", { fg = c.on_primary, bg = c.primary })
hi("IncSearch", { fg = c.on_primary, bg = c.secondary })
hi("MatchParen", { fg = c.primary, bold = true, underline = true })
hi("NonText", { fg = c.fg_muted })
hi("Folded", { fg = c.fg_muted, bg = c.bg_hl })
hi("EndOfBuffer", { fg = c.bg })

-- Syntax
hi("Comment", { fg = c.fg_muted, italic = true })
hi("String", { fg = c.secondary })
hi("Character", { fg = c.secondary })
hi("Number", { fg = c.tertiary })
hi("Float", { fg = c.tertiary })
hi("Boolean", { fg = c.primary })
hi("Keyword", { fg = c.primary, italic = true })
hi("Conditional", { fg = c.primary, italic = true })
hi("Repeat", { fg = c.primary, italic = true })
hi("Function", { fg = c.fg, bold = true })
hi("Identifier", { fg = c.fg })
hi("Type", { fg = c.tertiary })
hi("Structure", { fg = c.tertiary })
hi("Constant", { fg = c.tertiary })
hi("PreProc", { fg = c.secondary })
hi("Include", { fg = c.secondary })
hi("Macro", { fg = c.secondary })
hi("Special", { fg = c.primary })
hi("Delimiter", { fg = c.fg_muted })
hi("Operator", { fg = c.fg })

-- Diagnostics
hi("DiagnosticError", { fg = c.error })
hi("DiagnosticWarn", { fg = c.tertiary })
hi("DiagnosticInfo", { fg = c.secondary })
hi("DiagnosticHint", { fg = c.fg_muted })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.error })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.tertiary })
hi("DiagnosticVirtualTextError", { fg = c.error, italic = true })
hi("DiagnosticVirtualTextWarn", { fg = c.tertiary, italic = true })

-- LSP
hi("LspReferenceText", { bg = c.bg_hl })
hi("LspReferenceRead", { bg = c.bg_hl })
hi("LspReferenceWrite", { bg = c.bg_hl, underline = true })

-- Treesitter (links to base groups, override specifics here)
hi("@keyword", { link = "Keyword" })
hi("@keyword.function", { fg = c.primary, italic = true })
hi("@keyword.return", { fg = c.primary, italic = true })
hi("@function", { link = "Function" })
hi("@function.builtin", { fg = c.secondary, bold = true })
hi("@type", { link = "Type" })
hi("@type.builtin", { fg = c.tertiary, italic = true })
hi("@variable", { fg = c.fg })
hi("@variable.builtin", { fg = c.primary, italic = true })
hi("@parameter", { fg = c.fg, italic = true })
hi("@field", { fg = c.fg })
hi("@property", { fg = c.fg })
hi("@punctuation", { fg = c.fg_muted })
hi("@string", { link = "String" })
hi("@number", { link = "Number" })
hi("@comment", { link = "Comment" })
hi("@constant", { link = "Constant" })
hi("@constant.builtin", { fg = c.primary })
hi("@constructor", { fg = c.fg, bold = true })
hi("@namespace", { fg = c.tertiary, italic = true })
hi("@include", { link = "Include" })
hi("@operator", { link = "Operator" })

-- Git signs
hi("GitSignsAdd", { fg = c.secondary })
hi("GitSignsChange", { fg = c.primary })
hi("GitSignsDelete", { fg = c.error })

-- Telescope
hi("TelescopeNormal", { fg = c.fg, bg = c.bg2 })
hi("TelescopeBorder", { fg = c.outline, bg = c.bg2 })
hi("TelescopeSelection", { fg = c.fg_sel, bg = c.bg_sel })
hi("TelescopeMatching", { fg = c.primary, bold = true })
hi("TelescopePromptPrefix", { fg = c.primary })

-- nvim-cmp
hi("CmpItemAbbr", { fg = c.fg })
hi("CmpItemAbbrMatch", { fg = c.primary, bold = true })
hi("CmpItemAbbrMatchFuzzy", { fg = c.primary })
hi("CmpItemKind", { fg = c.secondary })
hi("CmpItemMenu", { fg = c.fg_muted })

-- Trouble
hi("TroubleNormal", { fg = c.fg, bg = c.bg2 })
