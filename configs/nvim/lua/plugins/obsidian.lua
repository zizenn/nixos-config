return {
  {
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<CR>", desc = "Open in Obsidian" },
      { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>", desc = "Obsidian quick switch" },
      { "<leader>os", "<cmd>ObsidianSearch<CR>", desc = "Search Obsidian notes" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<CR>", desc = "Obsidian backlinks" },
      { "<leader>od", "<cmd>ObsidianToday<CR>", desc = "Obsidian daily note" },
      { "<leader>ot", "<cmd>ObsidianTemplate<CR>", desc = "Insert Obsidian template" },
    },
    opts = {
      workspaces = {
        {
          name = "vault",
          path = vim.fn.expand("~/Documents/vault"),
        },
      },
      completion = {
        nvim_cmp = false,
        blink_cmp = true,
      },
      ui = { enable = false },
    },
  },
}
