return {
  {
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    keys = {
      {
        "-",
        function()
          require("oil").open()
        end,
        desc = "Open parent directory (Oil)",
      },
    },
    opts = {
      default_file_explorer = false,
      view_options = { show_hidden = true },
      float = { border = "rounded" },
    },
  },
}
