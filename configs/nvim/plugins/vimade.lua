return {
  "tadaa/vimade",
  lazy = false,
  config = function()
    require("vimade").setup({
      recipe = { "minimalist", { animate = true } },
      fadelevel = 0.6,
    })
  end,
}
