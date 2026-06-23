return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufWritePost" },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      lua = { "selene" },
      python = { "pylint" },
      sh = { "shellcheck" },
      zsh = { "shellcheck" },
      javascript = { "eslint" },
      typescript = { "eslint" },
    }

    -- selene config: custom args for file-based config
    lint.linters.selene = {
      args = { "--config", vim.fn.stdpath("config") .. "/.selene.toml" },
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
