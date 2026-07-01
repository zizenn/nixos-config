return {
  {
    "akinsho/bufferline.nvim",
    version = "*",
    event = "VeryLazy",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<Tab>", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
      { "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", desc = "Previous buffer" },
    },
    opts = {
      options = {
        mode = "buffers",
        separator_style = "thin",
        always_show_bufferline = true,
        sort_by = "insert_after_current",
        show_buffer_close_icons = false,
        show_close_icon = false,
      },
    },
  },
}
