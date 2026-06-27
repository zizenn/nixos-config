return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "rafamadriz/friendly-snippets",
  },
  opts = {
    fuzzy = { implementation = "lua" },
    signature = { enabled = false },
    appearance = {
      use_nvim_cmp_as_default = true,
      kind_icons = {
        Text = "󰉿",
        Method = "󰊕",
        Function = "󰊕",
        Constructor = "󰒓",
        Field = "󰜢",
        Variable = "󰆦",
        Class = "󰠱",
        Interface = "󰜗",
        Module = "󰏗",
        Property = "󰜢",
        Unit = "󰑭",
        Value = "󰎠",
        Enum = "󰒻",
        Keyword = "󰌋",
        Snippet = "󱄽",
        Color = "󰏘",
        File = "󰈙",
        Reference = "󰈇",
        Folder = "󰉋",
        EnumMember = "󰒻",
        Constant = "󰏿",
        Struct = "󰙅",
        Event = "󰅆",
        Operator = "󰆤",
        TypeParameter = "󰊄",
      },
    },
    completion = {
      trigger = {
        show_on_insert = false,
        show_on_trigger_character = true,
        show_on_backspace = true,
      },
      list = {
        selection = { preselect = false, auto_insert = false },
      },
      menu = {
        auto_show = true,
        border = "rounded",
        min_width = 35,
        auto_show_delay_ms = 100,
      },
    },
    snippets = {
      preset = "luasnip",
    },
    keymap = {
      ["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
      ["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
      ["<CR>"] = { "accept", "fallback" },
      ["<C-Space>"] = { "show", "fallback" },
      ["<C-e>"] = { "hide" },
      ["<C-b>"] = { "scroll_documentation_up" },
      ["<C-f>"] = { "scroll_documentation_down" },
    },
    sources = {
      default = { "lsp", "snippets", "buffer", "path" },
    },
  },
  config = function(_, opts)
    require("luasnip.loaders.from_vscode").lazy_load()
    require("blink.cmp").setup(opts)
  end,
}
