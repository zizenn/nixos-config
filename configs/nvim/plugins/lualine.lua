return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local matugen_theme = {
      normal = {
        a = { bg = "NONE", fg = "#DCD7BA", gui = "bold" },
        b = { bg = "NONE", fg = "#DCD7BA" },
        c = { bg = "NONE", fg = "#DCD7BA" },
      },
      insert = {
        a = { bg = "NONE", fg = "#7E9CD8", gui = "bold" },
        b = { bg = "NONE", fg = "#DCD7BA" },
        c = { bg = "NONE", fg = "#DCD7BA" },
      },
      visual = {
        a = { bg = "NONE", fg = "#957FB8", gui = "bold" },
        b = { bg = "NONE", fg = "#DCD7BA" },
        c = { bg = "NONE", fg = "#DCD7BA" },
      },
      replace = {
        a = { bg = "NONE", fg = "#E46876", gui = "bold" },
        b = { bg = "NONE", fg = "#DCD7BA" },
        c = { bg = "NONE", fg = "#DCD7BA" },
      },
      command = {
        a = { bg = "NONE", fg = "#98BB6C", gui = "bold" },
        b = { bg = "NONE", fg = "#DCD7BA" },
        c = { bg = "NONE", fg = "#DCD7BA" },
      },
      inactive = {
        a = { bg = "NONE", fg = "#727169" },
        b = { bg = "NONE", fg = "#727169" },
        c = { bg = "NONE", fg = "#727169" },
      },
    }

    require("lualine").setup({
      options = {
        theme = matugen_theme,
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        globalstatus = true,
        disabled_filetypes = { "neo-tree", "alpha", "TelescopePrompt" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = {
          {
            "filename",
            path = 1,
            symbols = { modified = " ●", readonly = " ", unnamed = " [No Name]" },
          },
        },
        lualine_x = { "encoding", "fileformat", "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
      },
    })
  end,
}
