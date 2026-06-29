return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSUpdate" },
  build = ":TSUpdate",
  config = function()
    vim.filetype.add({
      extension = {
        h = "c",
      },
    })

    require("nvim-treesitter.config").setup({})

    local ensure_installed = {
      "c", "cpp", "lua", "vim", "vimdoc", "python", "bash",
      "html", "css", "javascript", "typescript", "nix", "json", "yaml",
      "markdown", "markdown_inline", "regex", "diff",
    }

    require("nvim-treesitter.install").install(ensure_installed)

    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        pcall(vim.treesitter.start)
        vim.bo[args.buf].indentexpr = 'v:lua.require"nvim-treesitter".indentexpr()'
      end,
    })
  end,
}
