return {
  "akinsho/toggleterm.nvim",
  cmd = { "ToggleTerm", "TermExec", "Lazygit" },
  keys = {
    { "<leader>tt", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
    { "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", desc = "Float Terminal" },
    { "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Horizontal Terminal" },
    { "<leader>tv", "<cmd>ToggleTerm direction=vertical size=80<CR>", desc = "Vertical Terminal" },
    { "<leader>gg", "<cmd>Lazygit<CR>", desc = "Lazygit" },
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
  config = function(_, opts)
    require("toggleterm").setup(opts)
    vim.api.nvim_create_user_command("Lazygit", function()
      require("toggleterm").exec("lazygit", nil, nil, nil, "float")
    end, { desc = "Open lazygit in floating terminal" })
  end,
}
