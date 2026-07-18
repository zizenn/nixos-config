return {
      {
            "stevearc/conform.nvim",
            event = { "BufReadPre", "BufNewFile" }, -- Load when opening a file
            config = function()
                  local conform = require("conform")

                  conform.setup({
                        formatters_by_ft = {
                              lua = { "stylua" },
                              python = { "autopep8" },
                              javascript = { "prettier" },
                              typescript = { "prettier" },
                              html = { "prettier" },
                              css = { "prettier" },
                              -- FIX 1: Changed hyphens to underscores to match conform's internal names
                              c = { "clang_format" },
                              cpp = { "clang_format" },
                        },

                        format_on_save = {
                              lsp_fallback = true,
                              async = false,
                              timeout_ms = 500,
                        },

                        formatters = {
                              stylua = {
                                    prepend_args = { "--indent-width", "6" },
                              },
                              prettier = {
                                    prepend_args = { "--tab-width", "6" },
                              },
                              autopep8 = {
                                    prepend_args = { "--indent-size", "6" },

                              },
                              -- FIX 2: Switched key name to underscore and added full indentation rules
                              ["clang_format"] = {
                                    prepend_args = {
                                          "-style={BasedOnStyle: LLVM, IndentWidth: 6, ContinuationIndentWidth: 6, AccessModifierOffset: -6}"
                                    },
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
