return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "Telescope",
  init = function()
    -- Polyfill ft_to_lang for telescope <-> treesitter compatibility
    local ok, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok and not parsers.ft_to_lang then
      parsers.ft_to_lang = function(ft)
        local lang = parsers.filetype_to_parsername(ft)
        return lang or ft
      end
    end
  end,
  opts = function()
    local actions = require("telescope.actions")

    return {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = "move_selection_next",
            ["<C-k>"] = "move_selection_previous",
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
          n = {
            ["<C-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = { additional_args = { "--hidden" } },
      },
    }
  end,
}
