return {
  {
    "matugen",
    lazy = false,
    priority = 1000, -- Forces the theme to load before syntax plugins attach
    config = function()
      vim.cmd("colorscheme matugen")
    end,
  }
}
