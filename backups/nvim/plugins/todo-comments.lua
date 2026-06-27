return {
  "folke/todo-comments.nvim",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    signs = true,
    keywords = {
      TODO = { icon = " ", color = "info" },
      FIX = { icon = " ", color = "error" },
      HACK = { icon = " ", color = "warning" },
      NOTE = { icon = " ", color = "hint" },
      WARN = { icon = " ", color = "warning" },
      PERF = { icon = " ", color = "warning" },
    },
    highlight = {
      before = "",
      keyword = "wide",
      after = "fg",
    },
  },
}
