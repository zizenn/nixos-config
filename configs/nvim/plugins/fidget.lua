return {
  "j-hui/fidget.nvim",
  event = "LspAttach",
  opts = {
    progress = {
      display = {
        progress_icon = { pattern = "dots", period = 1 },
        done_icon = "✓",
        done_style = "Constant",
      },
      animation = { steps = 20, interval = 40 },
    },
    notification = { override_vim_notify = false },
  },
}
