return {
  -- Main mason plugin
  {
    "williamboman/mason.nvim",
    dependencies = {
      -- Bridges mason with nvim-lspconfig
      "williamboman/mason-lspconfig.nvim",
      -- Automatically installs non-LSP tools (formatters, linters)
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
      -- Import mason safely
      local mason = require("mason")
      local mason_lspconfig = require("mason-lspconfig")
      local mason_tool_installer = require("mason-tool-installer")

      -- Enable epic custom icons and borders in the UI
      mason.setup({
        ui = {
          border = "rounded",
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })

      -- Declare your LSPs for auto-installation
      mason_lspconfig.setup({
        ensure_installed = {
          "lua_ls",     -- Lua
          "tsserver",   -- TypeScript/JavaScript
          "html",       -- HTML
          "cssls",      -- CSS
          "pyright",    -- Python
          "clangd",     -- C/C++ LSP
        },
        -- Automatically install configured servers
        automatic_installation = true,
      })

      -- Declare formatters, linters, and debuggers for auto-installation
      mason_tool_installer.setup({
        ensure_installed = {
          "stylua",        -- Lua formatter
          "prettier",      -- JS/TS/HTML/CSS formatter
          "eslint_d",      -- Fast JS/TS linter
          "black",         -- Python formatter
          "debugpy",       -- Python debugger
          "clang-format",  -- C/C++ Formatter
          "codelldb",      -- C/C++/Rust Debugger (LLDB backend)
        },
        -- Automatically check for updates on startup
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}

