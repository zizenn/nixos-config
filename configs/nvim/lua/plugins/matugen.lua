return {
  "Senal-D-A-Gunaratna/matugen.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local matugen = require("matugen")
    matugen.setup({
      load_theme = true,
      palette_path = vim.fn.expand("~/.cache/matugen/themes/nvim-colors.jsonc"),
    })
    matugen.load()
    vim.g.colors_name = "matugen"
  end,
}
