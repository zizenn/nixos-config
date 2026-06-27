return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      check_ts = true,
      ts_config = { java = false, javascript = { "template_string" }, typescript = { "template_string" } },
      fast_wrap = { map = "<M-e>", chars = { "{", "[", "(", '"', "'" }, pattern = [=[[%'%"%)%>%]%)%}%,]]=], end_key = "$", keys = "qwertyuiopzxcvbnmasdfghjkl", check_comma = true, highlight = "Search", highlight_grey = "Comment" },
      disable_filetype = { "TelescopePrompt", "vim" },
      enable_check_bracket_line = true,
      ignored_next_char = "[%w%%%.%[%]%{%}%]",
      enable_moveright = true,
      enable_afterquote = true,
      enable_bracket_in_quote = true,
      enable_abbr = false,
      break_undo = true,
      map_cr = true,
      map_bs = true,
      map_c_h = false,
      map_c_w = false,
    },
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    opts = {
      aliases = { ["a"] = ">", ["b"] = ")", ["B"] = "}", ["r"] = "]", ["q"] = { '"', "'", "`" }, ["s"] = { "}", "]", ")", ">", '"', "'", "`" } },
      highlight = { duration = 300 },
      move_cursor = "begin",
      indent_lines = function(start, stop) local b = vim.bo local i = b.shiftwidth == 0 and b.tabstop or b.shiftwidth return string.rep(" ", i) end,
    },
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = { line = "gcc", block = "gbc" },
      opleader = { line = "gc", block = "gb" },
      extra = { above = "gcO", below = "gco", eol = "gcA" },
      mappings = { basic = true, extra = true },
      pre_hook = function(ctx)
        local U = require("Comment.utils")
        local location = nil
        if ctx.ctype == U.ctype.block then location = U.get_region(ctx) elseif ctx.ctype == U.ctype.line then location = U.get_line(ctx) end
        return location
      end,
      post_hook = nil,
    },
  },
  {
    "tpope/vim-sleuth",
    event = { "BufReadPre", "BufNewFile" },
  },
  {
    "folke/todo-comments.nvim",
    event = "VimEnter",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      signs = true,
      sign_priority = 8,
      keywords = {
        FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "FIXIT", "ISSUE" } },
        TODO = { icon = " ", color = "info" },
        HACK = { icon = " ", color = "warning" },
        WARN = { icon = " ", color = "warning", alt = { "WARNING", "XXX" } },
        PERF = { icon = " ", color = "perf", alt = { "OPTIM", "PERFORMANCE", "OPTIMIZE" } },
        NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
        TEST = { icon = "⏲ ", color = "test", alt = { "TESTING", "PASSED", "FAILED" } },
      },
      merge_keywords = true,
      highlight = { multiline = true, pattern = [[.*<(KEYWORDS)\s*:]], comments_only = true, max_line_len = 400, exclude = {} },
      colors = {
        error = { "DiagnosticError", "ErrorMsg", "#f38ba8" },
        warning = { "DiagnosticWarn", "WarningMsg", "#fab387" },
        info = { "DiagnosticInfo", "#89b4fa" },
        hint = { "DiagnosticHint", "#89dceb" },
        default = { "Identifier", "#cdd6f4" },
        test = { "Identifier", "#cba6f7" },
        perf = { "DiagnosticInfo", "#89b4fa" },
      },
      search = { command = "rg", args = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" }, pattern = [[\b(KEYWORDS):]], },
    },
    keys = {
      { "]t", function() require("todo-comments").jump_next() end, desc = "Next Todo Comment" },
      { "[t", function() require("todo-comments").jump_prev() end, desc = "Previous Todo Comment" },
      { "<leader>xt", "<cmd>Trouble todo toggle<cr>", desc = "Todo (Trouble)" },
      { "<leader>xT", "<cmd>Trouble todo toggle filter = {tag = {FIX, FIXME, BUG}}<cr>", desc = "Todo/Fix/Fixme (Trouble)" },
    },
  },
  {
    "echasnovski/mini.pairs",
    event = "VeryLazy",
    opts = { modes = { insert = true, command = true, terminal = false }, skip_next = [=[[%w%%%'%[%"%.%`%$]]=], skip_ts = { "string" }, skip_unbalanced = true, markdown = true },
  },
  {
    "echasnovski/mini.ai",
    event = "VeryLazy",
    opts = function()
      local ai = require("mini.ai")
      return {
        n_lines = 500,
        custom_textobjects = {
          o = ai.gen_spec.treesitter({ a = { "@block.outer", "@conditional.outer", "@loop.outer" }, i = { "@block.inner", "@conditional.inner", "@loop.inner" } }),
          f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
          c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
          a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
          t = { "<([%p%w]-)%f[^<%w][^<>]->.-</%1>", "^<.->().*()</[^/]->$" },
        },
      }
    end,
  },
  {
    "echasnovski/mini.bufremove",
    keys = {
      { "<leader>bd", function() require("mini.bufremove").delete(0, false) end, desc = "Delete Buffer" },
      { "<leader>bD", function() require("mini.bufremove").delete(0, true) end, desc = "Delete Buffer (Force)" },
    },
    opts = {},
  },
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" } },
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
  },
  {
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    keys = { { "<leader>uz", "<cmd>ZenMode<cr>", desc = "Zen Mode" } },
    opts = { window = { backdrop = 0.95, width = 120, height = 1, options = { signcolumn = "no", number = false, relativenumber = false, cursorline = false, cursorcolumn = false, foldcolumn = "0", list = false } }, plugins = { options = { enabled = true, ruler = false, showcmd = false }, twilight = { enabled = true }, gitsigns = { enabled = false }, tmux = { enabled = false }, kitty = { enabled = false, font = "+4" } } },
  },
}