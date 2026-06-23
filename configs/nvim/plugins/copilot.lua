return {
  "zbirenbaum/copilot.lua",
  cmd = "Copilot",
  event = "InsertEnter",
  config = function()
    require("copilot").setup({
      suggestion = {
        enabled = true,
        auto_trigger = true,
        keymap = {
          accept = "<M-l>",
          next = "<M-]>",
          prev = "<M-[>",
          dismiss = "<C-]>",
        },
        hint = {
          enabled = true,
          side = "right",
          format = "  accept: %s  next: %s  prev: %s  dismiss: %s",
        },
      },
      panel = { enabled = false },
    })
  end,
}
