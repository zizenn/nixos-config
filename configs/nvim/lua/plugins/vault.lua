return {
  "oleksiiluchnikov/vault.nvim",
  version = "*",
  dependencies = {
    "oleksiiluchnikov/vimtable.nvim",
  },
  keys = {
    { "<leader>oo", "<cmd>Vault note obsidian<CR>", desc = "Open in Obsidian" },
    { "<leader>oq", "<cmd>Vault note<CR>", desc = "Notes picker" },
    { "<leader>os", "<cmd>Vault grep<CR>", desc = "Search vault" },
    { "<leader>ob", "<cmd>Vault note inlinks<CR>", desc = "Backlinks" },
    { "<leader>od", "<cmd>Vault today<CR>", desc = "Daily note" },
    { "<leader>ot", "<cmd>Vault note new<CR>", desc = "New note" },
    { "<leader>v", "<cmd>Vault<CR>", desc = "Vault meta-picker" },
    { "<leader>vf", "<cmd>Vault fleeting<CR>", desc = "Fleeting note" },
    { "<leader>vb", "<cmd>Vault bases<CR>", desc = "Bases picker" },
  },
  opts = {
    root = vim.fn.expand("~/Documents/vault"),
    dirs = {
      inbox = "inbox",
      docs = "_docs",
      templates = "_templates",
      journal = {
        root = "Journal",
        daily = "Journal/Daily",
        weekly = "Journal/Weekly",
        monthly = "Journal/Monthly",
        yearly = "Journal/Yearly",
      },
    },
    features = {
      cmp = false,
      commands = true,
      watcher = true,
    },
  },
}
