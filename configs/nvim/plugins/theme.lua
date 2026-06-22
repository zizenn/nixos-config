return {
  {
    dir = vim.fn.stdpath("config") .. "/lua/matugen",
    name = "matugen",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme matugen")
    end,
  }
}
