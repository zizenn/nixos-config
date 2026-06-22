return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSInstallSync", "TSUpdate", "TSBuildInfo" },
  opts = {
    ensure_installed = {
      "c", "cpp", "lua", "vim", "vimdoc", "python", "bash",
      "html", "css", "javascript", "typescript", "nix", "json", "yaml",
      "markdown", "markdown_inline", "regex", "diff",
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        scope_incremental = false,
        node_decremental = "<BS>",
      },
    },
  },
}
