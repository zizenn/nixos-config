return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>oo", "<cmd>ObsidianOpen<cr>", desc = "Open in Obsidian" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search Notes" },
      { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily Note" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
      { "<leader>ol", "<cmd>ObsidianLinks<cr>", desc = "Links" },
      { "<leader>ot", "<cmd>ObsidianToggleCheckbox<cr>", desc = "Toggle Checkbox" },
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New Note" },
      { "<leader>or", "<cmd>ObsidianRename<cr>", desc = "Rename Note" },
      { "<leader>oq", "<cmd>ObsidianQuickCapture<cr>", desc = "Quick Capture" },
    },
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/Documents/vault",
        },
      },
    },
  },
}
