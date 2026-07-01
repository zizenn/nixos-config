return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    cmd = { "TSUpdateSync", "TSInstall", "TSUninstall" },
    opts = {
      ensure_installed = {
        "bash", "c", "lua", "vim", "vimdoc", "query",
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
    },
    config = function(_, opts)
      require("nvim-treesitter.config").setup(opts)

      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = false 
    end,
  },
}

