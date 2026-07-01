return {
  {
    "stevearc/conform.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file
    config = function()
      local conform = require("conform")

      conform.setup({
        -- Map filetypes to formatters
        formatters_by_ft = {
          lua = { "stylua" },
          python = { "black" },
          javascript = { "prettier" },
          typescript = { "prettier" },
          html = { "prettier" },
          css = { "prettier" },
          -- C/C++ setup using clang-format
          c = { "clang-format" },
          cpp = { "clang-format" },
        },

        -- Configure the format-on-save behavior
        format_on_save = {
          lsp_fallback = true,   -- Use LSP formatting if formatter isn't ready
          async = false,         -- Set to true if formatting slows down typing
          timeout_ms = 500,      -- Give up if formatting takes too long
        },

        -- Custom configurations for individual formatters
        formatters = {
          ["clang-format"] = {
            -- Pass custom styling options if you don't use a .clang-format file
            -- Example forces the Google or LLVM styles natively
            prepend_args = { "-style=file" }, -- Looks for a .clang-format file in your project
          },
        },
      })

      -- Optional: Create a user command to manually trigger formatting (:Format)
      vim.api.nvim_create_user_command("Format", function(args)
        local range = nil
        if args.count ~= -1 then
          local end_line = vim.api.nvim_buf_get_lines(0, args.line2 - 1, args.line2, true)[1]
          range = {
            start = { args.line1, 0 },
            ["end"] = { args.line2, end_line:len() },
          }
        end
        conform.format({ async = true, lsp_fallback = true, range = range })
      end, { range = true })
    end,
  },
}

