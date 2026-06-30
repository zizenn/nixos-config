return {
  {
    "mikavilpas/yazi.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>y",
        "<cmd>Yazi<cr>",
        desc = "open yazi",
      },
    },
    opts = {
      keymaps = {
        show_help = "<f1>",
      },
    },
  },
}
