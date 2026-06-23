return {
  {
    "williamboman/mason.nvim",
    cmd = "Mason",
    build = ":MasonUpdate",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
    opts = {
      ensure_installed = {
        "clangd",
        "ts_ls",
        "html",
        "cssls",
        "lua_ls",
        "bashls",
        "pyright",
        "jsonls",
        "yamlls",
      },
      handlers = {
        function(server_name)
          local servers = {
            clangd = {},
            ts_ls = {},
            html = {},
            cssls = {},
            jsonls = {},
            yamlls = {},
            bashls = {},
            pyright = {},
            marksman = {},
            nixd = {},
            lua_ls = {
              settings = {
                Lua = {
                  runtime = { version = "LuaJIT" },
                  diagnostics = { globals = { "vim" } },
                  workspace = { checkThirdParty = false, library = vim.api.nvim_get_runtime_file("", true) },
                  telemetry = { enable = false },
                },
              },
            },
          }
          local config = servers[server_name] or {}
          local ok, _ = pcall(vim.lsp.config, server_name, config)
          if ok then pcall(vim.lsp.enable, server_name) end
        end,
      },
    },
  },
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    opts = {
      ensure_installed = {
        "codelldb",
        "js-debug-adapter",
        "debugpy",
        "bash-debug-adapter",
      },
    },
  },
}
