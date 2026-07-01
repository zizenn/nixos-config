return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  -- Use cmd instead of keys to lazy-load Neo-tree only when called
  cmd = "Neotree", 
  opts = {
    close_if_last_window = true,
    enable_git_status = true,
    enable_diagnostics = true,
    default_component_configs = {
      icon = {
        folder_closed = "",
        folder_open = "",
        default = "*",
      },
    },
    window = {
      position = "right",
      width = 30,
      mappings = {
        ["<cr>"] = "open",
        ["v"] = "open_vsplit",
        ["s"] = "open_split",
        ["P"] = { "toggle_preview", config = { use_float = false } },
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      follow_current_file = { enable = true },
    },
  },
}

