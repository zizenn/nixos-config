require("bufferline").setup({
  options = {
    mode = "buffers",
    separator_style = "thin",
    always_show_bufferline = true,
    sort_by = "insert_after_current",
    show_buffer_close_icons = false,
    show_close_icon = false,
  },
})

vim.keymap.set("n", "<Tab>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Previous buffer" })
