return {
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    dependencies = { "nvim-web-devicons" },
    opts = function()
      local theme = require("config.theme")
      local colors = {}
      local json = vim.fn.readfile(vim.fn.expand("~/.cache/matugen/colors.json"))
      if json then
        local content = table.concat(json, "")
        local function extract(key)
          return content:match('"' .. key .. '":%s*"(#%x+)"')
        end
        colors = {
          bg = extract("surface"),
          bg2 = extract("surface_variant"),
          fg = extract("on_surface"),
          fg_muted = extract("on_surface_variant"),
          primary = extract("primary"),
          on_primary = extract("on_primary"),
          secondary = extract("secondary"),
          tertiary = extract("tertiary"),
          error = extract("error"),
          outline = extract("outline"),
          bg_hl = extract("surface_container_high"),
          bg_sel = extract("primary_container"),
          fg_sel = extract("on_primary_container"),
        }
      end

      local lualine_theme = {
        normal = {
          a = { fg = colors.on_primary or "#1e1e2e", bg = colors.primary or "#89b4fa", gui = "bold" },
          b = { fg = colors.fg or "#cdd6f4", bg = colors.bg2 or "#313244" },
          c = { fg = colors.fg or "#cdd6f4", bg = colors.bg or "#1e1e2e" },
        },
        insert = {
          a = { fg = colors.on_primary or "#1e1e2e", bg = colors.secondary or "#a6e3a1", gui = "bold" },
          b = { fg = colors.fg or "#cdd6f4", bg = colors.bg2 or "#313244" },
        },
        visual = {
          a = { fg = colors.on_primary or "#1e1e2e", bg = colors.tertiary or "#f9e2af", gui = "bold" },
          b = { fg = colors.fg or "#cdd6f4", bg = colors.bg2 or "#313244" },
        },
        replace = {
          a = { fg = colors.on_primary or "#1e1e2e", bg = colors.error or "#f38ba8", gui = "bold" },
          b = { fg = colors.fg or "#cdd6f4", bg = colors.bg2 or "#313244" },
        },
        command = {
          a = { fg = colors.on_primary or "#1e1e2e", bg = colors.tertiary or "#fab387", gui = "bold" },
          b = { fg = colors.fg or "#cdd6f4", bg = colors.bg2 or "#313244" },
        },
        inactive = {
          a = { fg = colors.fg_muted or "#6c7086", bg = colors.bg2 or "#313244", gui = "bold" },
          b = { fg = colors.fg_muted or "#6c7086", bg = colors.bg2 or "#313244" },
          c = { fg = colors.fg_muted or "#6c7086", bg = colors.bg or "#1e1e2e" },
        },
      }

      return {
        options = {
          theme = lualine_theme,
          globalstatus = true,
          disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
          component_separators = { left = "│", right = "│" },
          section_separators = { left = "", right = "" },
          refresh = { statusline = 1000, tabline = 1000, winbar = 1000 },
        },
        sections = {
          lualine_a = { { "mode", icon = "󰀘" } },
          lualine_b = {
            { "branch", icon = "󰊢" },
            { "diff", symbols = { added = " ", modified = " ", removed = " " } },
            { "diagnostics", sources = { "nvim_diagnostic" }, symbols = { error = " ", warn = " ", info = " ", hint = " " } },
          },
          lualine_c = {
            { "filename", path = 1, symbols = { modified = " ●", readonly = " ", unnamed = "" } },
            { "navic", color_correction = "dynamic" },
          },
          lualine_x = {
            { require("lazy.status").updates, cond = require("lazy.status").has_updates, color = { fg = "#fab387" } },
            { "encoding" },
            { "fileformat", icons = { unix = "LF", dos = "CRLF", mac = "CR" } },
            { "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
          },
          lualine_y = { { "progress", separator = "", padding = { left = 1, right = 0 } }, { "location", padding = { left = 0, right = 1 } } },
          lualine_z = { { "datetime", style = "%H:%M", icon = "󰥔" } },
        },
        extensions = { "neo-tree", "lazy", "trouble", "mason" },
      }
    end,
  },
  {
    "akinsho/bufferline.nvim",
    event = "VeryLazy",
    keys = {
      { "<leader>bp", "<Cmd>BufferLineTogglePin<CR>", desc = "Toggle Pin" },
      { "<leader>bP", "<Cmd>BufferLineGroupClose ungrouped<CR>", desc = "Delete Non-Pinned Buffers" },
      { "<leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Delete Other Buffers" },
      { "<leader>br", "<Cmd>BufferLineCloseRight<CR>", desc = "Delete Buffers to the Right" },
      { "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", desc = "Delete Buffers to the Left" },
      { "[b", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev Buffer" },
      { "]b", "<cmd>BufferLineCycleNext<cr>", desc = "Next Buffer" },
      { "[B", "<cmd>BufferLineMovePrev<cr>", desc = "Move Buffer Prev" },
      { "]B", "<cmd>BufferLineMoveNext<cr>", desc = "Move Buffer Next" },
    },
    opts = {
      options = {
        diagnostics = "nvim_lsp",
        always_show_bufferline = false,
        diagnostics_indicator = function(_, _, diag)
          local icons = { error = " ", warning = " ", info = " ", hint = " " }
          local ret = (diag.error and icons.error .. diag.error .. " " or "")
            .. (diag.warning and icons.warning .. diag.warning or "")
          return vim.trim(ret)
        end,
        offsets = {
          { filetype = "neo-tree", text = "Explorer", highlight = "Directory", text_align = "left" },
        },
        show_buffer_close_icons = true,
        show_close_icon = false,
        separator_style = "slant",
        enforce_regular_tabs = false,
        always_show_bufferline = true,
        hover = { enabled = true, delay = 200, reveal = { "close" } },
        sort_by = "insert_after_current",
      },
      highlights = {
        fill = { bg = "#1e1e2e" },
        background = { bg = "#1e1e2e", fg = "#6c7086" },
        buffer_selected = { bg = "#1e1e2e", fg = "#cdd6f4", bold = true, italic = false },
        separator = { fg = "#313244", bg = "#1e1e2e" },
        separator_selected = { fg = "#89b4fa", bg = "#1e1e2e" },
        separator_visible = { fg = "#313244", bg = "#1e1e2e" },
        close_button = { fg = "#6c7086", bg = "#1e1e2e" },
        close_button_selected = { fg = "#f38ba8", bg = "#1e1e2e" },
        close_button_visible = { fg = "#6c7086", bg = "#1e1e2e" },
        tab = { bg = "#1e1e2e", fg = "#6c7086" },
        tab_selected = { bg = "#1e1e2e", fg = "#89b4fa", bold = true },
        tab_close = { bg = "#1e1e2e", fg = "#f38ba8" },
        indicator_selected = { fg = "#89b4fa", bg = "#1e1e2e" },
      },
    },
    config = function(_, opts)
      require("bufferline").setup(opts)
      vim.api.nvim_create_autocmd({ "BufAdd", "BufDelete" }, {
        callback = function()
          vim.schedule(function() pcall(nvim_bufferline) end)
        end,
      })
    end,
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      delay = 200,
      filter = function(mapping) return mapping.desc and mapping.desc ~= "" end,
      spec = {
        { "<leader>b", group = "buffer" },
        { "<leader>c", group = "code" },
        { "<leader>d", group = "debug" },
        { "<leader>f", group = "find" },
        { "<leader>g", group = "git" },
        { "<leader>l", group = "lazy" },
        { "<leader>u", group = "ui" },
        { "<leader>w", group = "windows" },
        { "[", group = "prev" },
        { "]", group = "next" },
        { "g", group = "goto" },
      },
    },
    keys = {
      { "<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Keymaps (which-key)" },
      { "<c-w><space>", function() require("which-key").show({ keys = "<c-w>", loop = true }) end, desc = "Window Hydra Mode (which-key)" },
    },
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {
      indent = { char = "│", tab_char = "│" },
      scope = { enabled = true, show_start = true, show_end = true, injected_languages = false, highlight = { "Function", "Label" } },
      exclude = { filetypes = { "help", "alpha", "dashboard", "neo-tree", "Trouble", "lazy", "mason", "notify", "toggleterm", "lazyterm" } },
    },
  },
  {
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = {
      notification = { window = { winblend = 0, border = "rounded", normal_hl = "Normal", max_width = 80, min_width = 30 } },
      progress = { display = { done_icon = "✓", progress_icon = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" } } },
    },
  },
}