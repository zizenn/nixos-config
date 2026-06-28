return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSInstallSync", "TSUpdate", "TSBuildInfo" },
  build = ":TSUpdate",
  config = function()
    vim.filetype.add({
      extension = {
        h = "c",
      },
    })

    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c", "cpp", "lua", "vim", "vimdoc", "python", "bash",
        "html", "css", "javascript", "typescript", "nix", "json", "yaml",
        "markdown", "markdown_inline", "regex", "diff",
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = true },
      textobjects = { enable = true },
    })
  end,
}
