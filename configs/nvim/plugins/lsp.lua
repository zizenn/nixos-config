return {
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- LSP servers not available via mason (nixd, marksman)
      local extra_servers = {
        nixd = {},
        marksman = {},
      }

      for server, config in pairs(extra_servers) do
        if vim.fn.executable(server) == 1 then
          local ok, _ = pcall(vim.lsp.config, server, config)
          if ok then pcall(vim.lsp.enable, server) end
        end
      end

      -- Keymaps
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "<leader>li", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { bufnr = ev.buf })
          end, opts)
          vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
        end,
      })
    end,
  },
}
