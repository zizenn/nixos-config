return {
  "nvim-telescope/telescope.nvim",
  branch = "master",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = "▎",
        layout_strategy = "horizontal",
        layout_config = {
          width = 0.85,
          height = 0.80,
          preview_width = 0.55,
          horizontal = {
            prompt_position = "top",
          },
        },
        borderchars = {
          prompt = { "─", "│", "─", "│", "┌", "┐", "└", "┘" },
          results = { "─", "│", "─", "│", "┌", "┐", "└", "┘" },
          preview = { "─", "│", "─", "│", "┌", "┐", "└", "┘" },
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
            ["<CR>"] = actions.select_default,
          },
        },
      },
      pickers = {
        find_files = { hidden = true },
        live_grep = { additional_args = { "--hidden" } },
      },
      extensions = {
        fzf = {
          fuzzy = true,
          override_generic_sorter = true,
          override_file_sorter = true,
          case_mode = "smart_case",
        },
      },
    })

    telescope.load_extension("fzf")
  end,
}
