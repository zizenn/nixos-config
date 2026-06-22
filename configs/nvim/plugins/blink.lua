return {
  "saghen/blink.cmp",
  version = "*",
  event = "InsertEnter",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saghen/blink.compat",
  },
  opts = {
    fuzzy = { implementation = "lua" },
    signature = { enabled = false },
    completion = {
      trigger = {
        show_on_insert = true,
        show_on_trigger_character = true,
        show_on_backspace = true,
      },
      list = {
        selection = { preselect = false, auto_insert = true },
      },
      menu = {
        auto_show = true,
        border = "rounded",
        min_width = 35,
        auto_show_delay_ms = 100,
      },
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
}
