{ config, pkgs, ... }:

let
  # Theme selection: "matugen" or "kanagawa-dragon"
  theme = "matugen";
in
{
  xdg.configFile = {
    # ---------------------------------------------------------
    # MATUGEN THEME CONFIGURATION (FIXED BACKGROUNDS)
    # ---------------------------------------------------------
    "nvim/lua/matugen/init.lua".text = ''
      local M = {}
      local colors = {}

      local function load_colors()
        local ok, c = pcall(require, "matugen.colors")
        if ok then
          colors = c
          return true
        end
        return false
      end

      function M.setup(opts)
        opts = opts or {}
        if not load_colors() then
          colors = {
            surface = "#11111b",
            on_surface = "#cdd6f4",
            surface_variant = "#1e1e2e",
            on_surface_variant = "#a6adc8",
            primary = "#89b4fa",
            on_primary = "#1e1e2e",
            primary_container = "#313244",
            on_primary_container = "#89b4fa",
            secondary = "#a6e3a1",
            on_secondary = "#1e1e2e",
            secondary_container = "#313244",
            on_secondary_container = "#a6e3a1",
            tertiary = "#f5c2e7",
            on_tertiary = "#1e1e2e",
            tertiary_container = "#313244",
            on_tertiary_container = "#f5c2e7",
            error = "#f38ba8",
            on_error = "#1e1e2e",
            error_container = "#45475a",
            on_error_container = "#f38ba8",
            outline = "#585b70",
            background = "#11111b",
            on_background = "#cdd6f4",
          }
        end
        M.apply()
      end

      function M.apply()
        local c = colors
        local bg = c.surface
        local fg = c.on_surface

        local function hl(group, opts)
          local cmd = "highlight " .. group
          if opts.fg then cmd = cmd .. " guifg=" .. opts.fg end
          if opts.bg then cmd = cmd .. " guibg=" .. opts.bg end
          if opts.sp then cmd = cmd .. " guisp=" .. opts.sp end
          if opts.style then cmd = cmd .. " gui=" .. opts.style end
          pcall(vim.cmd, cmd)
        end

        -- Editor background configurations
        hl("Normal", { fg = fg, bg = bg })
        hl("NormalFloat", { fg = fg, bg = bg }) 
        hl("FloatBorder", { fg = c.primary, bg = bg }) 
        hl("CursorLine", { bg = c.surface_variant })
        hl("CursorLineNr", { fg = c.primary })
        hl("CursorColumn", { bg = c.surface_variant })
        hl("LineNr", { fg = c.on_surface_variant })
        hl("SignColumn", { bg = bg })
        hl("ColorColumn", { bg = c.surface_variant })
        hl("Conceal", { fg = c.on_surface_variant })
        hl("Cursor", { fg = bg, bg = fg })
        hl("Visual", { bg = c.primary_container })
        hl("VisualNOS", { bg = c.primary_container })
        hl("Search", { fg = c.on_tertiary_container, bg = c.tertiary_container })
        hl("CurSearch", { fg = c.on_primary, bg = c.primary })
        hl("Substitute", { fg = c.on_error, bg = c.error })
        hl("MatchParen", { fg = c.primary, style = "bold" })
        hl("NonText", { fg = c.outline })
        hl("Whitespace", { fg = c.outline })
        hl("SpecialKey", { fg = c.outline })
        hl("EndOfBuffer", { fg = bg })
        hl("Title", { fg = c.primary, style = "bold" })
        hl("WinSeparator", { fg = c.outline })
        hl("StatusLine", { fg = fg, bg = c.surface_variant })
        hl("StatusLineNC", { fg = c.on_surface_variant, bg = bg })
        hl("TabLine", { fg = c.on_surface_variant, bg = bg })
        hl("TabLineSel", { fg = c.on_primary, bg = c.primary })
        hl("TabLineFill", { bg = bg })
        hl("MsgArea", { fg = fg, bg = bg })
        hl("ModeMsg", { fg = c.primary })
        hl("MoreMsg", { fg = c.primary })
        hl("Question", { fg = c.primary })
        hl("WarningMsg", { fg = c.tertiary })
        hl("ErrorMsg", { fg = c.error })

        -- Drop-down popup menu configurations
        hl("Pmenu", { fg = fg, bg = c.surface_variant })
        hl("PmenuSel", { fg = c.on_primary_container, bg = c.primary_container })
        hl("PmenuKind", { fg = c.tertiary, bg = c.surface_variant })
        hl("PmenuKindSel", { fg = c.on_tertiary_container, bg = c.tertiary_container })
        hl("PmenuExtra", { fg = c.on_surface_variant, bg = c.surface_variant })
        hl("PmenuExtraSel", { fg = c.on_primary_container, bg = c.primary_container })
        hl("PmenuSbar", { bg = c.surface_variant })
        hl("PmenuThumb", { bg = c.outline })

        -- Language Syntax Rules
        hl("Comment", { fg = c.on_surface_variant, style = "italic" })
        hl("String", { fg = c.primary })
        hl("Character", { fg = c.primary })
        hl("Number", { fg = c.primary })
        hl("Boolean", { fg = c.primary })
        hl("Float", { fg = c.primary })
        hl("Function", { fg = c.tertiary })
        hl("Keyword", { fg = c.secondary })
        hl("Statement", { fg = c.secondary })
        hl("Conditional", { fg = c.secondary })
        hl("Repeat", { fg = c.secondary })
        hl("Label", { fg = c.secondary })
        hl("Operator", { fg = fg })
        hl("Exception", { fg = c.error })
        hl("Include", { fg = c.secondary })
        hl("Define", { fg = c.secondary })
        hl("Macro", { fg = c.secondary })
        hl("PreProc", { fg = c.secondary })
        hl("PreCondit", { fg = c.secondary })
        hl("Type", { fg = c.tertiary })
        hl("StorageClass", { fg = c.secondary })
        hl("Structure", { fg = c.tertiary })
        hl("Typedef", { fg = c.tertiary })
        hl("Identifier", { fg = fg })
        hl("Constant", { fg = c.primary })
        hl("Special", { fg = c.primary })
        hl("SpecialChar", { fg = c.primary })
        hl("Tag", { fg = c.tertiary })
        hl("Delimiter", { fg = c.outline })
        hl("SpecialComment", { fg = c.on_surface_variant, style = "italic" })
        hl("Debug", { fg = c.primary })
        hl("Underlined", { fg = c.tertiary, style = "underline" })
        hl("Bold", { style = "bold" })
        hl("Italic", { style = "italic" })
        hl("Ignore", { fg = c.on_surface_variant })
        hl("Todo", { fg = c.on_primary_container, bg = c.primary_container, style = "bold" })

        -- Git integration mappings
        hl("DiffAdd", { bg = c.primary_container })
        hl("DiffChange", { bg = c.tertiary_container })
        hl("DiffDelete", { bg = c.error_container })
        hl("DiffText", { bg = c.primary_container })
        hl("GitSignsAdd", { fg = c.primary })
        hl("GitSignsChange", { fg = c.tertiary })
        hl("GitSignsDelete", { fg = c.error })

        -- Global Diagnostic Engine Options
        hl("DiagnosticError", { fg = c.error })
        hl("DiagnosticWarn", { fg = c.tertiary })
        hl("DiagnosticInfo", { fg = c.primary })
        hl("DiagnosticHint", { fg = c.secondary })
        hl("DiagnosticOk", { fg = c.primary })
        hl("DiagnosticUnderlineError", { sp = c.error, style = "undercurl" })
        hl("DiagnosticUnderlineWarn", { sp = c.tertiary, style = "undercurl" })
        hl("DiagnosticUnderlineInfo", { sp = c.primary, style = "undercurl" })
        hl("DiagnosticUnderlineHint", { sp = c.secondary, style = "undercurl" })
        hl("DiagnosticUnderlineOk", { sp = c.primary, style = "undercurl" })
        hl("DiagnosticVirtualTextError", { fg = c.error, bg = c.error_container })
        hl("DiagnosticVirtualTextWarn", { fg = c.tertiary, bg = c.tertiary_container })
        hl("DiagnosticVirtualTextInfo", { fg = c.primary, bg = c.primary_container })
        hl("DiagnosticVirtualTextHint", { fg = c.secondary, bg = c.secondary_container })

        -- Telescope Interface Theme
        hl("TelescopeNormal", { fg = fg, bg = bg })
        hl("TelescopeBorder", { fg = c.outline, bg = bg })
        hl("TelescopePromptNormal", { fg = fg, bg = c.surface_variant })
        hl("TelescopePromptBorder", { fg = c.primary, bg = c.surface_variant })
        hl("TelescopePromptTitle", { fg = c.on_primary, bg = c.primary })
        hl("TelescopeResultsTitle", { fg = c.outline, bg = bg })
        hl("TelescopePreviewTitle", { fg = c.outline, bg = bg })
        hl("TelescopeSelection", { bg = c.primary_container })

        -- NvimTree Directory Navigation Panels
        hl("NvimTreeNormal", { fg = fg, bg = bg })
        hl("NvimTreeIndentMarker", { fg = c.outline })
        hl("NvimTreeGitDirty", { fg = c.tertiary })
        hl("NvimTreeGitStaged", { fg = c.primary })
        hl("NvimTreeGitNew", { fg = c.primary })
        hl("NvimTreeRootFolder", { fg = c.primary, style = "bold" })

        -- Context Parameter Engine Contexts
        hl("LspReferenceText", { bg = c.surface_variant })
        hl("LspReferenceRead", { bg = c.surface_variant })
        hl("LspReferenceWrite", { bg = c.surface_variant })
        hl("LspInlayHint", { fg = c.on_surface_variant, bg = c.surface_variant })

        -- Command Line Interface Fixes
        hl("NoiceMsg", { fg = fg })
        hl("NoicePopup", { bg = bg }) 
        hl("NoicePopupmenu", { bg = c.surface_variant })

        vim.g.colors_name = "matugen"
      end

      return M
    '';

    "nvim/lua/kanagawa-dragon/init.lua".text = ''
      local M = {}
      function M.setup(opts)
        opts = opts or {}
        require("kanagawa").setup(vim.tbl_deep_extend("force", {
          compile = false,
          undercurl = true,
          commentStyle = { italic = true },
          functionStyle = {},
          keywordStyle = { italic = true },
          statementStyle = { bold = true },
          transparent = false,
          theme = "dragon",
          background = { dark = "dragon", light = "lotus" },
        }, opts))
        vim.cmd.colorscheme("kanagawa-dragon")
      end
      return M
    '';

    "nvim/lua/plugins/theme.lua".text = if theme == "matugen" then ''
      return {
        dir = vim.fn.stdpath("config") .. "/lua/matugen",
        name = "matugen",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts)
          require("matugen").setup(opts)
          vim.schedule(function() pcall(vim.cmd.colorscheme, "matugen") end)
        end,
      }
    '' else ''
      return {
        "rebelot/kanagawa.nvim",
        name = "kanagawa",
        lazy = false,
        priority = 1000,
        opts = {},
        config = function(_, opts) require("kanagawa-dragon").setup(opts) end,
      }
    '';

    "nvim/lua/plugins/noice.lua".text = ''
      return {
        "folke/noice.nvim",
        event = "VeryLazy",
        dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" },
        opts = {
          lsp = {
            hover = { enabled = false },
            signature = { enabled = false },
          },
          cmdline = { view = "cmdline_popup" },
          views = {
            cmdline_popup = {
              position = { row = "38%", col = "50%" },
              size = { width = 65, height = "auto" },
              border = { style = "rounded", padding = { 0, 1 } },
              win_options = { winhighlight = { Normal = "NormalFloat", FloatBorder = "FloatBorder" } },
            },
          },
          presets = { bottom_search = false, command_palette = false, long_message_to_split = true, inc_rename = true },
        },
      }
    '';

    # ---------------------------------------------------------
    # NEW IDE-GRADE LSP & AUTOCOMPLETE spec (From Void Arc Architecture)
    # ---------------------------------------------------------
    "nvim/lua/plugins/lsp.lua".text = ''
      return {
        {
          "neovim/nvim-lspconfig",
          event = { "BufReadPre", "BufNewFile" },
          dependencies = { "hrsh7th/cmp-nvim-lsp" },
          config = function()
            local lspconfig = require("lspconfig")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- Core Languages (C, JS/TS, Nix, HTML, CSS)
            -- Note: On NixOS, ensure clangd, nixd, vtsls are installed via home.packages
            local servers = { "clangd", "ts_ls", "nixd", "html", "cssls" }
            for _, lsp in ipairs(servers) do
              lspconfig[lsp].setup({
                capabilities = capabilities,
              })
            end

            -- Global LSP Mappings (Triggered when language engine binds to buffer)
            vim.api.nvim_create_autocmd("LspAttach", {
              group = vim.api.nvim_create_augroup("UserLspConfig", {}),
              callback = function(ev)
                local opts = { buffer = ev.buf }
                vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts, { desc = "Go to Declaration" })
                vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts, { desc = "Go to Definition" })
                vim.keymap.set("n", "K", vim.lsp.buf.hover, opts, { desc = "Show Docs/Type Info" })
                vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts, { desc = "Go to Implementation" })
                vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts, { desc = "Symbol Refactor Rename" })
                vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts, { desc = "Trigger Code Actions" })
                vim.keymap.set("n", "gr", vim.lsp.buf.references, opts, { desc = "Trace References" })
              end,
            })
          end,
        },
        {
          "hrsh7th/nvim-cmp",
          event = "InsertEnter",
          dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "L3MON4D3/LuaSnip",
            "saadparwaiz1/cmp_luasnip",
          },
          config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
              snippet = {
                expand = function(args) luasnip.lsp_expand(args.body) end,
              },
              mapping = cmp.mapping.preset.insert({
                ["<C-b>"] = cmp.mapping.scroll_docs(-4),
                ["<C-f>"] = cmp.mapping.scroll_docs(4),
                ["<C-Space>"] = cmp.mapping.complete(),
                ["<C-e>"] = cmp.mapping.abort(),
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping(function(fallback)
                  if cmp.visible() then
                    cmp.select_next_item()
                  elseif luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
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
              }, {
                { name = "buffer" },
                { name = "path" },
              }),
            })
          end,
        }
      }
    '';

    # ---------------------------------------------------------
    # IMPROVED DAP (DEBUGGER PROTOCOL) SPECS & INTERFACES
    # ---------------------------------------------------------
    "nvim/lua/plugins/dap.lua".text = ''
      return {
        {
          "mfussenegger/nvim-dap",
          dependencies = {
            "theHamsta/nvim-dap-virtual-text",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
          },
          keys = {
            { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
            { "<leader>dc", function() require("dap").continue() end, desc = "Start Session / Continue" },
            { "<leader>do", function() require("dap").step_over() end, desc = "Step Over (Next Line)" },
            { "<leader>di", function() require("dap").step_into() end, desc = "Step Into Function" },
            { "<leader>dO", function() require("dap").step_out() end, desc = "Step Out of Function" },
            { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate Debugger" },
            { "<leader>du", function() require("dapui").toggle() end, desc = "Manual Toggle DAP UI Layout" },
          },
          config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            dapui.setup()
            require("nvim-dap-virtual-text").setup()

            -- Auto-toggle UI interface when diagnostic cycles start/stop
            dap.listeners.before.attach.dapui_config = function() dapui.open() end
            dap.listeners.before.launch.dapui_config = function() dapui.open() end
            dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
            dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

            -- Native GDB Adapter hookup for local system compiler assets
            dap.adapters.gdb = {
              type = "executable",
              command = "gdb",
              args = { "-i", "dap" }
            }

            dap.configurations.c = {
              {
                name = "Launch Native Engine Binary",
                type = "gdb",
                request = "launch",
                program = function()
                  return vim.fn.input('Path to target executable binary: ', vim.fn.getcwd() .. '/', 'file')
                end,
                cwd = "''${workspaceFolder}",
                stopOnEntry = false,
              },
            }

            local signs = {
              DapBreakpoint = { text = "󰏃", texthl = "DiagnosticSignError", linehl = "", numhl = "" },
              DapBreakpointCondition = { text = "󰟶", texthl = "DiagnosticSignWarn", linehl = "", numhl = "" },
              DapBreakpointRejected = { text = "󰏕", texthl = "DiagnosticSignHint", linehl = "", numhl = "" },
              DapLogPoint = { text = "󰛕", texthl = "DiagnosticSignInfo", linehl = "", numhl = "" },
              DapStopped = { text = "󰁕", texthl = "DiagnosticSignOk", linehl = "Visual", numhl = "DiagnosticSignOk" },
            }

            for name, sign in pairs(signs) do
              vim.fn.sign_define(name, sign)
            end
          end,
        },
      }
    '';
  };
}
