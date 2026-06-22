return {
  {
    "goolord/alpha-nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    config = function()
      local alpha = require("alpha")
      local dashboard = require("alpha.themes.dashboard")

      -- 1. Custom Braille Emblem
      dashboard.section.header.val = {
        "⠀⠀⠀⡠⠀⡌⠀⠀⠀⠀⠀⠀⠀⠀⢡⠀⢄⠀⠀⠀",
        "⠀⠀⣰⠃⣸⠁⠀⠀⠀⠀⠀⠀⠀⠀⠈⣇⠘⣆⠀⠀",
        "⠀⢀⡏⢠⡿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢻⡄⢹⡀⠀",
        "⠀⣸⡇⠘⠷⢖⣒⡲⣤⣤⣤⣤⢖⣒⡲⠾⠃⢸⣇⠀",
        "⠀⠻⠷⠚⠋⣩⡭⢭⣿⣿⣿⣿⡭⢭⣍⠙⠓⠾⠟⠀",
        "⠀⠀⢀⣠⠞⢉⣴⠏⣽⣿⣿⣯⠹⣦⡍⠳⣄⡀⠀⠀",
        "⣤⡴⠋⠁⠀⢸⣿⠀⢸⣿⣿⡏⠀⣿⡇⠀⠈⠙⢶⣤",
        "⢹⡇⠀⠀⠀⢸⣿⠀⠈⣿⣿⠁⠀⣿⡇⠀⠀⠀⢸⡟",
        "⠸⡇⠀⠀⠀⠀⣿⠀⠀⠘⠃⠀⠀⣿⠁⠀⠀⠀⢸⡇",
        "⠀⢷⠀⠀⠀⠀⣿⠀⠀⠀⠀⠀⠀⣿⠀⠀⠀⠀⡾⠀",
        "⠀⠘⡄⠀⠀⠀⢸⠀⠀⠀⠀⠀⠀⡇⠀⠀⠀⢠⠃⠀",
        "⠀⠀⠐⠀⠀⠀⠈⠇⠀⠀⠀⠀⢸⠁⠀⠀⠀⠂⠀⠀",
        "⠀⠀⠀⠀⠀⠀⠀⠘⠄⠀⠀⠠⠃⠀⠀⠀⠀⠀⠀⠀",
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

      -- 4. Dynamic Vertical Centering Calculation
      local padding = {
        type = "padding",
        val = function()
          local total_lines = vim.o.lines
          -- Fine-tuned offset logic to pull the layout perfectly into dead-center
          local content_lines = #dashboard.section.header.val + (#dashboard.section.buttons.val * 2) + 4
          local top_padding = math.max(2, math.floor((total_lines - content_lines) / 2) - 4)
          return top_padding
        end,
      }

      -- Assemble Layout
      dashboard.config.layout = {
        padding,
        dashboard.section.header,
        { type = "padding", val = 2 },
        dashboard.section.buttons,
        { type = "padding", val = 2 },
        dashboard.section.footer,
      }

      -- Highlight colors matching your setup
      dashboard.section.header.opts.hl = "AlphaHeader"
      dashboard.section.buttons.opts.hl = "AlphaButtons"
      dashboard.section.footer.opts.hl = "AlphaFooter"

      -- 5. Autocommands to hide/show UI elements dynamically
      local group = vim.api.nvim_create_augroup("AlphaUIHooks", { clear = true })
      
      -- Hide lines, status columns, and ~ tildes when Alpha opens
      vim.api.nvim_create_autocmd("User", {
        pattern = "AlphaReady",
        group = group,
        callback = function()
          vim.opt_local.fillchars = { eob = " " } -- Hides the tilde symbols completely
          vim.opt_local.laststatus = 0            -- Hides statusline
          vim.opt_local.ruler = false             -- Hides coordinate position display
        end,
      })

      -- Restore everything cleanly the moment you move away from the dashboard
      vim.api.nvim_create_autocmd("BufUnload", {
        buffer = 0,
        group = group,
        callback = function()
          vim.opt.laststatus = 3                  -- Globally restores statusline (adjust to 2 if not using global status)
          vim.opt.ruler = true
        end,
      })

      alpha.setup(dashboard.config)
    end,
  }
}
