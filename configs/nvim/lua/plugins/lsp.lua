return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      local servers = {
        clangd = {},
        nil_ls = {},  -- nix
        lua_ls = {
          settings = {
            Lua = {
              diagnostics = { globals = { "vim" } },
            },
          },
        },
        pyright = {},
        html = {},
        cssls = {},
        ts_ls = {},
      }

      for name, opts in pairs(servers) do
        lspconfig[name].setup(opts)
      end

      -- keymaps on LSP attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local map = function(keys, fn, desc)
            vim.keymap.set("n", keys, fn, { buffer = bufnr, desc = desc })
          end
          map("gd", vim.lsp.buf.definition, "Goto Definition")
          map("gr", vim.lsp.buf.references, "Goto References")
          map("K", vim.lsp.buf.hover, "Hover Docs")
          map("<leader>rn", vim.lsp.buf.rename, "Rename")
          map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
          map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
          map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
        end,
      })
    end,
  },
}
