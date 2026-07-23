return {
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = function()
      local harpoon = require("harpoon")
      local keys = {
        {
          "<leader>a",
          function() harpoon:list():add() end,
          desc = "Harpoon: Mark file",
        },
        {
          "<C-e>",
          function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
          desc = "Harpoon: Toggle menu",
        },
      }
      for i = 1, 5 do
        table.insert(keys, {
          ("<C-%s>"):format(i),
          function() harpoon:list():select(i) end,
          desc = ("Harpoon: Go to mark %s"):format(i),
        })
      end
      return keys
    end,
    config = function()
      require("harpoon").setup({})
    end,
  },
}
