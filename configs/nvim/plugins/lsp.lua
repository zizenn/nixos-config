return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local servers = {
      clangd = {},
      ts_ls = {},
      nixd = {},
      html = {},
      cssls = {},
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
      bashls = {},
      pyright = {},
      jsonls = {},
      yamlls = {},
      marksman = {},
    }

    for server, config in pairs(servers) do
      local ok, _ = pcall(vim.lsp.config, server, config)
      if ok then pcall(vim.lsp.enable, server) end
    end

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
}
