return {
  "lukas-reineke/indent-blankline.nvim",
  event = { "BufReadPost", "BufNewFile" },
  config = function()
    require("ibl").setup({
      indent = { char = "│", tab_char = "│" },
      scope = {
        enabled = true,
        show_start = false,
        show_end = false,
        highlight = { "IblScope" },
      },
      exclude = {
        filetypes = {
          "dashboard", "neo-tree", "TelescopePrompt",
          "help", "terminal", "lazy", "mason",
        },
      },
    })
  end,
}
