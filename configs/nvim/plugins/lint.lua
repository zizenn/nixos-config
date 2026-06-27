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
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      c = { "clangtidy" },
      cpp = { "clangtidy" },
    }

    -- selene config: custom args for file-based config
    lint.linters.selene = {
      cmd = "selene",
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
