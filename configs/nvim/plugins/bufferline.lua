return {
  "akinsho/bufferline.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
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
