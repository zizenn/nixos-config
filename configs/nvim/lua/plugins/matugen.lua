return {
  "Senal-D-A-Gunaratna/matugen.nvim",
  lazy = false,
  priority = 1000,
  opts = {
    load_theme = true,

    jsonc_path = vim.fn.expand("~/.config/matugen/themes/nvim-colors.jsonc"),
  },
  config = function(_, opts)
    require("matugen").setup(opts)
    vim.api.nvim_create_autocmd("ColorScheme", {
      group = vim.api.nvim_create_augroup("matugen_fix", { clear = true }),
      callback = function()
        if pcall(require, "nvim-treesitter") then
          vim.cmd("TSBufEnable highlight")
        end
      end,
    })
  end,
}
