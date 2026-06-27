return {
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
  -- Runs early to patch nvim-notify's background fallback before noice boots
  init = function()
    require("notify").setup({
      background_colour = "#111216", -- Dark inkier backdrop to prevent the warning
    })
  end,
  opts = {
    lsp = {
      hover = { enabled = false },
      signature = { enabled = false },
    },
    cmdline = { view = "cmdline_popup" },
    views = {
      cmdline_popup = {
        position = { row = "38%", col = "50%" },
        size = { width = 65, height = "auto" },
        border = { style = "rounded", padding = { 0, 1 } },
        win_options = { winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" } },
      },
    },
    presets = {
      bottom_search = false,
      command_palette = false,
      long_message_to_split = true,
      inc_rename = true,
    },
  },
}
