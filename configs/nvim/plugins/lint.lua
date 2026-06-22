return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      python = { "pylint" },
      sh = { "shellcheck" },
      zsh = { "shellcheck" },
      javascript = { "eslint" },
      typescript = { "eslint" },
    }

    vim.api.nvim_create_autocmd("BufWritePost", {
      callback = function()
        local ft = vim.bo.filetype
        if lint.linters_by_ft[ft] then
          lint.try_lint()
        end
      end,
    })
  end,
}
