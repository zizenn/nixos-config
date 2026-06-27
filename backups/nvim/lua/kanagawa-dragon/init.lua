local M = {}

function M.setup(opts)
  opts = opts or {}
  require("kanagawa").setup(vim.tbl_deep_extend("force", {
    compile = false,
    undercurl = true,
    commentStyle = { italic = true },
    functionStyle = {},
    keywordStyle = { italic = true },
    statementStyle = { bold = true },
    transparent = false,
    theme = "dragon",
    background = { dark = "dragon", light = "lotus" },
  }, opts))
  vim.cmd.colorscheme("kanagawa-dragon")
end

return M
