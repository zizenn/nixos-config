return {
  "rebelot/kanagawa.nvim",
  name = "kanagawa",
  lazy = false,
  priority = 1000,
  opts = {},
  config = function(_, opts)
    require("kanagawa-dragon").setup(opts)
  end,
}
