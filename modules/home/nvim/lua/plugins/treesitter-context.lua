return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      enable = true,
      max_lines = 5,
      trim_scope = "outer",
      separator = "-",
    },
  },
}
