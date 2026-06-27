return {
  "folke/flash.nvim",
  event = "VeryLazy",
  keys = {
    { "ss", function() require("flash").jump() end, desc = "Flash" },
    { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter" },
    { "<leader>r", function() require("flash").remote() end, desc = "Flash Remote" },
  },
  opts = {},
}
