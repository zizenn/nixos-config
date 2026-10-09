require("nvim-treesitter.config").setup({
  ensure_installed = {
    "bash", "c", "cpp", "lua", "vim", "vimdoc", "query",
    "javascript", "typescript", "tsx", "html", "css",
    "json", "yaml", "markdown", "markdown_inline",
  },
  sync_install = false,
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  indent = { enable = true },
})
