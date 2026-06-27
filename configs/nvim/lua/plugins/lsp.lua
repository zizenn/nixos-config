return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "hrsh7th/cmp-nvim-lsp",
      "folke/neodev.nvim",
    },
    opts = {
      servers = {
        lua_ls = {
          settings = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              hint = { enable = true },
            },
          },
        },
        pyright = {},
        ruff = {},
        tsserver = {},
        html = {},
        cssls = {},
        jsonls = {},
        yamlls = {},
        dockerls = {},
        bashls = {},
        clangd = {},
        gopls = {},
        rust_analyzer = {},
        nixd = {},
        marksman = {},
        vimls = {},
      },
      setup = {},
    },
    config = function(_, opts)
      require("neodev").setup()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      local on_attach = function(client, bufnr)
        local map = function(keys, func, desc)
          vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
        end

        map("gd", vim.lsp.buf.definition, "Goto Definition")
        map("gr", vim.lsp.buf.references, "References")
        map("gI", vim.lsp.buf.implementation, "Goto Implementation")
        map("gy", vim.lsp.buf.type_definition, "Goto Type Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("K", vim.lsp.buf.hover, "Hover")
        map("gK", vim.lsp.buf.signature_help, "Signature Help")
        map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("<leader>cr", vim.lsp.buf.rename, "Rename")
        map("<leader>cf", function() vim.lsp.buf.format({ async = true }) end, "Format")
        map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
        map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        map("<leader>cd", vim.diagnostic.open_float, "Line Diagnostics")

        if client.server_capabilities.inlayHintProvider then
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end
      end

      for server, server_opts in pairs(opts.servers) do
        server_opts.capabilities = capabilities
        server_opts.on_attach = on_attach
        lspconfig[server].setup(server_opts)
      end

      vim.diagnostic.config({
        virtual_text = { spacing = 4, prefix = "●" },
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = { border = "rounded", source = "always" },
      })

      local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
    end,
  },
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "pyright",
        "ruff",
        "typescript-language-server",
        "html-lsp",
        "css-lsp",
        "json-lsp",
        "yaml-language-server",
        "dockerfile-language-server",
        "bash-language-server",
        "clangd",
        "gopls",
        "rust-analyzer",
        "nixd",
        "marksman",
        "vim-language-server",
        "stylua",
        "black",
        "isort",
        "prettier",
        "shfmt",
        "clang-format",
        "gofumpt",
        "rustfmt",
        "prettierd",
        "eslint_d",
      },
      ui = { border = "rounded" },
    },
    config = function(_, opts)
      require("mason").setup(opts)
      local mr = require("mason-registry")
      mr:on("package:install:success", function()
        vim.defer_fn(function() require("lazy.core.handler.event").trigger({ event = "FileType", buf = vim.api.nvim_get_current_buf() }) end, 100)
      end)
      local function ensure_installed()
        for _, tool in ipairs(opts.ensure_installed) do
          local p = mr.get_package(tool)
          if not p:is_installed() then p:install() end
        end
      end
      if mr.refresh then mr.refresh(ensure_installed) else ensure_installed() end
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "mason.nvim" },
    opts = { automatic_installation = true },
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
    },
    opts = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      local has_words_before = function()
        unpack = unpack or table.unpack
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
      end

      return {
        completion = { completeopt = "menu,menuone,noinsert" },
        snippet = {
          expand = function(args) luasnip.lsp_expand(args.body) end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace, select = true }),
          ["<C-CR>"] = function(fallback)
            cmp.abort()
            fallback()
          end,
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
        formatting = {
          format = function(entry, vim_item)
            local icons = {
              Text = "󰉿", Method = "󰆧", Function = "󰊕", Constructor = "󰒓",
              Field = "󰜢", Variable = "󰀫", Class = "󰠱", Interface = "󰜰",
              Module = "󰅩", Property = "󰜢", Unit = "󰑭", Value = "󰎠",
              Enum = "󰕘", Keyword = "󰌋", Snippet = "󰅩", Color = "󰏘",
              File = "󰈙", Reference = "󰈇", Folder = "󰉋", EnumMember = "󰕘",
              Constant = "󰏿", Struct = "󰙅", Event = "󰁪", Operator = "󰆕",
              TypeParameter = "󰊄",
            }
            vim_item.kind = string.format("%s %s", icons[vim_item.kind] or "", vim_item.kind)
            vim_item.menu = ({ nvim_lsp = "[LSP]", luasnip = "[Snippet]", buffer = "[Buffer]", path = "[Path]" })[entry.source.name]
            return vim_item
          end,
        },
        experimental = { ghost_text = true },
        window = {
          completion = cmp.config.window.bordered({ border = "rounded" }),
          documentation = cmp.config.window.bordered({ border = "rounded" }),
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      cmp.setup(opts)

      cmp.setup.cmdline({ "/", "?" }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = { { name = "buffer" } },
      })

      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({ { name = "path" } }, { { name = "cmdline" } }),
      })
    end,
  },
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip").config.setup({ history = true, updateevents = "TextChanged,TextChangedI" })
    end,
  },
  {
    "nvimdev/lspsaga.nvim",
    event = "LspAttach",
    dependencies = { "nvim-tree/nvim-web-devicons", "nvim-treesitter/nvim-treesitter" },
    opts = {
      ui = { border = "rounded", title = true, winblend = 0, expand = "󰐕", collapse = "󰍴", code_action = "󰌶", incoming = "󰏷", outgoing = "󰏻" },
      symbol_in_winbar = { enable = true, separator = " 󰅂 ", hide_keyword = true, show_file = true, folder_level = 2, color_mode = true },
      lightbulb = { enable = true, sign = true, virtual_text = false, debounce = 10, sign_priority = 40 },
      diagnostic = { show_code_action = true, jump_num_shortcut = true, max_width = 0.8, max_height = 0.6, text_hl_follow = true, border_follow = true, keys = { exec_action = "o", quit = "q", toggle_or_jump = "<CR>", quit_in_show = { "q", "<ESC>" } } },
      code_action = { num_shortcut = true, show_server_name = true, extend_gitsigns = true, keys = { quit = "q", exec = "<CR>" } },
      rename = { in_select = false, auto_save = false, keys = { quit = "<ESC>", exec = "<CR>", select = "x" } },
      outline = { win_position = "right", win_width = 30, auto_preview = true, detail = true, auto_close = true, keys = { jump = "o", expand_collapse = "u", quit = "q" } },
      callhierarchy = { keys = { edit = "e", vsplit = "s", split = "i", tabe = "t", quit = "q", shuttle = "[w", toggle_or_req = "u", close = "<C-c>k" } },
      finder = { max_height = 0.5, left_width = 0.3, right_width = 0.3, default = "ref+def+imp", keys = { shuttle = "[w", toggle_or_open = "o", vsplit = "s", split = "i", tabe = "t", tabnew = "r", quit = "q", close = "<ESC>" } },
      definition = { width = 0.6, height = 0.5, keys = { edit = "<C-c>o", vsplit = "<C-c>v", split = "<C-c>i", tabe = "<C-c>t", quit = "q", close = "<ESC>" } },
      hover = { max_width = 0.6, open_link = "gx", open_browser = "!chrome" },
      implement = { enable = true, sign = true, virtual_text = false, priority = 100 },
      typehierarchy = { keys = { edit = "e", vsplit = "s", split = "i", tabe = "t", quit = "q", shuttle = "[w", toggle_or_req = "u", close = "<C-c>k" } },
    },
    keys = {
      { "<leader>cl", "<cmd>Lspsaga show_line_diagnostics<cr>", desc = "Line Diagnostics" },
      { "<leader>cb", "<cmd>Lspsaga show_buf_diagnostics<cr>", desc = "Buffer Diagnostics" },
      { "<leader>cw", "<cmd>Lspsaga show_workspace_diagnostics<cr>", desc = "Workspace Diagnostics" },
      { "<leader>co", "<cmd>Lspsaga outline<cr>", desc = "Outline" },
      { "<leader>ci", "<cmd>Lspsaga incoming_calls<cr>", desc = "Incoming Calls" },
      { "<leader>cI", "<cmd>Lspsaga outgoing_calls<cr>", desc = "Outgoing Calls" },
      { "<leader>ct", "<cmd>Lspsaga term_toggle<cr>", desc = "Toggle Terminal" },
      { "gh", "<cmd>Lspsaga hover_doc<cr>", desc = "Hover Doc" },
      { "gH", "<cmd>Lspsaga hover_doc ++keep<cr>", desc = "Hover Doc (Keep)" },
      { "<leader>ca", "<cmd>Lspsaga code_action<cr>", desc = "Code Action" },
      { "<leader>cr", "<cmd>Lspsaga rename<cr>", desc = "Rename" },
      { "<leader>cR", "<cmd>Lspsaga rename ++project<cr>", desc = "Rename (Project)" },
    },
  },
}