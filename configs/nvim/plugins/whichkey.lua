return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    preset = "helix",
    delay = 300,
    icons = { mappings = false },
     spec = {
       { "<leader>d", group = "Debug" },
       { "<leader>g", group = "Git" },
       { "<leader>l", group = "LSP" },
       { "<leader>s", group = "Search" },
       { "<leader>t", group = "Toggle" },
       { "<leader>w", group = "Window" },
       { "<leader>x", group = "Diagnostics" },
     },
  },
}
