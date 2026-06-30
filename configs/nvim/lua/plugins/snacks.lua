return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      bigfile = { enabled = true },
      dashboard = {
        enabled = true,
        preset = {
          header = [[
                     monke-cooks dev station
              ]],
        },
      },
      explorer = { enabled = true },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = { enabled = true, timeout = 3000 },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scope = { enabled = true },
      scroll = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
      terminal = { enabled = true },
      zen = { enabled = true },
      lazygit = { enabled = true },
      gitbrowse = { enabled = true },
    },
    keys = {
      { "<leader>z", function() Snacks.zen() end, desc = "Zen Mode" },
      { "<leader>gg", function() Snacks.lazygit() end, desc = "Lazygit" },
      { "<leader>bd", function() Snacks.bufdelete() end, desc = "Delete Buffer" },
    },
  },
}
