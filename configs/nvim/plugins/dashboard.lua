return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- 1. Header (ASCII Art)
      dashboard.section.header.val = {
        "                               _______ ",
        "    ___  ___  ___  _  __ ___  |  ___  |",
        "   / _ \\/ _ \\/ _ \\| |/ // _ \\ | |___| |",
        "  |  __/  __/ (_) |   <|  __/ |  _____|",
        "   \\___|\\___|\\___/|_|\\_\\\\___| |_|      ",
        "                                       ",
      }

      -- 2. Menu Buttons
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New File", "<cmd>ene <BAR> startinsert<CR>"),
        dashboard.button("f", "󰈞  Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "󰄉  Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("c", "  Configure", "<cmd>e $MYVIMRC<CR>"),
        dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
      }

      -- 3. Dynamic Footer
      local stats = require("lazy").stats()
      dashboard.section.footer.val = "⚡ Loaded " .. stats.count .. " plugins cleanly."

      -- 4. Vertical Centering Logic
      -- This creates a dynamic top margin based on your terminal height
      local padding = {
        type = "padding",
        val = function()
          local total_lines = vim.o.lines
          local content_lines = #dashboard.section.header.val + (#dashboard.section.buttons.val * 2) + 10
          local top_padding = math.max(2, math.floor((total_lines - content_lines) / 2) - 2)
          return top_padding
        end,
      }

      -- Reconstruct the full layout with the top padding included
      dashboard.config.layout = {
        padding, -- Injected blank lines at the top
        dashboard.section.header,
        { type = "padding", val = 2 }, -- Space between header and buttons
        dashboard.section.buttons,
        { type = "padding", val = 2 }, -- Space between buttons and footer
        dashboard.section.footer,
      }

      -- Apply highlight groups
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      alpha.setup(dashboard.config)
    end,
  }
}
