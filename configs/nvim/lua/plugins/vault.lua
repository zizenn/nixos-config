return {
  "oleksiiluchnikov/vault.nvim",
  version = "*",
  dependencies = {
    "oleksiiluchnikov/vimtable.nvim",
  },
  keys = {
    { "<leader>v", "<cmd>Vault<CR>", desc = "Vault meta-picker" },
    { "<leader>vf", "<cmd>Vault fleeting<CR>", desc = "Vault fleeting note" },
    { "<leader>vt", "<cmd>Vault today<CR>", desc = "Vault daily note" },
    { "<leader>vq", "<cmd>Vault note<CR>", desc = "Vault notes picker" },
    { "<leader>vb", "<cmd>Vault bases<CR>", desc = "Vault bases picker" },
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
