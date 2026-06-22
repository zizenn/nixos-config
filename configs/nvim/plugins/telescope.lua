return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "Telescope",
  init = function()
    -- Telescope still uses the old nvim-treesitter API
    -- Provide polyfills since the modules were restructured in recent versions

    -- Polyfill nvim-treesitter.parsers (now a metadata table, not a module)
    local ok_parsers, parsers = pcall(require, "nvim-treesitter.parsers")
    if ok_parsers and type(parsers) == "table" and not parsers.ft_to_lang then
      parsers.ft_to_lang = function(ft)
        local ok, lang = pcall(vim.treesitter.language.get_lang, ft)
        if ok and lang then return lang end
        local map = { sh = "bash", zsh = "bash" }
        return map[ft] or ft
      end
      parsers.get_parser = function(bufnr, lang)
        return vim.treesitter.get_parser(bufnr, lang)
      end
    end

    -- Polyfill nvim-treesitter.configs (this module doesn't exist anymore)
    if not package.loaded["nvim-treesitter.configs"] then
      package.loaded["nvim-treesitter.configs"] = {
        is_enabled = function() return true end,
        get_module = function()
          return { additional_vim_regex_highlighting = false }
        end,
      }
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
