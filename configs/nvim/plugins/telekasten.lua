return {
  "renerocksai/telekasten.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },
  cmd = { "TelekastenFindNotes", "TelekastenFindDailyNotes", "TelekastenNewNote", "TelekastenFollowLink" },
  keys = {
    { "<leader>zf", "<cmd>Telekasten find_notes<CR>", desc = "Find notes" },
    { "<leader>zd", "<cmd>Telekasten find_daily_notes<CR>", desc = "Find daily notes" },
    { "<leader>zn", "<cmd>Telekasten new_note<CR>", desc = "New note" },
    { "<leader>zt", "<cmd>Telekasten goto_today<CR>", desc = "Go to today's note" },
    { "<leader>zy", "<cmd>Telekasten goto_yesterday<CR>", desc = "Go to yesterday's note" },
    { "<leader>zw", "<cmd>Telekasten goto_thisweek<CR>", desc = "Go to this week's note" },
    { "<leader>zp", "<cmd>Telekasten preview_img<CR>", desc = "Preview image" },
    { "<leader>zl", "<cmd>Telekasten follow_link<CR>", desc = "Follow link" },
    { "<leader>zb", "<cmd>Telekasten show_backlinks<CR>", desc = "Show backlinks" },
    { "<leader>zr", "<cmd>Telekasten rename_note<CR>", desc = "Rename note" },
    { "<leader>z/", "<cmd>Telekasten search_notes<CR>", desc = "Search notes" },
    { "<leader>zg", "<cmd>Telekasten grep_notes<CR>", desc = "Grep notes" },
    { "<leader>zt", "<cmd>Telekasten toggle_todo<CR>", desc = "Toggle todo" },
  },
  opts = {
    home = vim.fn.expand("~/notes"),
    take_over_my_home = false,
    auto_set_filetype = true,
    dailies = vim.fn.expand("~/notes/daily"),
    weeklies = vim.fn.expand("~/notes/weekly"),
    templates = vim.fn.expand("~/notes/templates"),
    image_subdir = "img",
    extension = ".md",
    new_note_filename = "title",
    follow_creates_nonexisting = true,
    dailies_create_nonexisting = true,
    weeklies_create_nonexisting = true,
    template_new_note = vim.fn.expand("~/notes/templates/new_note.md"),
    template_new_daily = vim.fn.expand("~/notes/templates/daily.md"),
    template_new_weekly = vim.fn.expand("~/notes/templates/weekly.md"),
    subdirs_in_links = true,
    template_handling = "prefer_new_note",
    new_note_location = "smart",
    sort = "filename",
    plug_into_calendar = true,
    calendar_opts = {
      weeknm = 4,
      calendar_monday = 1,
      calendar_mark = "left-fit",
    },
    telescope = {
      mappings = {
        i = {
          ["<CR>"] = "telekasten_goto_note",
          ["<C-l>"] = "telekasten_follow_link",
          ["<C-n>"] = "telekasten_new_note",
          ["<C-d>"] = "telekasten_new_daily_note",
          ["<C-w>"] = "telekasten_new_weekly_note",
        },
        n = {
          ["<CR>"] = "telekasten_goto_note",
          ["l"] = "telekasten_follow_link",
          ["n"] = "telekasten_new_note",
          ["d"] = "telekasten_new_daily_note",
          ["w"] = "telekasten_new_weekly_note",
        },
      },
    },
    ui = {
      get_daily_title = function(date)
        return date
      end,
      get_weekly_title = function(date)
        return "Week " .. vim.fn.strftime("%V", date)
      end,
    },
    media_previewer = {
      cmd = "viu",
      args = { "-w", "60" },
    },
  },
  config = function(_, opts)
    require("telekasten").setup(opts)
    local telescope = require("telescope")
    pcall(telescope.load_extension, "telekasten")
  end,
}