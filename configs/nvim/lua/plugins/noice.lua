return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  opts = {
    cmdline = {
      view = "cmdline_popup", -- Forces the command line into a floating popup box
    },
    views = {
      cmdline_popup = {
        position = {
          row = "40%", -- Positions it exactly 30% from the top of the screen
          col = "50%", -- Centers it horizontally
        },
        size = {
          width = 60,   -- Sets a clean, standard width for the bar
          height = "auto",
        },
      },
      popupmenu = {
        relative = "editor",
        position = {
          row = "40%", -- Places auto-complete options right below the centered bar
          col = "50%", -- Centers it horizontally
        },
        size = {
          width = 60,
          max_height = 10,
        },
        border = {
          style = "single",
          padding = { 0, 1 },
        },
        win_options = {
          winhighlight = { Normal = "Normal", FloatBorder = "DiagnosticInfo" },
        },
      },
    },
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
    },
    presets = {
      bottom_search = false,    -- Ensures search (`/`) also moves to the center
      command_palette = false,  -- Disabled so our custom view positions take priority
      long_message_to_split = true,
    },
  },
}

