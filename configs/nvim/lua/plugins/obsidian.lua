return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "main",
          path = "~/path/to/your/vault",  -- update this
        },
      },
    },
  },
}
