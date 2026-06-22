return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "TSInstall", "TSInstallSync", "TSUpdate", "TSBuildInfo" },
  build = function()
    local parsers = {
      "c", "cpp", "lua", "vim", "vimdoc", "python", "bash",
      "html", "css", "javascript", "typescript", "nix", "json", "yaml",
      "markdown", "markdown_inline", "regex", "diff",
    }
    local install = pcall(require, "nvim-treesitter.install")
    if install then
      require("nvim-treesitter.install").install(parsers)
    end
  end,
  config = function()
    vim.filetype.add({
      extension = {
        h = "c",
      },
    })
  end,
}
