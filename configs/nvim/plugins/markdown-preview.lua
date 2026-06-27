return {
  "MeanderingProgrammer/render-markdown.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  ft = { "markdown", "telekasten" },
  opts = {
    file_types = { "markdown", "telekasten" },
    render_modes = { "n", "c", "t" },
    anti_conceal = {
      enabled = true,
      ignore = { code_background = true, sign = true },
      above = 0,
      below = 0,
    },
    heading = {
      enabled = true,
      sign = true,
      position = "overlay",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      backgrounds = {
        "RenderMarkdownH1Bg",
        "RenderMarkdownH2Bg",
        "RenderMarkdownH3Bg",
        "RenderMarkdownH4Bg",
        "RenderMarkdownH5Bg",
        "RenderMarkdownH6Bg",
      },
      foregrounds = {
        "RenderMarkdownH1",
        "RenderMarkdownH2",
        "RenderMarkdownH3",
        "RenderMarkdownH4",
        "RenderMarkdownH5",
        "RenderMarkdownH6",
      },
    },
    code = {
      enabled = true,
      sign = true,
      style = "full",
      position = "left",
      language_pad = 0,
      disable_background = { "diff" },
      width = "full",
      left_margin = 0,
      left_pad = 0,
      right_pad = 0,
      min_width = 0,
      border = "thin",
      above = "▄",
      below = "▀",
      highlight = "RenderMarkdownCode",
      highlight_inline = "RenderMarkdownCodeInline",
    },
    dash = {
      enabled = true,
      icon = "─",
      width = "full",
      highlight = "RenderMarkdownDash",
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      ordered_icons = function(ctx)
        local value = vim.trim(ctx.value)
        local index = tonumber(value:sub(1, #value - 1))
        return string.format("%d.", index)
      end,
      left_pad = 0,
      right_pad = 1,
      highlight = "RenderMarkdownBullet",
    },
    checkbox = {
      enabled = true,
      position = "inline",
      unchecked = { icon = "󰄱 ", highlight = "RenderMarkdownUnchecked" },
      checked = { icon = "󰱒 ", highlight = "RenderMarkdownChecked" },
      custom = {
        todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownTodo" },
        important = { raw = "[!]", rendered = "󰀪 ", highlight = "RenderMarkdownImportant" },
      },
    },
    quote = {
      enabled = true,
      icon = "▋",
      repeat_linebreak = true,
      highlight = "RenderMarkdownQuote",
    },
    pipe_table = {
      enabled = true,
      preset = "round",
      style = "full",
      cell = "padded",
      min_width = 0,
      border = { "┌", "┬", "┐", "├", "┼", "┤", "└", "┴", "┘", "│", "─" },
      alignment_indicator = "━",
      head = "RenderMarkdownTableHead",
      row = "RenderMarkdownTableRow",
      filler = "RenderMarkdownTableFill",
    },
    callout = {
      note = { raw = "[!NOTE]", rendered = "󰋽 Note", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = "󰌶 Tip", highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅾 Important", highlight = "RenderMarkdownHint" },
      warning = { raw = "[!WARNING]", rendered = "󰀪 Warning", highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = "󰳦 Caution", highlight = "RenderMarkdownError" },
    },
    link = {
      enabled = true,
      image = "󰥶 ",
      email = "󰀓 ",
      hyperlink = "󰌹 ",
      highlight = "RenderMarkdownLink",
      wiki = { icon = "󱗖 ", highlight = "RenderMarkdownWikiLink" },
      custom = {
        telekasten = { pattern = "^telekasten://", icon = "󰋚 ", highlight = "RenderMarkdownLink" },
      },
    },
    sign = {
      enabled = true,
      highlight = "RenderMarkdownSign",
    },
    indent = {
      enabled = true,
      skip_level = 1,
      icon = "│",
      highlight = "RenderMarkdownIndent",
    },
    win_options = {
      conceallevel = { default = 3, rendered = 3 },
      concealcursor = { default = "", rendered = "nvc" },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = { "markdown", "telekasten" },
      callback = function()
        vim.keymap.set("n", "<leader>mp", "<cmd>RenderMarkdown toggle<CR>", { buffer = true, desc = "Toggle markdown preview" })
      end,
    })
  end,
}