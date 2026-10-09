-- nvim-treesitter `main` branch API: setup() only takes install_dir,
-- parsers install via install(), and highlight/indent enable per filetype.
require("nvim-treesitter").setup({})

local parsers = {
  "bash", "c", "cpp", "lua", "vim", "vimdoc", "query",
  "javascript", "typescript", "tsx", "html", "css",
  "json", "yaml", "markdown", "markdown_inline",
}

-- Install any missing parsers (no-op for already-installed ones)
require("nvim-treesitter").install(parsers)

-- `main` enables nothing by itself: start highlighting + indent per filetype
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "sh", "bash", "c", "cpp", "lua", "vim", "help", "query",
    "javascript", "typescript", "typescriptreact", "html", "css",
    "json", "yaml", "markdown",
  },
  callback = function()
    if pcall(vim.treesitter.start) then
      vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
    end
  end,
})
