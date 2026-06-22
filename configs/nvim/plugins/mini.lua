return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.pairs").setup()
    require("mini.ai").setup()
    require("mini.cursorword").setup()
    require("mini.indentscope").setup({
      symbol = "│",
      draw = {
        delay = 10,
        animation = require("mini.indentscope").gen_animation.linear({
          duration = 15,
          unit = "step",
          easing = "out",
        }),
      },
    })
    require("mini.trailspace").setup()
    require("mini.sessions").setup({
      autoread = true,
      autowrite = true,
      file = ".session",
      force = { read = false, write = true, delete = true },
    })
    require("mini.surround").setup()
    require("mini.move").setup({
      mappings = { down = "J", up = "K" },
    })
    require("mini.icons").setup()
    require("mini.animate").setup({
      cursor = { enable = false },
      scroll = {
        timing = require("mini.animate").gen_timing.linear({ duration = 100, unit = "total" }),
        subscroll = require("mini.animate").gen_subscroll.equal({ max_output_steps = 60 }),
      },
    })
  end,
}
