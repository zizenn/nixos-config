return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    close_if_last_window = true,
    popup_border_style = "rounded",
    enable_git_status = true,
    enable_diagnostics = true,
    nesting_rules = {
      ["package.json"] = { pattern = "^package%.json$", files = { "package-lock.json", "yarn.lock" } },
      ["tsconfig.json"] = { pattern = "^tsconfig%.json$", files = { "tsconfig.*.json" } },
    },
    default_component_configs = {
      indent = {
        with_expanders = true,
        expander_collapsed = "",
        expander_expanded = "",
      },
      icon = {
        folder_closed = "",
        folder_open = "",
        folder_empty = "",
      },
      git_status = {
        symbols = {
          added = "✚",
          deleted = "✖",
          modified = "",
          renamed = "󰁕",
          untracked = "",
          ignored = "",
          unstaged = "󰄱",
          staged = "",
          conflict = "",
        },
      },
    },
    filesystem = {
      filtered_items = {
        visible = false,
        hide_dotfiles = false,
        hide_gitignored = false,
        never_show = { ".DS_Store" },
      },
      follow_current_file = {
        enabled = true,
        leave_dirs_open = false,
      },
      use_libuv_file_watcher = true,
    },
    window = {
      position = "right",
      width = 40,
      mapping_options = {
        noremap = true,
        nowait = true,
      },
      mappings = {
        ["<cr>"] = "open",
        ["v"] = "open_vsplit",
        ["s"] = "open_split",
        ["P"] = "toggle_preview",
        ["h"] = "parent_or_close",
        ["l"] = "child_or_open",
        ["a"] = { "add", config = { show_path = "relative" } },
        ["d"] = "delete",
        ["r"] = "rename",
        ["c"] = "copy_to_clipboard",
        ["p"] = "paste_from_clipboard",
        ["q"] = "close_window",
      },
    },
  },
}
