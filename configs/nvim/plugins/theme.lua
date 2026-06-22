return {
  {
    -- Tells Lazy to load the plugin from your local configuration directory
    dir = vim.fn.stdpath("config") .. "/lua/matugen",
    name = "matugen",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme matugen")
    end,
  }
}
