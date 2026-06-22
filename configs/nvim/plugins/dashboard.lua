return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false, -- Must load on startup
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- 1. Custom Header (ASCII Art)
      dashboard.section.header.val = {
        "                               _______ ",
        "    ___  ___  ___  _  __ ___  |  ___  |",
        "   / _ \\/ _ \\/ _ \\| |/ // _ \\ | |___| |",
        "  |  __/  __/ (_) |   <|  __/ |  _____|",
        "   \\___|\\___|\\___/|_|\\_\\\\___| |_|      ",
        "                                       ",
      }

      -- 2. Menu Buttons (Text, Action shortcut, Hotkey mapping)
      dashboard.section.buttons.val = {
        dashboard.button("n", "  New File", "<cmd>ene <BAR> startinsert<CR>"),
        dashboard.button("f", "󰈞  Find File", "<cmd>Telescope find_files<CR>"),
        dashboard.button("r", "󰄉  Recent Files", "<cmd>Telescope oldfiles<CR>"),
        dashboard.button("c", "  Configure", "<cmd>e $MYVIMRC<CR>"),
        dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
      }

      -- 3. Dynamic Footer (Shows how many plugins Lazy loaded)
      local stats = require("lazy").stats()
      local total_plugins = stats.count
      dashboard.section.footer.val = "⚡ Loaded " .. total_plugins .. " plugins cleanly."

      -- Apply styling colors to components
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      alpha.setup(dashboard.opts)
    end,
  }
}
