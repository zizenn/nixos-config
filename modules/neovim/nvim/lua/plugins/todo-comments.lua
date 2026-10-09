require("todo-comments").setup({
  highlight = {
    before = "",
    keyword = "wide",
  },
  search = {
    pattern = [[\b(TODO|FIXME|HACK|NOTE|PERF|WARN)\b]],
  },
})
