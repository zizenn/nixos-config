require("flash").setup({
  label = {
    rainbow = {
      enabled = true,
    },
  },
  jump = {
    autojump = true,
  },
})

vim.keymap.set({ "n", "x", "o" }, "s", function()
  require("flash").jump()
end, { desc = "Flash Jump" })
vim.keymap.set({ "n", "x", "o" }, "S", function()
  require("flash").treesitter()
end, { desc = "Flash Treesitter" })
