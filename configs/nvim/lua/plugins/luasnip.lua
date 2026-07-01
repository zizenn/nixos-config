return {
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
    build = "make install_jsregexp",
    opts = {
      history = true,
      updateevents = "TextChanged,TextChangedI",
    },
    config = function(_, opts)
      require("luasnip").config.setup(opts)
      require("luasnip.loaders.from_vscode").lazy_load()
    end,
  },
}
