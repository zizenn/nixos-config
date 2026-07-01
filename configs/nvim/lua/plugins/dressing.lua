return {
  {
    "stevearc/dressing.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      input = {
        border = "rounded",
      },
      select = {
        backend = { "telescope", "builtin" },
      },
    },
  },
}
