return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = { enabled = false },
    exclude = {
      filetypes = {
        "dashboard", "neo-tree", "TelescopePrompt",
        "help", "terminal", "lazy", "mason",
      },
    },
  },
}
