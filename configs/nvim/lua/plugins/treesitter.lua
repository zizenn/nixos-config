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
      -- A list of parser names, or "all"
      ensure_installed = {
        "bash", "c", "lua", "vim", "vimdoc", "query",
        "javascript", "typescript", "tsx", "html", "css", 
        "json", "yaml", "markdown", "markdown_inline",
      },

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      auto_install = true,

      highlight = {
        enable = true,
        -- Setting this to true will run `:h syntax` and may slow down your editor
        -- for large files. Set to `false` if you experience lag.
        additional_vim_regex_highlighting = false,
      },

      indent = { enable = true },

      -- nvim-treesitter-textobjects configuration
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["as"] = "@scope",
          },
        },
      },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      -- Enable Treesitter based folding
      vim.opt.foldmethod = "expr"
      vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
      vim.opt.foldenable = false -- Disable folding by default at startup
    end,
  },
}

