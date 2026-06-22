return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec" },
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Vertical Terminal" },
  },
  opts = {
    size = 15,
    open_mapping = false,
    direction = "float",
    float_opts = {
      border = "rounded",
      winhighlight = "NormalFloat,Normal",
    },
  },
}
