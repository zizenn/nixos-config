return {
  {
    "folke/todo-comments.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      highlight = {
        before = "",
        keyword = "wide",
      },
      search = {
        pattern = [[\b(TODO|FIXME|HACK|NOTE|PERF|WARN)\b]],
      },
    },
  },
}
