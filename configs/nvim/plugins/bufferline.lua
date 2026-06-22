return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  keys = {
    { "]b", "<cmd>BufferLineCycleNext<CR>", desc = "Next buffer" },
    { "[b", "<cmd>BufferLineCyclePrev<CR>", desc = "Prev buffer" },
    { "<leader>1", "<cmd>BufferLineGoToBuffer 1<CR>", desc = "Buffer 1" },
    { "<leader>2", "<cmd>BufferLineGoToBuffer 2<CR>", desc = "Buffer 2" },
    { "<leader>3", "<cmd>BufferLineGoToBuffer 3<CR>", desc = "Buffer 3" },
    { "<leader>4", "<cmd>BufferLineGoToBuffer 4<CR>", desc = "Buffer 4" },
    { "<leader>5", "<cmd>BufferLineGoToBuffer 5<CR>", desc = "Buffer 5" },
    { "<leader>6", "<cmd>BufferLineGoToBuffer 6<CR>", desc = "Buffer 6" },
    { "<leader>7", "<cmd>BufferLineGoToBuffer 7<CR>", desc = "Buffer 7" },
    { "<leader>8", "<cmd>BufferLineGoToBuffer 8<CR>", desc = "Buffer 8" },
    { "<leader>9", "<cmd>BufferLineGoToBuffer 9<CR>", desc = "Buffer 9" },
    { "<leader>bb", "<cmd>BufferLinePick<CR>", desc = "Pick buffer" },
    { "<leader>bd", "<cmd>bd<CR>", desc = "Close buffer" },
    { "<leader>bD", "<cmd>bd!<CR>", desc = "Force close buffer" },
  },
  opts = {
    options = {
      mode = "tabs",
      separator_style = "thin",
      always_show_tabline = false,
      show_buffer_close_icons = false,
      show_close_icon = false,
      color_icons = true,
      diagnostics = "nvim_lsp",
      diagnostics_indicator = function(_, _, diag)
        local icons = {
          error = "  ",
          warn = "  ",
          info = "  ",
          hint = "  ",
        }
        local ret = ""
        for severity, icon in pairs(icons) do
          local count = diag[severity]
          if count and count > 0 then
            ret = ret .. icon .. count .. " "
          end
        end
        return ret ~= "" and ret or ""
      end,
    },
    highlights = {
      background = { bg = "NONE" },
      buffer_selected = { bg = "NONE", bold = true },
      separator_selected = { fg = "#575279" },
      separator = { fg = "#1A1B26" },
    },
  },
}
