return {
  {
    "folke/flash.nvim",
    event = { "BufReadPre", "BufNewFile" },
    keys = {
      {
        "s",
        mode = { "n", "x", "o" },
        function() require("flash").jump() end,
        desc = "Flash Jump",
      },
      {
        "S",
        mode = { "n", "x", "o" },
        function() require("flash").treesitter() end,
        desc = "Flash Treesitter",
      },
    },
    opts = {
      label = {
        rainbow = {
          enabled = true,
        },
      },
      jump = {
        autojump = true,
      },
    },
  },
}
