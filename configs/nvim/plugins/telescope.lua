return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  cmd = "Telescope",
  keys = {
    { "<leader>f", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>sg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>sb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>sh", "<cmd>Telescope help_tags<CR>", desc = "Help tags" },
    { "<leader>sk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    { "<leader>so", "<cmd>Telescope oldfiles<CR>", desc = "Recent files" },
    { "<leader>s.", "<cmd>Telescope resume<CR>", desc = "Resume last picker" },
    { "gr", "<cmd>Telescope lsp_references<CR>", desc = "LSP references" },
  },
  init = function()
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
