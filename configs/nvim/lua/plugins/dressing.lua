return {
  {
    "stevearc/dressing.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      input = {
        border = "single",
      },
      select = {
        backend = { "telescope", "builtin" },
      },
    },
  },
}
