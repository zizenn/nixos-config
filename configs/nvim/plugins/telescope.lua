return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-telescope/telescope-file-browser.nvim",
    "nvim-telescope/telescope-ui-select.nvim",
    {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      cond = function()
        return vim.fn.executable("make") == 1 and vim.fn.executable("gcc") == 1
      end,
    },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "Find files" },
    { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    { "<leader>fn", "<cmd>Telescope file_browser<CR>", desc = "File browser" },
    { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
    { "<leader>fs", "<cmd>Telescope symbols<CR>", desc = "Symbols" },
    { "<leader>fh", "<cmd>Telescope help_tags<CR>", desc = "Help" },
    { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "Keymaps" },
    { "<leader>fo", "<cmd>Telescope oldfiles<CR>", desc = "Recent" },
    { "<leader>f.", "<cmd>Telescope resume<CR>", desc = "Resume" },
    { "gr", "<cmd>Telescope lsp_references<CR>", desc = "References" },
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
        file_ignore_patterns = { ".git", "%.csv", ".venv", "node_modules", ".svelte-kit", ".vscode" },
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
        buffers = { show_all_buffers = true },
        find_files = { hidden = true },
        live_grep = { additional_args = { "--hidden" } },
      },
      extensions = {
        file_browser = { theme = "ivy", hijack_netrw = true },
        ["ui-select"] = { require("telescope.themes").get_dropdown({}) },
      },
    }
  end,
  config = function(_, opts)
    local telescope = require("telescope")
    telescope.setup(opts)
    telescope.load_extension("file_browser")
    telescope.load_extension("ui-select")
    pcall(telescope.load_extension, "fzf")
  end,
}
